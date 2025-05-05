#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQml>
#include <QIcon>
#include "CanController.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    CanController canController;
    if (!canController.initialize()) {
        qDebug() << "Failed to initialize CAN controller";
        return -1;
    }
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("canController", &canController);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/Style.qml")), "Style", 1, 0, "Style");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);
    app.setApplicationName("Tesla Organization");
    app.setApplicationDisplayName("Tesla");
    app.setOrganizationName("Tesla");
    app.setApplicationVersion("1.0");
    QIcon icon(":/icons/Tesla Logo.svg");
    app.setWindowIcon(icon);
    return app.exec();
}
