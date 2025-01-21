import QtQuick 2.9
import QtQuick.Controls 2.2
// import QtQuick.VirtualKeyboard 2.2
import QtQuick.Controls.Material
// Pour importer la backend C++
import io.qt.examples.backend 1.0


ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 700
    title: qsTr("Tabs")
    color: black

property alias temperature_sh_spin: temperature_sh_spin

    BackEnd {
            id: backend
        }

    function connexion_etablie(msg) {
    // console.log("Got message:", msg)
    connect_arduino.checked=true;
    carte_mere_indicateur.active=true;
    // carte_mere_indicateur.color= "#Fcfc2c";
    //  return "Hello, Qter!"
    }
    function initialisation_etablie( ) {
    init_servo_indicateur.active=true;
    }



    function erreur_port_com_1( ) {
    carte_mere_indicateur.active=true;
    carte_mere_indicateur.color="red"
    }

    function update_qte(msg) {
    quantite_restant_label.text=msg;
    }

            // ToggleButton {
            //     id:  connect_arduino
            //     objectName: "connect_arduino"
            //     x: 483
            //     y: 439
            //     width: 113
            //     height: 107
            //     text: qsTr("Connecter Arduino")
            //     checked: false
            //     signal clickedButton(string str)
            //      onClicked: {
            //           connect_arduino.clickedButton("@,DH,1")
            //      }
            // }
            // Button {
            //     id: connect_arduino
            //     x:483
            //     y:439
            //     width: 113
            //     height: 107
            //     signal clickedbutton(string str)
            //     onCliked: {
            //         connect_arduino.clickedbutton("@,DH,1")
            //     }
            // }

                // Si on a besoin d'un signal handler dans un seul sen s§§§§
//            Button {
//                   id: buttonTest
//                   objectName: "buttonTest"

//                   signal clickedButton(string str)
//                   onClicked: {
//                       buttonTest.clickedButton("clicked !")
//                   }
//               }


//            backend.onButtonClicked: {
//               Button.text="ENFIN!!!"
//            }

           temperature_sh_spin.onValueChanged: {
                backend.temperature_sh=temperature_sh_spin.value
               temperature_sh_affichage.text += "\n" + "temperature send:" + temperature_sh_spin.value;
            }
           SpinBox {
                     id: temperature_sh_spin
                     // Layout.preferredHeight: 51
                     // Layout.preferredWidth: 102
                     to: 160
                     x:30
                     y:30
                     value: 120
                   }

           Text{
               x:30
               text: "Temperature"
           }

//            temps_sh_spin.onActiveFocusChanged: {
//                console.log("focus")
//                if (temps_sh_spin.focus==true){
//                    temps_sh_spin.y=inputPanel.y+30
//                }
//                else{
//                    temps_sh_spin.y=inputPanel.y+30
//                }
//            }

//            if (!inputContext.visible) {
//                    return
//                  }
           Text{
               id:temperature_sh_affichage
               x: 100
               y: 100
               text: "pas encore"
           }
}

