#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include "eventcatcher.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    EventCatcher *event_catcher = new EventCatcher();   // <----
    app.installEventFilter(event_catcher);              // <----

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("eventCatcher", event_catcher); // <----

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    event_catcher->setWindow(QGuiApplication::topLevelWindows()[0]);    // <----

    return app.exec();
}
