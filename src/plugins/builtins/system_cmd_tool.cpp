#include "plugins/plugin_interface.hpp"
#include <QProcess>

class SystemCmdTool : public IAgentTool {
public:
    QString name() const override { return "run_system_command"; }
    QString description() const override { 
        return "Chạy lệnh hệ thống Bash trên BamOS hoặc CMD trên Windows."; 
    }

    QJsonObject parametersSchema() const override {
        QJsonObject schema;
        schema["type"] = "object";
        return schema;
    }

    QString execute(const QJsonObject &args) override {
        QString cmd = args["command"].toString();
        if (cmd.trimmed().isEmpty()) return "Lỗi: Lệnh rỗng.";

        QProcess process;
#ifdef Q_OS_WIN
        process.start("cmd.exe", QStringList() << "/c" << cmd);
#else
        process.start("/bin/sh", QStringList() << "-c" << cmd);
#endif
        process.waitForFinished(5000);
        return QString::fromUtf8(process.readAllStandardOutput());
    }
};
