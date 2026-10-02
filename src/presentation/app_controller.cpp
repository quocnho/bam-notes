#include "app_controller.hpp"
#include "modules/ai/llama_engine.hpp"
#include "plugins/builtins/memory_tool.cpp"

AppController::AppController(QObject *parent)
    : QObject(parent),
      m_db(std::make_shared<DbManager>()) {

    m_db->initDatabase();

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

void AppController::clearHistory() {
    m_db->clearHistory();
}
