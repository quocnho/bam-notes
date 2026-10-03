#include "app_controller.hpp"
#include "modules/ai/llama_engine.hpp"
#include "plugins/builtins/memory_tool.cpp"

#include <QProcess>

AppController::AppController(QObject *parent)
    : QObject(parent),
      m_db(std::make_shared<DbManager>()) {

    m_db->initDatabase();

    // Mặc định bằng chế độ của hệ thống hoặc cài đặt đã lưu
    QString savedTheme = m_db->getSetting("app_theme", "");
    if (!savedTheme.isEmpty()) {
        m_isDarkTheme = (savedTheme == "dark");
    } else {
        QProcess p;
        p.start("gsettings", {"get", "org.gnome.desktop.interface", "color-scheme"});
        if (p.waitForFinished(500)) {
            QString out = QString::fromUtf8(p.readAllStandardOutput()).trimmed();
            m_isDarkTheme = !out.contains("prefer-light");
        }
    }

    auto ai = std::make_shared<LlamaEngine>();
    auto tools = std::make_shared<ToolRegistry>();
    tools->registerTool(std::make_shared<MemoryTool>());

    m_workflow = std::make_unique<AgentWorkflow>(ai, m_db, tools);

    connect(m_workflow.get(), &AgentWorkflow::tokenStreamed, this, [this](const QString &token) {
        emit tokenReceived(token);
    });

    connect(m_workflow.get(), &AgentWorkflow::workflowCompleted, this, [this](const QString &reply) {
        m_isGenerating = false;
        emit isGeneratingChanged();
        emit messageCompleted(reply);
    });
}

void AppController::setExpanded(bool expanded) {
    if (m_isExpanded != expanded) {
        m_isExpanded = expanded;
        emit isExpandedChanged();
    }
}

void AppController::sendMessage(const QString &text) {
    if (text.trimmed().isEmpty() || m_isGenerating) return;

    m_isGenerating = true;
    emit isGeneratingChanged();
    m_workflow->processUserMessage(text);
}

void AppController::stopGeneration() {
    if (m_isGenerating) {
        m_workflow->stop();
        m_isGenerating = false;
        emit isGeneratingChanged();
    }
}

#include <QGuiApplication>
#include <QClipboard>

void AppController::clearHistory() {
    m_db->clearHistory();
}

void AppController::copyToClipboard(const QString &text) {
    if (auto clip = QGuiApplication::clipboard()) {
        clip->setText(text);
    }
}

void AppController::savePosition(int x, int y) {
    m_db->setSetting("pos_x", QString::number(x));
    m_db->setSetting("pos_y", QString::number(y));
}

QPoint AppController::getSavedPosition(int defaultX, int defaultY) {
    QString xStr = m_db->getSetting("pos_x", QString::number(defaultX));
    QString yStr = m_db->getSetting("pos_y", QString::number(defaultY));
    return QPoint(xStr.toInt(), yStr.toInt());
}

void AppController::toggleDesktopTheme() {
    m_isDarkTheme = !m_isDarkTheme;
    m_db->setSetting("app_theme", m_isDarkTheme ? "dark" : "light");
    emit themeChanged();
}
