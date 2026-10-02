#pragma once
#include <QString>
#include <QJsonObject>
#include <QJsonArray>
#include <memory>
#include <vector>
#include <unordered_map>
#include "plugin_interface.hpp"

class ToolRegistry {
public:
    ToolRegistry();
    ~ToolRegistry() = default;

    void registerTool(std::shared_ptr<IAgentTool> tool);
    std::shared_ptr<IAgentTool> findTool(const QString &name) const;
    QJsonArray exportToolsPromptSchema() const;
    QString executeTool(const QString &name, const QJsonObject &args);

private:
    std::unordered_map<QString, std::shared_ptr<IAgentTool>> m_tools;
};
