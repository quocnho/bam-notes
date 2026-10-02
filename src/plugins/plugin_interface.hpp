#pragma once
#include <QString>
#include <QJsonObject>
#include <memory>

class IAgentTool {
public:
    virtual ~IAgentTool() = default;

    virtual QString name() const = 0;
    virtual QString description() const = 0;
    virtual QJsonObject parametersSchema() const = 0;
    virtual QString execute(const QJsonObject &args) = 0;
};
