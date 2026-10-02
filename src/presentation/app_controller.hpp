#pragma once
#include <QObject>
#include <QString>
#include <memory>
#include "workflow/agent_workflow.hpp"
#include "modules/storage/db_manager.hpp"

class AppController : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isGenerating READ isGenerating NOTIFY isGeneratingChanged)
    Q_PROPERTY(bool isExpanded READ isExpanded WRITE setExpanded NOTIFY isExpandedChanged)

public:
    explicit AppController(QObject *parent = nullptr);


    ~AppController() override = default;

    bool isGenerating() const { return m_isGenerating; }
    bool isExpanded() const { return m_isExpanded; }
    void setExpanded(bool expanded);

    Q_INVOKABLE void sendMessage(const QString &text);
    Q_INVOKABLE void stopGeneration();
    Q_INVOKABLE void clearHistory();

signals:
    void isGeneratingChanged();
    void isExpandedChanged();
    void tokenReceived(const QString &token);
    void messageCompleted(const QString &fullReply);

private:
    bool m_isGenerating{false};
    bool m_isExpanded{false};
    std::shared_ptr<DbManager> m_db;
    std::unique_ptr<AgentWorkflow> m_workflow;
};
