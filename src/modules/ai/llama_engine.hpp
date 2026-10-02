#pragma once
#include <QObject>
#include <QString>
#include <thread>
#include <atomic>
#include "ai_provider.hpp"

struct llama_model;
struct llama_context;

class LlamaEngine : public IAIProvider {
    Q_OBJECT

public:
    explicit LlamaEngine(QObject *parent = nullptr);
    ~LlamaEngine() override;

    bool isReady() const override { return m_ctx != nullptr; }
    bool loadModel(const QString &modelPath);
    void generateStreaming(const QString &prompt) override;
    void stop() override;

private:
    llama_model *m_model{nullptr};
    llama_context *m_ctx{nullptr};
    std::jthread m_workerThread;
    std::atomic<bool> m_stopRequested{false};
};
