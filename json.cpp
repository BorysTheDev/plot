#include "json.h"

QString Json::getData() const
{
    return data;
}

void Json::setData(const QString &qvarlist)
{
    data = qvarlist;
}

void Json::toFile() const
{
    QFile file("Tasks.json");
    file.open(QIODevice::Text | QIODevice::WriteOnly);
//    QTextStream out(&file);
//    out << data;
    file.write(data.toStdString().c_str());
    file.close();
}
