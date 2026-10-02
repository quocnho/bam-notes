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

private:
    sqlite3 *m_db{nullptr};
    std::mutex m_mutex;
    QString getDatabasePath() const;
};
