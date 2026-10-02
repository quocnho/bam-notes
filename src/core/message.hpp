#pragma once
#include <QString>
#include <QDateTime>
#include "types.hpp"

struct Message {
    qint64 id{0};
    MessageRole role{MessageRole::User};
    QString content;
    QDateTime timestamp{QDateTime::currentDateTime()};

    QString roleString() const {
        switch (role) {
            case MessageRole::User: return "user";
            case MessageRole::Assistant: return "assistant";
            case MessageRole::System: return "system";
            case MessageRole::Tool: return "tool";
        }
        return "user";
    }
};
