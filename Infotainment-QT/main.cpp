#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QIcon>
#include "CanController.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QIcon icon(":/Icons/01_logobachkhoasang.png");
    app.setWindowIcon(icon);

    qmlRegisterSingletonType(QUrl("qrc:/Theme.qml"), "App.Theme", 1, 0, "Theme");

    QQmlApplicationEngine engine;

    CanController canController;
    if (!canController.initialize()) {
        qDebug() << "Failed to initialize CAN controller";
        return -1;
    }

    engine.rootContext()->setContextProperty("canController", &canController);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
