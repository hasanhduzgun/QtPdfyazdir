#include "pdfyazdir.h"

QString logoPath = "logo.png";
QString resimPath = "resim.png";

pdfyazdir::pdfyazdir(QObject *parent) : QObject(parent)
{

}
QString pdfyazdir::yazdir(QString sirketadi, QString baslik, QString yazi,QString logo,QString resim ,QString platform ){


    QString html = icerikHazirla(sirketadi,baslik,yazi,logo,resim);

    QTextDocument document;
    document.setHtml(html);
    QPrinter printer(QPrinter::PrinterResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setColorMode(QPrinter::Color);

    QString path;
    if (platform=="android") path =  "/sdcard/";
    else path = QDir::homePath()+"/Desktop/";

    printer.setOutputFileName(path+sirketadi+".pdf");
    qDebug() << platform<<"     " << path+sirketadi+".pdf";
    document.print(&printer);
    kalintiTemizle();

    return path+sirketadi+".pdf";

}
QString  pdfyazdir::icerikHazirla(QString sirketadi, QString baslik, QString yazi,QString logo,QString resim){

    resimKopyala(logo,resim);

    QString html="<!DOCTYPE HTML><html><head><meta name=\"qrichtext\" content=\"1\" />";
    html +="<style type=\"text/css\">p, li { white-space: pre-wrap; } </style></head><body>";
    html +="<table><tr WIDTH=\"20%\"><td ALIGN=CENTER><img src=\"logo.png\" WIDTH=\"60\" HEIGHT=\"60\" /></td>";
    html +="<td COLSPAN=\"2\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:40pt;\">"+sirketadi;
    html +="</tr><tr><td COLSPAN=\"2\"></td><td><span style=\" font-family:'MS Shell Dlg 2'; font-size:25pt;\">"+baslik;
    html +="</td></tr><tr></tr><tr><td COLSPAN=\"2\"><img src=\"resim.png\" width=\"200\" height=\"60\" /></td>";
    html +="<td><span style=\" font-family:'MS Shell Dlg 2'; font-size:12pt;\">"+yazi+"</td></tr></table></body></html>";

    return html;

}

void pdfyazdir::yetkiAyarla(){
    QFile::setPermissions(logoPath, QFileDevice::ReadOwner|QFileDevice::WriteOwner);
    QFile::setPermissions(resimPath, QFileDevice::ReadOwner|QFileDevice::WriteOwner);
}
void pdfyazdir::resimKopyala(QString logo,QString resim){
    yetkiAyarla();
     qDebug() << QFile::copy(logo,logoPath);
     qDebug() << QFile::copy(resim,resimPath);
}
void pdfyazdir::kalintiTemizle(){
    yetkiAyarla();
     qDebug() << QFile::remove(logoPath);
     qDebug() << QFile::remove(resimPath);
}
