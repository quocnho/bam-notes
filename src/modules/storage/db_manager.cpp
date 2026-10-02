#include "db_manager.hpp"
#include <QStandardPaths>
#include <QDir>
#include <QDebug>

DbManager::DbManager() = default;

DbManager::~DbManager() {
    if (m_db) sqlite3_close(m_db);
}

QString DbManager::getDatabasePath() const {
    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(path);
    return path + "/bam_troly.sqlite";
}

bool DbManager::initDatabase() {
    std::lock_guard<std::mutex> lock(m_mutex);
    if (sqlite3_open(getDatabasePath().toUtf8().constData(), &m_db) != SQLITE_OK) {
        return false;
    }

    const char *pragma_wal = "PRAGMA journal_mode=WAL; PRAGMA synchronous=NORMAL;";
    sqlite3_exec(m_db, pragma_wal, nullptr, nullptr, nullptr);

    const char *create_sql = 
        "CREATE TABLE IF NOT EXISTS messages ("
        "  id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "  role TEXT NOT NULL,"
        "  content TEXT NOT NULL,"
        "  created_at DATETIME DEFAULT CURRENT_TIMESTAMP"
        ");";
    return sqlite3_exec(m_db, create_sql, nullptr, nullptr, nullptr) == SQLITE_OK;
}

bool DbManager::saveMessage(const QString &role, const QString &content) {
    std::lock_guard<std::mutex> lock(m_mutex);
    if (!m_db) return false;

    const char *insert_sql = "INSERT INTO messages (role, content) VALUES (?, ?);";
    sqlite3_stmt *stmt = nullptr;
    if (sqlite3_prepare_v2(m_db, insert_sql, -1, &stmt, nullptr) != SQLITE_OK) {
        return false;
    }

    sqlite3_bind_text(stmt, 1, role.toUtf8().constData(), -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 2, content.toUtf8().constData(), -1, SQLITE_TRANSIENT);
    
    bool ok = (sqlite3_step(stmt) == SQLITE_DONE);
    sqlite3_finalize(stmt);
    return ok;
}

std::vector<Message> DbManager::getRecentMessages(int limit) {
    std::lock_guard<std::mutex> lock(m_mutex);
    std::vector<Message> result;
    if (!m_db) return result;

    const char *query = "SELECT id, role, content FROM messages ORDER BY id DESC LIMIT ?;";
    sqlite3_stmt *stmt = nullptr;
    if (sqlite3_prepare_v2(m_db, query, -1, &stmt, nullptr) != SQLITE_OK) return result;

    sqlite3_bind_int(stmt, 1, limit);
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        Message msg;
        msg.id = sqlite3_column_int64(stmt, 0);
        QString roleStr = QString::fromUtf8(reinterpret_cast<const char*>(sqlite3_column_text(stmt, 1)));
        msg.role = (roleStr == "user") ? MessageRole::User : MessageRole::Assistant;
        msg.content = QString::fromUtf8(reinterpret_cast<const char*>(sqlite3_column_text(stmt, 2)));
        result.push_back(msg);
    }
    sqlite3_finalize(stmt);
    return result;
}

void DbManager::clearHistory() {
    std::lock_guard<std::mutex> lock(m_mutex);
    if (m_db) {
        sqlite3_exec(m_db, "DELETE FROM messages;", nullptr, nullptr, nullptr);
    }
}
