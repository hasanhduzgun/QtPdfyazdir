#ifndef PDFYAZDIR_H
#define PDFYAZDIR_H

#include <QDebug>
#include <QPrinter>
#include <QTextDocument>
#include <QDir>
#include <QStandardPaths>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QObject>

class pdfyazdir : public QObject
{
    Q_OBJECT
public:
    explicit pdfyazdir(QObject *parent = nullptr);
    QString icerikHazirla(QString sirketad, QString baslik, QString yazi, QString logo, QString resim);
    void resimKopyala(QString logo, QString resim);
    void kalintiTemizle();
    void yetkiAyarla();

public slots:
    QString yazdir(QString sirketadi, QString baslik, QString yazi, QString logo, QString resim, QString platform);

};

#endif // PDFYAZDIR_H
