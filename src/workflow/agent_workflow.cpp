#include "agent_workflow.hpp"
#include <QRegularExpression>

AgentWorkflow::AgentWorkflow(
    std::shared_ptr<IAIProvider> ai,
    std::shared_ptr<DbManager> db,
    std::shared_ptr<ToolRegistry> tools,
    QObject *parent
) : QObject(parent), m_ai(ai), m_db(db), m_tools(tools) {

    connect(m_ai.get(), &IAIProvider::tokenGenerated, this, &AgentWorkflow::tokenStreamed);
    connect(m_ai.get(), &IAIProvider::generationFinished, this, [this](const QString &reply) {
        m_db->saveMessage("assistant", reply);
        emit workflowCompleted(reply);
    });
}

void AgentWorkflow::processUserMessage(const QString &input) {
    m_db->saveMessage("user", input);

    if (input.startsWith("/time")) {
        QString timeResult = m_tools->executeTool("get_current_time", QJsonObject());
        QString reply = QString("⏱️ Thời gian hệ thống hiện tại: %1").arg(timeResult);
        m_db->saveMessage("assistant", reply);
        emit tokenStreamed(reply);
        emit workflowCompleted(reply);
        return;
    }

    m_ai->generateStreaming(input);
}

void AgentWorkflow::stop() {
    m_ai->stop();
}
