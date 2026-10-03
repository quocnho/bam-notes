#pragma once
#include <QString>
#include <sqlite3.h>
#include <mutex>
#include <vector>
#include "core/message.hpp"

class DbManager {
public:
    DbManager();
    ~DbManager();

    bool initDatabase();
    bool saveMessage(const QString &role, const QString &content);
    std::vector<Message> getRecentMessages(int limit = 20);
    void clearHistory();
    bool setSetting(const QString &key, const QString &value);
    QString getSetting(const QString &key, const QString &defaultValue = "");

private:
    sqlite3 *m_db{nullptr};
    std::mutex m_mutex;
    QString getDatabasePath() const;
};
