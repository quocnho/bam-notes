#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "presentation/app_controller.hpp"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setApplicationName("bam-troly");
    app.setOrganizationName("BamOS");

    QQmlApplicationEngine engine;
    AppController controller;

    engine.setInitialProperties({
        { "appController", QVariant::fromValue(&controller) }
    });
    engine.rootContext()->setContextProperty("appController", &controller);

    const QUrl url(QStringLiteral("qrc:/BamTroly/qml/Main.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
    );

    engine.load(url);
    return app.exec();
}
