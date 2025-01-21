#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlComponent>
#include <QVariant>
#include <QVariantList>
#include <QQuickStyle>
#include <QDebug>

#include <QtSerialPort/QSerialPort>
#include "backend.h"
#include "serie.h"
QSerialPort *serialPort;

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));


    // Exposing Backend to QML!!
    qmlRegisterType<BackEnd>("io.qt.examples.backend", 1, 0, "BackEnd");


//    serialPort= new QSerialPort(nullptr);
//  serialPort->setBaudRate(9600);
//  serialPort->setPortName("COM4");

//  if (!serialPort->open(QIODevice::ReadWrite)) {
//      qDebug() << QObject::tr("Failed to open port %1, error: %2").arg(serialPort->portName()).arg(serialPort->error()) << endl;
//   }
//  else{
//      qDebug() << "open success";
//  }


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qputenv("QT_QUICK_CONTROLS_1_STYLE", "Base");
    //QQuickStyle::setStyle("Material");
    //QQuickStyle::setStyle("Fusion");
     //QQuickStyle::setStyle("Imagine");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

     QQmlComponent component(&engine, QUrl(QLatin1String("qrc:/main.qml")));
    if (component.isReady()) {
        qDebug() << "Component is ready!";
    } else {
        qDebug() << "Component is not ready:" << component.errorString();
    }

     QObject *mainPage = component.create();

      BackEnd backend(mainPage);
      // On a besoin d'exposer les propriétés des objects QML de 'linterface à la backend C++

      // La facon la plus imple est d'utiliser les SIGNAL / SLOTS
      // On ajoute une fonction dans la partie QML qui sera le SLOT
      // et on le connecte avec le SIgnal dez la backend Correspondant!


       Serie serie(mainPage );


     //backend.setItem(item);


      //MARCHE MANUELL
     QObject* manu_sv = mainPage->findChild<QObject *>("sv_toogle");
     QObject::connect( manu_sv, SIGNAL(clickedButton(QString)), &serie, SLOT(envoyer_message(QString)));
     QObject* manu_sh = mainPage->findChild<QObject *>("sh_toogle");
     QObject::connect( manu_sh, SIGNAL(clickedButton(QString)), &serie, SLOT(envoyer_message(QString)));
     QObject* manu_doseur = mainPage->findChild<QObject *>("doseur_toogle");
     QObject::connect( manu_doseur, SIGNAL(clickedButton(QString)), &serie, SLOT(envoyer_message(QString)));
     QObject* manu_lame = mainPage->findChild<QObject *>("lame_de_coupe_toogle");
     QObject::connect( manu_lame, SIGNAL(clickedButton(QString)), &serie, SLOT(envoyer_message(QString)));




     // Page AUTO
     QObject* item = mainPage->findChild<QObject *>("connect_arduino");
     QObject::connect( item, SIGNAL(clickedButton(QString)), &serie, SLOT(envoyer_message(QString)));

     QObject* marche_btn = mainPage->findChild<QObject *>("marche_toogle");
     QObject::connect( marche_btn, SIGNAL(clickedButton(QString)), &serie, SLOT(envoyer_message(QString)));


     QObject* change_temps_sv = mainPage->findChild<QObject *>("temps_sv_spin");
     QObject::connect(change_temps_sv  , SIGNAL(valueModified(QString)), &serie, SLOT(envoyer_message(QString)));


     QObject*  quantite_spin= mainPage->findChild<QObject *>("quantite_spin");
     QObject::connect(quantite_spin  , SIGNAL(valueModified(QString)), &serie, SLOT(envoyer_message(QString)));




   const QUrl url(QStringLiteral("qrc:/main.qml"));

    return app.exec();
}
