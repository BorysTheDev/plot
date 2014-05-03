#include "qtquick2controlsapplicationviewer.h"
#include <qqml.h>
#include "json.h"

int main(int argc, char *argv[])
{
    Application app(argc, argv);
    qmlRegisterType<Json>("Json", 1, 0, "Json");
    QtQuick2ControlsApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/main/main.qml"));
    viewer.show();


    return app.exec();
}
