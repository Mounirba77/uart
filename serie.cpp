#include "serie.h"

#include <QtSerialPort/QSerialPortInfo>
#include <QtSerialPort/QSerialPort>
#include <QList>


QString Data;
const char delimiteur=',';



const  QString demarrer_handshake="DH";
const  QString erreur_communication="EC";
const  QString debut_trame="@";
const  QString delimiteur_fin="\n";


const  QString manuelle_verticale="MV";
const  QString manuelle_horizontale="MH";
const  QString manuelle_doseur="MD";
const  QString manuelle_lame="ML";
const  QString manuelle_tirage="MT";



const  QString temps_sh_auto="TSH";
const  QString temps_sv_auto="TSV";
const  QString demarrer_auto="DA";
const  QString arret_auto="AA";
const  QString initialiser_servo="IS";
const  QString change_quantite="CQ";
const  QString update_qte="UQ";


#ifdef QT_DEBUG
#include <QDebug>
#endif

#include <QDebug>
#include <QObject>
#include <QString>

Serie::Serie(QObject *parent) : QObject(parent)
{
serial = new QSerialPort(this);


// connect(serial, static_cast<void (QSerialPort::*)(QSerialPort::SerialPortError)>(&QSerialPort::error),
//         this, &Serie::handleError);
connect(serial, &QSerialPort::errorOccurred, this, &Serie::handleError);


//! [2]
connect(serial, &QSerialPort::readyRead, this, &Serie::readData);
//! [2]
//connect(console, &Console::getData, this, &serie::writeData);
//! [3]
openSerialPort();
}


void Serie::openSerialPort()
{

    QList<QSerialPortInfo> infos = QSerialPortInfo::availablePorts();
    if (infos.size()==0){
        qDebug()<<"Aucun port detecté";
    }
                  else{
        for (const QSerialPortInfo &info : infos) {
            // @FIXME : on prend juste le premier port
            qDebug()<<"Port disponibles : "<<info.portName();
            serial->setPortName( info.portName());
         }
    }

      serial->setBaudRate(QSerialPort::Baud115200);
      serial ->setDataBits(QSerialPort::Data8);
      serial ->setParity(QSerialPort::NoParity);
      serial ->setStopBits(QSerialPort::OneStop);
      serial ->setFlowControl(QSerialPort::NoFlowControl);
      serial->setReadBufferSize(0);
    if (serial->open(QIODevice::ReadWrite)) {
      qDebug()<<" Connected";
      // TODO: le signal doit etre emis lorsque la connexion est établie et non quand le port est ouvert...

      // Toutes les connexions doivent se faire via la backend !!!
      QVariant returnedValue; // return value
      QVariant msg = "Hello, QML!"; // Method parameters
      QMetaObject::invokeMethod(this->parent()->findChild<QObject *>("Page1Form"), "initialisation_etablie", Q_RETURN_ARG(QVariant, returnedValue),Q_ARG(QVariant, msg));
      //qDebug() << "QML function returned:" << returnedValue.toString();


    } else {

            qDebug()<<serial->errorString();
            QMetaObject::invokeMethod(this->parent()->findChild<QObject *>("Page1Form"), "erreur_port_com_1");
            emit erreur_port_com_1();

    }
}

void Serie::closeSerialPort()
{
    if (serial->isOpen())
        serial->close();
}

void Serie::writeData(const QByteArray &data)
{
    serial->write(data);
}
//! [6]

//! [7]
void Serie::readData()
{

    // @FIXME: erreur lorsqu'on utilise Readline skip des trames!!!

    QByteArray data = serial->readAll();
    //QByteArray data = serial->readLine();
    const QList <QByteArray> message_split=data.split(delimiteur);

    if (message_split.size()<3){
        // Erreur taille de trame
        qDebug()<<"Erreur taille de trame";
        // NOTE : On ne doit pas envoyer erreur communication sinon on entre dasn une boucle infine!!
        //QByteArray a_envoyer=format_commande(erreur_communication," ");
       // writeData(a_envoyer);
    }

    if (message_split.at(0)!=debut_trame.toUtf8()){

        qDebug()<<"Erreur debut trame";
        // NOTE : On ne doit pas envoyer erreur communication sinon on entre dasn une boucle infine!!
        // On neglige cette instruction tout simplment!
        // QByteArray a_envoyer=format_commande(erreur_communication," ");
         // writeData(a_envoyer);
    }
    else{

    // Message recu corrrect on choisi la bonne reaction

    // qDebug()<<message_split.at(1)<<message_split.at(2).trimmed();

        traiter_message(message_split.at(1),message_split.at(2));

    }
    qDebug()<<"Recu: "<<data;
}


void Serie::traiter_message(QByteArray cmd, QByteArray par){

//    if (cmd.toStdString()==demarrer_handshake.toStdString()){
//        QByteArray a_envoyer=format_commande(demarrer_handshake ,QString::fromStdString(par.toStdString()));
//        writeData(a_envoyer);

//    }
        if (cmd.toStdString()==initialiser_servo.toStdString()){
            QMetaObject::invokeMethod(this->parent()->findChild<QObject *>("Page1Form"), "initialisation_etablie");
            qDebug() << "Initialistion Done";

        }
        if (cmd.toStdString()==update_qte.toStdString()){
            //int msg = "Hello, QML!"; // Method parameters
            QVariant msg=par.trimmed();
            QMetaObject::invokeMethod(this->parent()->findChild<QObject *>("Page1Form"), "update_qte",Q_ARG(QVariant, msg));
            qDebug() << "nouvelle QTE= "<<msg ;
        }


}



QByteArray Serie::format_commande(QString c1,QString p1){
    QString temp=debut_trame+delimiteur+c1+delimiteur+p1+delimiteur_fin;
    return temp.toUtf8();
}

void Serie::envoyer_message(QString data)
{
    // @TODO : s'assurer que la communication est en_cours
   qDebug()<<"Envoi trame "<<data.toUtf8();
    serial->write(data.toUtf8());

}



void Serie::envoyer_message(QString sv,QString sh, QString qte){
qDebug()<<"Envoi trame "<<sh.toUtf8()<<sv.toUtf8()<<qte.toUtf8();
     serial->write(sv.toUtf8());
     // serial->write(sh.toUtf8());
      // serial->write(qte.toUtf8());

}
void Serie::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        qDebug()<<serial->errorString();
        closeSerialPort();
    }
}
