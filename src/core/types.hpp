#pragma once
#include <QString>

enum class MessageRole {
    User,
    Assistant,
    System,
    Tool
};

enum class AgentStatus {
    Idle,
    Reasoning,
    ExecutingTool,
    StreamingReply,
    Error
};
