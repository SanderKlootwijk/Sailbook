#include <QGuiApplication>
#include <QCoreApplication>
#include <QUrl>
#include <QString>
#include <QQuickStyle>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[]) {
    QGuiApplication::setOrganizationName("sailbook.sailbook");
    QGuiApplication::setApplicationName("sailbook.sailbook");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine(QUrl(QStringLiteral("qml/Main.qml")));
    return app.exec();
}
