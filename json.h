#ifndef JSON_H
#define JSON_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QDebug>

class Json : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ getData WRITE setData NOTIFY dataChanged)

public:
    explicit Json(QObject *parent = 0) : QObject(parent) {}
    Q_INVOKABLE QString getData() const;
    Q_INVOKABLE void setData(const QString &);
    Q_INVOKABLE void toFile() const;

private:
    QString data;

signals:
    void dataChanged();

public slots:
};

#endif // JSON_H
