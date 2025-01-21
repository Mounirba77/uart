#ifndef SERIE_H
#define SERIE_H
#include <QObject>
#include <QVariant>

#include <QtSerialPort/QSerialPort>

class Serie : public QObject
{
    Q_OBJECT
public:
    explicit Serie(QObject *parent = nullptr);


signals:
    void erreur_port_com_1();
    void ok_port_com_1();

private slots:

    void openSerialPort();
    void closeSerialPort();
    void writeData(const QByteArray &data);
    void readData();

    void envoyer_message(QString data);
    void envoyer_message(QString sv,QString sh, QString qte);


    void handleError(QSerialPort::SerialPortError error);

private:

        QByteArray  format_commande(QString c1,QString p1);
        void traiter_message(QByteArray cmd, QByteArray par);

        QSerialPort *serial;
};

#endif // SERIE_H
