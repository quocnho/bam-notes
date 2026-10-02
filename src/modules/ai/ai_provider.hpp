#pragma once
#include <QObject>
#include <QString>

class IAIProvider : public QObject {
    Q_OBJECT
public:
    explicit IAIProvider(QObject *parent = nullptr) : QObject(parent) {}
    ~IAIProvider() override = default;

    virtual bool isReady() const = 0;
    virtual void generateStreaming(const QString &prompt) = 0;
    virtual void stop() = 0;

signals:
    void tokenGenerated(const QString &token);
    void generationFinished(const QString &fullReply);
};
