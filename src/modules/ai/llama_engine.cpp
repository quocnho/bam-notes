#include "llama_engine.hpp"
#ifdef BAM_ENABLE_LLAMA
#include <llama.h>
#endif
#include <QDebug>
#include <chrono>

LlamaEngine::LlamaEngine(QObject *parent) : IAIProvider(parent) {
#ifdef BAM_ENABLE_LLAMA
    llama_backend_init();
#endif
}

LlamaEngine::~LlamaEngine() {
    stop();
#ifdef BAM_ENABLE_LLAMA
    if (m_ctx) llama_free((llama_context*)m_ctx);
    if (m_model) llama_free_model((llama_model*)m_model);
    llama_backend_free();
#endif
}

bool LlamaEngine::loadModel(const QString &modelPath) {
#ifdef BAM_ENABLE_LLAMA
    llama_model_params model_params = llama_model_default_params();
    m_model = (llama_model*)llama_load_model_from_file(modelPath.toUtf8().constData(), model_params);
    if (!m_model) return false;

    llama_context_params ctx_params = llama_context_default_params();
    ctx_params.n_ctx = 2048;
    m_ctx = (llama_context*)llama_new_context_with_model((llama_model*)m_model, ctx_params);
    return m_ctx != nullptr;
#else
    Q_UNUSED(modelPath);
    return false;
#endif
}


void LlamaEngine::generateStreaming(const QString &prompt) {
    stop();
    m_stopRequested = false;

    m_workerThread = std::jthread([this, prompt](std::stop_token stoken) {
        if (!m_ctx) {
            QString reply = QString("Bam Trợ Lý (Clean Architecture Native)\nĐã nhận: \"%1\"\n(Đang hoạt động chế độ OpenClaw ReAct Agent).").arg(prompt);
            for (const auto &ch : reply) {
                if (stoken.stop_requested() || m_stopRequested) break;
                emit tokenGenerated(QString(ch));
                std::this_thread::sleep_for(std::chrono::milliseconds(20));
            }
            emit generationFinished(reply);
            return;
        }
    });
}

void LlamaEngine::stop() {
    m_stopRequested = true;
    if (m_workerThread.joinable()) {
        m_workerThread.request_stop();
        m_workerThread.join();
    }
}
