#pragma once
#include <QObject>
#include <QString>
#include <memory>
#include "modules/ai/ai_provider.hpp"
#include "modules/storage/db_manager.hpp"
#include "plugins/tool_registry.hpp"

class AgentWorkflow : public QObject {
    Q_OBJECT

public:
    explicit AgentWorkflow(
        std::shared_ptr<IAIProvider> ai,
        std::shared_ptr<DbManager> db,
        std::shared_ptr<ToolRegistry> tools,
        QObject *parent = nullptr
    );
    ~AgentWorkflow() override = default;

    void processUserMessage(const QString &input);
    void stop();

signals:
    void tokenStreamed(const QString &token);
    void workflowCompleted(const QString &finalReply);
    void toolExecuted(const QString &toolName, const QString &result);

private:
    std::shared_ptr<IAIProvider> m_ai;
    std::shared_ptr<DbManager> m_db;
    std::shared_ptr<ToolRegistry> m_tools;
};
