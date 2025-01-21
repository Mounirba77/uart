#include "PinChangeInterrupt.h"

#include "partie_com1.c"

//SERVO DRUVE

const int temp_1=350;
const int temp_2=1000;

 int temps_sh=300;
 int temps_sv=150;
 int temps_lame=100;
 int delai_attente=100;
 const int ouverture_sh=50;

// *******************ACTIONNEURS*******************
const int pcon=A0;
const int ncl=5;
const int pcl=4;
const int servo_on=0;
const int alm_rst=1;
const int sh=8;
const int sv=9;
const int lame=11;
const int doseur=12;


// *******************Capteurs*******************

const int servo_pos_haut=3;
const int servo_pos_bas=2;
const int photocell_pin= 6;


//*******************boutons********************

const int btn_marche=A2;
const int btn_arret=A1;

//********************Retour interface*************************
#define err_pos_bas 1
#define err_fin_bobine 2
#define err_fin_cycle 3




int Etat_Pos_H=0;
int qte=0;


#define temporise 1
#define DEBUG 1
#define photocellule 0


#define SERIAL_BAUD 9600  // Baudrate

bool mode=temporise;
bool attente=true;
bool en_haut=false;

//*************************************************************************************************
void setup()
     {
        Serial.begin(SERIAL_BAUD);
        Serial.println("Connecting...");
        config_input_output();
        init_servo();
        init_cycle();

        attachPCINT(digitalPinToPinChangeInterrupt(servo_pos_haut),attente_servo ,RISING); //3
       attachPCINT(digitalPinToPinChangeInterrupt(servo_pos_bas),arret_servo ,RISING);   //2
       attachPCINT(digitalPinToPinChangeInterrupt(photocell_pin),attente_servo ,RISING); //6

       // etablissemnt connexion serie
       while(!est_connecte)
       {
         a_envoyer=format_commande(demarrer_handshake,"100");
         envoyer_commande(a_envoyer);
         // On laisse au Gui le temps de répondre au handshake
         wait_for_bytes(2,200);
         traiter_commande_debut();
       }



        mode=temporise;
      }
//*****************************Programme Principal***********************************************

void loop()
{

//**************************Btn MARCHE*******************************
   if (digitalRead(btn_marche)==LOW)
   {
         if (DEBUG)  Serial.println("action marche");
            qte =100;
        fonctionnement_normal_cycle();
       // fonctionnement_a_vide();

   }

//*******************************************************************
}



//*********************************  ALL FUNCTION  ************************************

void config_input_output()
        {
        pinMode(pcon,OUTPUT);
        pinMode(sh,OUTPUT);
        pinMode(sv,OUTPUT);
        pinMode(lame,OUTPUT);
        pinMode(doseur,OUTPUT);
        pinMode(pcl,OUTPUT);
        pinMode(ncl,OUTPUT);
        pinMode(servo_on,OUTPUT);
        pinMode(alm_rst,OUTPUT);


        pinMode(btn_marche ,INPUT_PULLUP);
        pinMode(btn_arret,INPUT_PULLUP);
        pinMode(servo_pos_bas,INPUT);
        pinMode(servo_pos_haut,INPUT);
        pinMode(photocell_pin,INPUT);
        }
//****************************************

void init_cycle()
        {

          digitalWrite( pcon, LOW);
          digitalWrite( pcl, LOW);
          digitalWrite( ncl, LOW);
          digitalWrite( sv, LOW);
          digitalWrite( sh, LOW);
          digitalWrite( lame, LOW);
          digitalWrite( doseur, LOW);
          digitalWrite( servo_on, LOW);
          digitalWrite( alm_rst, LOW);
        }

//*****************************************
void fonctionnement_normal_cycle()
  {

    while (qte>0){
 if (digitalRead(btn_arret)==LOW )

   {
         if (DEBUG)  Serial.println("action arret");
         while(digitalRead(btn_marche)==HIGH)
          {
             // arret cycle ou attent cycle
          }

   }


    if (DEBUG)  Serial.print("sh= ");
      if (DEBUG)  Serial.println(temps_sh);
      delay (delai_attente);
      aller_bas();
      fermer_sh();
      //delay(temps_sh);
         if (mode==temporise){
     delay(temps_sh);
 }
 else{

  while (digitalRead(photocell_pin)==HIGH)  {
  // attent tirage
      }
  }
      vitesse_moyenne();
      fermer_doseur();

   if (mode==temporise){
     delay(temps_sh);
 }
 else{

  while (digitalRead(photocell_pin)==HIGH)  {
  // attent tirage
      }
  }


      ouvrir_sh();
      fermer_sv();
      delay(ouverture_sh);
      aller_haut();
      fermer_lame();
      delay(temps_lame);
      ouvrir_doseur();
      ouvrir_lame();
     delay(temps_sv);
      ouvrir_sv();

      qte--;
 if (DEBUG)  Serial.print("q");
 if (DEBUG)  Serial.println(qte);

      attente=true;


    while (en_haut==false){
     if (DEBUG)  Serial.println("montee");


     }

      en_haut=false;



    }
  }
//**********************************************
void ouvrir_doseur()
{
digitalWrite( doseur, HIGH);
}

void fermer_doseur()
{
digitalWrite( doseur, LOW);
}
//**********************************************

void fermer_sh()
{
digitalWrite( sh, HIGH);
}
void ouvrir_sh()
{
digitalWrite( sh, LOW);
}
//***********************************************

void fermer_sv()
{
digitalWrite( sv, HIGH);
}
void ouvrir_sv()
{
digitalWrite( sv, LOW);
}
//************************************************

void fermer_lame()
{
digitalWrite( lame, HIGH);
}
void ouvrir_lame()
{
digitalWrite( lame, LOW);
}
//*************************************************

void aller_bas()
{
digitalWrite( pcon, HIGH);
}
void aller_haut(){
digitalWrite( pcon, LOW);
}
//**************************************************
void init_servo(){

      aller_haut();
      digitalWrite( pcl, LOW);
      digitalWrite( ncl, HIGH);
      while (digitalRead(servo_pos_haut)==LOW){


      if (DEBUG)  Serial.println("init");
      }
      attente=true;
      attente_servo();
      if (DEBUG)  Serial.println("fin init");
      }

//***************************************************
void attente_servo()
{
 en_haut=true;
 digitalWrite( pcl, LOW);
 digitalWrite( ncl, LOW);
}
//***************************************************
void vitesse_moyenne(){
digitalWrite( ncl, HIGH); // config servo drive Pn_38; 100tr/min
digitalWrite( pcl, LOW);

}
//***************************************************
void vitess_faible()
{
digitalWrite( pcl, HIGH); // config servo drive Pn_40;   20tr/min
digitalWrite( ncl, LOW);
  }

//****************************************************
void arret_servo()
  {
    attente_servo();
    ouvrir_lame();
    ouvrir_sh();
    retour_interface(err_pos_bas);//
  }
//****************************************************
void fonctionnement_a_vide()
  {

    while (qte>0){
 if (digitalRead(btn_arret)==LOW)
   {
         if (DEBUG)  Serial.println("action arret");
         while(digitalRead(btn_marche)==HIGH)
          {
             // arret cycle ou attent cycle
          }

   }


    if (DEBUG)  Serial.print("sh= ");
      if (DEBUG)  Serial.println(temps_sh);
      delay (delai_attente);
      aller_bas();
      fermer_sh();
      if (DEBUG)  Serial.println("sh");
      delay(temps_sh);
      vitesse_moyenne();
      //fermer_doseur();

 if (mode==temporise){
     delay(temps_sh);
 }
 else{

  while (digitalRead(photocell_pin)==HIGH)  {
  // attent tirage
      }
  }


      ouvrir_sh();
      fermer_sv();
      aller_haut();
      fermer_lame();
      delay(temps_lame);
     // ouvrir_doseur();
      ouvrir_lame();
      ouvrir_sv();
      delay(temps_sv);

      qte--;

      attente=true;

      while (en_haut==false){
      if (DEBUG)  Serial.println("montee");

      }

       en_haut=false;



    }
  }
//**********************************************
void retour_interface(int para )
{}
