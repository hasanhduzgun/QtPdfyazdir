#include "pdfyazdir.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    pdfyazdir pdfyazdir;

    engine.rootContext()->setContextProperty("_pdfyazdir",&pdfyazdir);

    app.setWindowIcon(QIcon(":images/logo.png"));

    engine.load(url);

    return app.exec();
}
