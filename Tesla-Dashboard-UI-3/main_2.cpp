#include <QApplication>
#include <QQmlApplicationEngine>
#include <QMediaPlayer>
#include <QVideoWidget>
#include <QTimer>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    // Video playback setup
    QMediaPlayer *player = new QMediaPlayer;
    QVideoWidget *videoWidget = new QVideoWidget;

    player->setVideoOutput(videoWidget);
    player->setMedia(QUrl("qrc:/startup.mp4"));

    videoWidget->resize(800, 600);
    videoWidget->show();
    player->play();

    // Connect when video ends, then load QML
    QObject::connect(player, &QMediaPlayer::mediaStatusChanged, [&](QMediaPlayer::MediaStatus status) {
        if (status == QMediaPlayer::EndOfMedia || status == QMediaPlayer::InvalidMedia) {
            videoWidget->close();
            videoWidget->deleteLater();
            player->deleteLater();

            QQmlApplicationEngine *engine = new QQmlApplicationEngine;
            const QUrl url(QStringLiteral("qrc:/main.qml"));
            qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/Style.qml")), "Style", 1, 0, "Style");
            QObject::connect(
                engine,
                &QQmlApplicationEngine::objectCreated,
                &app,
                [url](QObject *obj, const QUrl &objUrl) {
                    if (!obj && url == objUrl)
                        QCoreApplication::exit(-1);
                },
                Qt::QueuedConnection);
            engine->load(url);
        }
    });

    return app.exec();
}
