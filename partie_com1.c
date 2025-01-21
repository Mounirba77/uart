




void traiter_commande_debut(){

  while (Serial.available()> 0){

     debut_actuel=Serial.readStringUntil(delimiteur);
     // SI debut_actuel est differnetr de debut_tarme c'est qu'on a catche la trame au milieu on l'ignore
     if (debut_actuel!=debut_trame){
      // On va a la fin de la trame et on attend la nouvelle
       //Serial.print("Debut trame incorrect");
        Serial.println(debut_actuel );
     parametre_actuel = Serial.readStringUntil(delimiteur_fin);
      return;
     }
     // On verifie que c'est un retour de handshake qu'on a reçu
      commande_actuelle = Serial.readStringUntil(delimiteur);
      if (commande_actuelle==demarrer_handshake ){
        est_connecte=true;
        // On doit envoyer une trame de confirmation sinon le GUI va encore envoyer la meme commmande encore et encore!!!
        a_envoyer=format_commande(confirm_reception ,"000");
        envoyer_commande(a_envoyer);
        // On peut sortir de la fonction
        return;
      }
      else {
         //Serial.print("commande recue de handskahe incorrect");
          a_envoyer=format_commande( erreur_communication , "000");
          envoyer_commande(a_envoyer);
         parametre_actuel = Serial.readStringUntil(delimiteur_fin);
      }
  }
}



void wait_for_bytes(int num_bytes, unsigned long timeout)
{
  unsigned long startTime = millis();
  //Wait for incoming bytes or exit if timeout
  while ((Serial.available() < num_bytes) && (millis() - startTime < timeout)){}
}



void loop() {

// get_messages_from_serial();
 traiter_commande();

  if (work_todo){
  update_orders();
  work_todo=false;
   }

 }



void do_soudure_verticale_manuelle(String par){
    digitalWrite(sv,HIGH);
    delay(par.toInt()*10);
    digitalWrite(sv,LOW);
}


void update_orders(){

if(commande[0]==quantite_modifie )
{
quantite_actuelle--;
a_envoyer=format_commande(quantite_modifie ,String(quantite_actuelle ));
}

// c'est possible ??
else if (commande[0]==demarrer_handshake)
{

a_envoyer=format_commande(erreur_communication,"000");

}

else if (commande[0]==manuelle_verticale){
  do_soudure_verticale_manuelle(commande[1]);

   a_envoyer=format_commande(confirm_reception ,"000");

}

else {
      // tout autre message est consider comme une erreur de communication
       a_envoyer=format_commande(erreur_communication,"000");

}

envoyer_commande( a_envoyer);


}









String format_commande(String c1, String p1){

  return (debut_trame+String(delimiteur)+c1+String(delimiteur)+p1+String(delimiteur_fin));
}


  void envoyer_commande(String cmd){
  Serial.print(cmd);
}




void traiter_commande(){

  while (Serial.available()> 0){
     ////Serial.print("Commande Serie recue");
     debut_actuel=Serial.readStringUntil(delimiteur);
     // SI debut_actuel est differnetr de debut_tarme c'est qu'on a catche la trame au milieu on l'ignore
     if (debut_actuel!=debut_trame){
      // On va a la fin de la trame et on attend la nouvelle
     //  Serial.print("Debut trame incorrect");
        // Serial.println(debut_actuel );
     parametre_actuel = Serial.readStringUntil(delimiteur_fin);
      return;
     }
     // On retourne la commande envoyée et le parametre associé
      commande_actuelle = Serial.readStringUntil(delimiteur);
      // TODO:  si on ne recoit pas le delimteur fin The function terminates if it times out (see setTimeout()).
      parametre_actuel = Serial.readStringUntil(delimiteur_fin);
      commande[0]=commande_actuelle;
      commande[1]=parametre_actuel;
       //Serial.print("Commande recue= ");
        //  Serial.print(commande[0]);
        // // Serial.println(commande[1]);
      // Todo : On doit envoyer une trame de confirmation sinon le GUI va encore envoyer la meme commmande encore et encore!!!
       //  envoyer_commande(acknow_flag);
      work_todo=true;
      }



  }


