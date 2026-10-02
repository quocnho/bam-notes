#include "tool_registry.hpp"

ToolRegistry::ToolRegistry() = default;

void ToolRegistry::registerTool(std::shared_ptr<IAgentTool> tool) {
    if (tool) {
        m_tools[tool->name()] = tool;
    }
}

std::shared_ptr<IAgentTool> ToolRegistry::findTool(const QString &name) const {
    auto it = m_tools.find(name);
    return (it != m_tools.end()) ? it->second : nullptr;
}

QJsonArray ToolRegistry::exportToolsPromptSchema() const {
    QJsonArray array;
    for (const auto &[name, tool] : m_tools) {
        QJsonObject obj;
        obj["name"] = tool->name();
        obj["description"] = tool->description();
        obj["parameters"] = tool->parametersSchema();
        array.append(obj);
    }
    return array;
}

QString ToolRegistry::executeTool(const QString &name, const QJsonObject &args) {
    auto tool = findTool(name);
    if (!tool) {
        return QString("Lỗi: Tool '%1' không tồn tại.").arg(name);
    }
    return tool->execute(args);
}
