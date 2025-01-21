#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <QVariant>

//enum mode_tirage{
//    temporise,photo_cellule
//};


class BackEnd : public QObject
{
    Q_OBJECT
    // La syntaxe de declaration de la Propriete est
    // Q_PROPERTY ( type property_name exporte au QML READ fonction qui retourne la velur WRITE fonction qui ecrit dans la valeur NOTIFY signal emis);

    Q_PROPERTY(quint16 vitesse_machine READ lire_vitesse_machine WRITE change_vitesse_machine  NOTIFY vitesse_changed )
    Q_PROPERTY(quint16 temperature_sh  READ  lire_temperature_sh WRITE change_temperature_sh   NOTIFY temperature_sh_changed)
    Q_PROPERTY(quint16 temperature_sv  READ lire_temperature_sv  WRITE   change_temperature_sv NOTIFY temperature_sv_changed)
    Q_PROPERTY(quint16 temps_sv        READ lire_temps_sv        WRITE   change_temps_sv      NOTIFY temps_sv_changed)
    Q_PROPERTY(quint16 temps_sh        READ lire_temps_sh        WRITE   change_temps_sh      NOTIFY temps_sh_changed)
    Q_PROPERTY(bool    marche_bool     READ lire_marche_bool     WRITE   change_marche_bool   NOTIFY marche_bool_changed)

   // Q_PROPERTY(bool    lame_de_coupe   READ change_lame_de_coupe WRITE   change_lame_de_coupe NOTIFY lame_de_coupe_Changed)

public:
    explicit BackEnd(QObject *parent = nullptr);




   // void change_mode_tirage(mode_tirage tirage);

    // MEthodes utilisés pour ecrire depuis interface QML
    void change_vitesse_machine(const quint16 &vitesse_machine);
    void change_temperature_sh(const quint16 &temperature_sh);
    void change_temperature_sv(const quint16 &temperature_sv);
    void change_lame_de_coupe (bool &lame_de_coupe);
    void change_temps_sh(const quint16 &temps_sh);
    void change_temps_sv(const quint16 &temps_sv);
    void change_marche_bool(const bool &marche_bool);


    // Methodes utilise pour lire depuis QML
    // Les fonctions sont inline dans le Header vu qu'elle font que retiournrer la varibale!
    quint16 lire_vitesse_machine(){return (m_vitesse_machine);}
    quint16 lire_temperature_sh(){return m_temperature_sh;}
    quint16 lire_temperature_sv(){return m_temperature_sv;}
    quint16 lire_temps_sv(){return m_temps_sv ;}
    quint16 lire_temps_sh(){return m_temps_sh ;}
    bool lire_lame_de_coupe(){return m_lame_de_coupe ;}
    bool lire_marche_bool(){return m_marche_bool;}



signals:
    void userNameChanged();
    void vitesse_changed();
    void temperature_sh_changed();
    void temperature_sv_changed();
    void temps_sh_changed();
    void temps_sv_changed();
    void lame_de_coupe_changed();
    void marche_bool_changed();

    void communication_event(QVariant newValue);

 public slots:
    void simulationI2C();
    //
    // Si on a besoin d'un signal handler dans un seul sen s§§
   // void onButtonClicked(QString str);


private:
    quint16 m_temperature_sh=100;
    quint16 m_temperature_sv=100;


    quint16 m_quantite=100;
    quint16 m_vitesse_machine=60;

    quint16 m_temps_sv=100;
    quint16 m_temps_sh=100;

    bool m_lame_de_coupe=true;
    bool m_marche_bool=false;

   // mode_tirage m_mode_tirage=temporise;


};

#endif // BACKEND_H
