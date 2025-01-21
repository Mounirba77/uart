#include "backend.h"


#include <QtCore/QtGlobal>
#include <QString>




#ifdef QT_DEBUG
#include <QDebug>
#endif

#include<QTimer>

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{





//    QTimer *timer = new QTimer(this);
//        connect(timer,  SIGNAL(timeout() ), this, SLOT(simulationI2C()));
//        timer->start(3000);
}


void BackEnd::simulationI2C(){

    // Qunad une commande est reçue depuis les Arduino elle est tout d'abord verifié (dans la sémantique)
    // Puis elle est comparé à l'ancienne valeur (sinon pas besoin de faire de vhangement du GUI)

#ifdef QT_DEBUG
    qDebug()<<"commande I2c";
#endif

    m_temps_sv++;
    emit communication_event(m_temps_sv);


}

//void BackEnd::change_mode_tirage(mode_tirage tirage){

//     m_mode_tirage=tirage;
//}


void BackEnd::change_vitesse_machine(const quint16 &vitesse_machine){

    m_vitesse_machine=vitesse_machine;
    #ifdef QT_DEBUG
        qDebug()<<"Vitesse= "<<m_vitesse_machine;
    #endif
     emit vitesse_changed();
}


void BackEnd::change_temperature_sh(const quint16 &temperature_sh){

    m_temperature_sh=temperature_sh;
    #ifdef QT_DEBUG
         qDebug()<<"temperature_sh = "<< m_temperature_sh;
    #endif
    emit  temperature_sh_changed();
}


void BackEnd::change_temperature_sv(const quint16 &temperature_sv){

    m_temperature_sv=temperature_sv;
#ifdef QT_DEBUG
     qDebug()<<"temperature_sv= "<< m_temperature_sv;
#endif
    emit  temperature_sv_changed();

}



void BackEnd::change_temps_sv(const quint16 &temps_sv){

    m_temps_sv=temps_sv;
#ifdef QT_DEBUG
     qDebug()<<"temps_sv= "<<m_temps_sv ;
#endif
    emit  temps_sv_changed();
}



void BackEnd::change_temps_sh(const quint16 &temps){
    m_temps_sh=temps;
#ifdef QT_DEBUG
     qDebug()<<"temps_sh= "<<m_temps_sh ;
#endif
    emit  temps_sh_changed();
}


void BackEnd::change_lame_de_coupe(bool &lame_de_coupe){
    m_lame_de_coupe=lame_de_coupe;
   emit  lame_de_coupe_changed();

}



void BackEnd::change_marche_bool(const bool &marche_bool){
    m_marche_bool=marche_bool;
#ifdef QT_DEBUG
     qDebug()<<"Machine :  "<<m_marche_bool ;
#endif
   emit  marche_bool_changed();
}



// Si on a besoin d'un signal handler dans un seul sen s§§§§
//void BackEnd::onButtonClicked(QString str)
//{
//    qDebug() << "button: " << str;
//}



