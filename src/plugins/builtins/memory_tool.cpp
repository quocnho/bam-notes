#include "plugins/plugin_interface.hpp"
#include <QDateTime>

class MemoryTool : public IAgentTool {
public:
    QString name() const override { return "get_current_time"; }
    QString description() const override { 
        return "Lấy thời gian và ngày hiện tại của hệ thống."; 
    }

    QJsonObject parametersSchema() const override {
        return QJsonObject();
    }

    QString execute(const QJsonObject &) override {
        return QDateTime::currentDateTime().toString("yyyy-MM-dd HH:mm:ss");
    }
};
