import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Extras 1.4
import QtQml.Models 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2

import io.qt.examples.backend 1.0

Page {

    property var qte_demande: 100
    // width: 1024
    // height: 800

    //background: "#ef2e2e"
    ColorAnimation {
        from: "white"
        to: "black"
        duration: 2000
    }

    property alias quantite_spin: quantite_spin
    property alias indicateur_marche: indicateur_marche
    property alias quantite_restant_label: quantite_restant_label
    property alias marche_toggle: marche_toggle
    property alias temperature_sv_afficheur: temperature_sv_afficheur
    property alias temperature_sh_afficheur: temperature_sh_afficheur

    property alias temps_sh_spin: temps_sh_spin
    property alias spot_toggle: spot_toggle
    property alias temporise_toggle: temporise_toggle
    property alias vitesse_spin: vitesse_spin
    property alias vitesseGauge: vitesseGauge
    width: 1024
    height: 560
    property alias temperature_sv_spin: temperature_sv_spin
    property alias temperature_sh_spin: temperature_sh_spin
    property alias temps_sv_spin: temps_sv_spin

    property alias carte_temperature_indicateur: carte_temperature_indicateur
    property alias carte_mere_indicateur: carte_mere_indicateur
    property alias init_servo_indicateur: init_servo_indicateur


    //    header: Label {
    //        text: qsTr("Marche Automatique")
    //        font.pixelSize: Qt.application.font.pixelSize * 2
    //        padding: 10
    //    }
    Frame {

        id: frame
        x: 297
        y: 44
        width: 248
        height: 331
    }

    // utilisé pour cacher les boxes lorsque le clavier apparait à l'ecran
    Rectangle {
        id:rectangle_cache_objets
        x:0
        y:0
        width: parent.width
        height: parent.height
        visible: true;
        color:"#3d3d87"
        z:0

    }



    CircularGauge {

        id: vitesseGauge
        x: 29
        y: 16
        width: 189
        height: 201
        minimumValue: 20
        stepSize: 10
        maximumValue: 120
        style: CircularGaugeStyle {
            id: style

            needle: Rectangle {
            y: outerRadius * 0.15
            implicitWidth: outerRadius * 0.03
            implicitHeight: outerRadius * 0.9
            antialiasing: true
            color: "#e34c22"
            }
            tickmarkLabel:  Text {
                font.pixelSize: Math.max(8, outerRadius * 0.1)
                text: styleData.value
                color: "#000000"
                antialiasing: true
            }
        }
    }

    Gauge {
        id: temperature_sh_afficheur
        x: 36
        y: 314
        width: 63
        height: 239
        tickmarkStepSize: 10
        maximumValue: 160
        style: GaugeStyle {
            tickmarkLabel:Text {
                text: styleData.value
                //color: styleData.value
            }

            valueBar: Rectangle {
                implicitWidth: 35
                color: Qt.rgba(
                           temperature_sh_afficheur.value / temperature_sh_afficheur.maximumValue,
                           0, 1 - temperature_sh_afficheur.value
                           / temperature_sh_afficheur.maximumValue, 1)
            }
        }
    }

    ToggleButton {
        id: lame_de_coupe_toggle
        objectName: "lame_de_coupe_toggle "
        x: 373
        y: 439
        width: 104
        height: 109
        text: qsTr("Lame de Coupe")
    }

    ToggleButton {
        id: temporise_toggle
        x: 364
        y: 63
        width: 113
        height: 107
        text: qsTr("Temporisé")
        checked: false
    }

    Gauge {
        id: temperature_sv_afficheur
        x: 150
        y: 314
        width: 55
        height: 239
        tickmarkStepSize: 10
        maximumValue: 160
        style: GaugeStyle {
            tickmarkLabel:Text {
                text: styleData.value
               // color: styleData.value
            }
         valueBar: Rectangle {
                implicitWidth: 35
                color: Qt.rgba(
                           temperature_sv_afficheur.value / temperature_sv_afficheur.maximumValue,
                           0, 1 - temperature_sv_afficheur.value
                           / temperature_sv_afficheur.maximumValue, 1)
            }
        }
    }

    Label {
        id: label2
        x: 98
        y: 147
        text: qsTr("Vitesse ")
    }

    SpinBox {
        id: vitesse_spin
        x: 79
        y: 92
        width: 89
        height: 49
        editable: true
        from: 20
        to: 120
        stepSize: 10
    }

    Label {
        id: label3
        x: 325
        y: 23
        width: 192
        height: 20
        text: qsTr("Mode Soudure Horizontale")
    }

    Switch {
        id: spot_toggle
        x: 338
        y: 286
        width: 165
        height: 68
        text: qsTr("Spot")
        font.weight: Font.Medium
        font.bold: true
        font.pointSize: 17
        checked: true
    }



    Label {
        id: label4
        x: 307
        y: 393
        width: 65
        height: 55
        text: qsTr("Temps SV")
    }



    Label {
        id: label5
        x: 304
        y: 200
        text: qsTr("Temps SH")
    }


    Label {
       text: qsTr(" Quitter")
       x: 881
       y: 500
        MouseArea {
            anchors.fill: parent
            onClicked: dialog.open()
        }
    }





    GridLayout {
        x: 14
        y: 223
        rows: 2
        columns: 2

        Label {
            id: label
            text: qsTr("Temperature SH")
        }

        Label {
            id: label1
            text: qsTr("Temperature SV")
        }

        SpinBox {
            id: temperature_sh_spin
            Layout.preferredHeight: 51
            Layout.preferredWidth: 102
            to: 160
            value: 120
        }

        SpinBox {
            id: temperature_sv_spin
            Layout.preferredHeight: 56
            Layout.preferredWidth: 97
            to: 160
            value: 120
            editable: true
            wheelEnabled: true
        }
    }



    Frame {
        id: frame1
        x: 618
        y: 12
        width: 248
        height: 550

        Label {
            id: label7
            x: 10
            y: 341
            text: qsTr("Quantité Restante")
            font.pointSize: 18
            font.bold: true
        }

        Label {
            id: label6
            x: 58
            y: -8
            width: 108
            height: 52
            text: qsTr("Quantité")
            font.pointSize: 18
            font.bold: true
        }

        Label {
            id: label8
            x: 55
            y: 266
            width: 114
            height: 20
            text: qsTr("Temps estimé")
        }

        // ce qui est en dessous contient des fonctions QMl et doit etre separe de l'interface

        ToggleButton {
            id: marche_toggle
            objectName: "marche_toogle"
            x: 56
            y: 139
            checked: false
            text: qsTr("Marche")



            onCheckedChanged: {
                //qte_demande=quantite_spin.value;
                if (marche_toggle.checked==true){
                    indicateur_marche.running=true;
                    timer_seconds.start()
                    //  quantite_restant_label.text="MArche";
                }
                else{


                    indicateur_marche.running=false;
                    timer_seconds.stop()
                    // quantite_restant_label.text="Arret";
                }

            }
                signal clickedButton(string str)
                 onClicked: {
                     if (marche_toggle.checked==true){
                       // marche_toggle.clickedButton("@,TSV,"+temps_sv_spin.value,"@,TSH,"+temps_sh_spin.value,"@,DA,"+quantite_spin.value)
                        marche_toggle.clickedButton("@,DA,"+quantite_spin.value+"\n")
                    }
                     else{
                      //marche_toggle.clickedButton("@,TSV,"+temps_sv_spin.value,"@,TSH,"+temps_sh_spin.value,"@,AA,"+quantite_spin.value)
                      marche_toggle.clickedButton("@,AA,"+quantite_spin.value+"\n")
                     }


            }
        }




        Label {
            id: quantite_restant_label
            x: 47
            y: 415
            width: 131
            height: 47
            text: qsTr(" 0")
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pointSize: 26
        }

        SpinBox {
            id: quantite_spin
            objectName: "quantite_spin"
            x: 47
            y: 57
            width: 131
            height: 60
            spacing: 12
            font.bold: true
            font.pointSize: 24
            value: 100
            editable: false
            to: 99999
            signal valueModified(string str)
            onValueChanged: {
                qte_demande=value;
                 quantite_spin.valueModified("@,CQ,"+quantite_spin.value+"\n");
            }


        }

        BusyIndicator {
            id: indicateur_marche
            x: 62
            y: 485
            width: 104
            height: 92
            running: false
            enabled: true
        }
    }

    SpinBox {
        id: temps_sv_spin
        x: 378
        y: 406
        width: 90
        height: 52
        objectName: "temps_sv_spin"

        signal valueModified(string str)
        onValueChanged:{

            temps_sv_spin.valueModified("@,TSV,"+temps_sv_spin.value+"\n");
        }

        from: 100
        stepSize: 10
        to: 800
        value: 150

        wheelEnabled: true
        editable: true


        //définir les 2 positions de l'animation
        //(position initial et position final)
        states:[

            State {
                name: "enHaut"
                when: temps_sv_spin.focus && inputPanel.active
                PropertyChanges {
                    target:temps_sv_spin
                    y: inputPanel.height-temps_sv_spin.height-100
                    x:(window.width/2)-(temps_sv_spin.width/2)
                    z:2
                    //height: 100
                   // width : 180
                }
                PropertyChanges {
                target:rectangle_cache_objets
                z:1
                }
            }
            ,

            State {
                name:"default"
                when:!inputPanel.active
                PropertyChanges {
                    target:temps_sv_spin
                    y: 378
                    x:406
                    z:0
                    //height: 52
                   // width : 90
                }
                PropertyChanges {
                target:rectangle_cache_objets
                z:-1
                }

            }
        ]



        //définition du trajectoire de l'animation
        transitions :[



            Transition {
                from: "default"
                to: "enHaut"
                reversible: false
                ParallelAnimation {

                    NumberAnimation {
                        target: rectangle_cache_objets
                        property: "z"
                        duration: 600
                        easing.type: Easing.OutSine
                    }

                    NumberAnimation {
                        properties: "y"
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        properties: "x"
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }

                }
            },
            Transition {
                from: "enHaut"
                to: "default"
                reversible: false
                ParallelAnimation {
                    NumberAnimation {
                        target: rectangle_cache_objets
                        property: "z"
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }

                    NumberAnimation {
                        properties: "y"
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        properties: "x"
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }

                }

            }
        ]


    }




    SpinBox {
        id: temps_sh_spin
        x: 376
        y: 186
        //z:inputPanel.z+1
        width: 90
        height: 47
        wheelEnabled: true
        editable: true

        from: 200
        stepSize: 10
        to: 370
        value: 275

        objectName: "temps_sh_spin"

        signal valueModified(string str)
        onValueChanged:{

            temps_sv_spin.valueModified("@,TSH,"+temps_sh_spin.value+"\n");
        }
    }

    Label {
        id: label9
        x: 48
        y: 608
        text: qsTr("Initialisation Servo")
    }

    Label {
        id: label10
        x: 235
        y: 608
        text: qsTr("Carte Mère")
    }

    StatusIndicator {
        id: carte_temperature_indicateur
        x: 350
        y: 608
        color: "#00ff2c"
    }

    Label {
        id: label11
        x: 400
        y: 608
        text: qsTr("Carte Température")
    }
    StatusIndicator {
        id: init_servo_indicateur
        objectName: "init_servo_indicateur"
        active: false

        x: 14
        y: 608
        color: "#00ff2c"
    }

    StatusIndicator {
        id: carte_mere_indicateur
        x: 190
        y: 608
        color: "#00ff2c"
        active: false
        onColorChanged: {
       timer_erreur.start()
       timer_erreur2.start()

        }
    }
     Timer {
         id: timer_erreur
         interval: 2000;
         repeat: true
         running: true;
         onTriggered: {

             carte_mere_indicateur.scale = 2
                  }
     }
     Timer {
         id: timer_erreur2
         interval: 2300;
         repeat: true
         running: true;
         onTriggered:  carte_mere_indicateur.scale = 1
     }

     Timer {
         id: timer_seconds
         interval: 1000;
         repeat: true
         running: true;
         onTriggered: secondes.currentIndex++
     }

    StatusIndicator {
        id: carte_temperature_indicateur1
        x: 618
        y: 608
        color: "#00ff2c"
    }

    Label {
        id: label12
        x: 652
        y: 608
        width: 146
        height: 23
        text: qsTr("Erreur Limite Bas")
    }

    StatusIndicator {
        id: carte_temperature_indicateur2
        x: 786
        y: 608
        color: "#00ff2c"
    }

    Label {
        id: label13
        x: 820
        y: 608
        width: 146
        height: 23
        text: qsTr("Alarme Servo-Moteur")
    }


    Mytumbler{
        id :secondes
        x:500
        y:200
        opacity: 0
        height: 100

    }

    Mytumbler{
        id :secondes2
        x:480
        y:200
        opacity: 0
        height: 100

    }
    Mytumbler{
        id :minutes
        x:460
        y:200
        opacity: 0
        height: 100

    }
    Mytumbler{
        id :heures
        x:440
        y:200
        opacity: 0
        height: 100

    }
    states: [
        State {
            name: "State1"

            PropertyChanges {
                target: temporise_toggle
                visible: false
            }

            PropertyChanges {
                target: label3
                visible: false
            }

            PropertyChanges {
                target: label4
                visible: false
            }

            PropertyChanges {
                target: frame
                visible: false
            }

            PropertyChanges {
                target: statusIndicator
                visible: false
            }

            PropertyChanges {
                target: connect_arduino
                visible: false
            }
            PropertyChanges {
                target: temperature_sh_spin
                visible: false
            }

            PropertyChanges {
                target: temperature_sv_spin
                visible: false
            }
            PropertyChanges {
                target: statusIndicator1
                visible: false
            }

            PropertyChanges {
                target: vitesseGauge
                visible: false
            }

            PropertyChanges {
                target: temperature_sh_afficheur
                visible: true
            }

            PropertyChanges {
                target: lame_de_coupe_toggle
                visible: false
            }

            PropertyChanges {
                target: temperature_sv_afficheur
                visible: true
            }

            PropertyChanges {
                target: label2
                visible: false
            }

            PropertyChanges {
                target: vitesse_spin
                visible: false
            }

            PropertyChanges {
                target: spot_toggle
                visible: false
            }

            PropertyChanges {
                target: temps_sv_spin
                visible: false
            }

            PropertyChanges {
                target: temps_sh_spin
                visible: false
            }

            PropertyChanges {
                target: label5
                visible: false
            }

            PropertyChanges {
                target: gridLayout
                visible: false
            }

            PropertyChanges {
                target: frame1
                x: 209
                y: 23
                width: 605
                height: 608
                visible: true
            }

            PropertyChanges {
                target: label6
                x: 211
                y: 0
                width: 165
                height: 52
            }

            PropertyChanges {
                target: quantite_spin
                x: 162
                y: 57
                width: 199
                height: 60
            }

            PropertyChanges {
                target: marche_toggle
                x: 156
                y: 407
                width: 220
                height: 177
                text: qsTr("Arret")
            }

            PropertyChanges {
                target: label8
                x: 170
                y: 115
                width: 114
                height: 48
                text: qsTr("Temps Estimé")
                font.bold: true
                font.pointSize: 18
            }

            PropertyChanges {
                target: label7
                x: 164
                y: 276
            }
            PropertyChanges {
                target:  secondes
                opacity :1
            }
            PropertyChanges {
                target:  secondes2
                opacity :1
            }   PropertyChanges {
                target:  minutes
                opacity :1
            }   PropertyChanges {
                target:  heures
                opacity :1
            }


            PropertyChanges {
                target: quantite_restant_label
                x: 168
                y: 334
                width: 188
                height: 67
                font.pointSize: 32
            }
        },
        State {
            name: "default"

            PropertyChanges {
                target: temporise_toggle
                visible: true
            }

            PropertyChanges {
                target: label3
                visible: true
            }

            PropertyChanges {
                target: label4
                visible: true
            }

            PropertyChanges {
                target: frame
                visible: true
            }

            PropertyChanges {
                target: statusIndicator
                visible: true
            }

            PropertyChanges {
                target: statusIndicator1
                visible: true
            }

            PropertyChanges {
                target: vitesseGauge
                visible: true
            }

            PropertyChanges {
                target: temperature_sh_afficheur
                visible: true
            }

            PropertyChanges {
                target: lame_de_coupe_toggle
                visible: true
            }

            PropertyChanges {
                target: temperature_sv_afficheur
                visible: true
            }

            PropertyChanges {
                target: label2
                visible: true
            }

            PropertyChanges {
                target: vitesse_spin
                visible: true
            }

            PropertyChanges {
                target: spot_toggle
                visible: true
            }

            PropertyChanges {
                target: temps_sv_spin
                visible: true
            }

            PropertyChanges {
                target: temps_sh_spin
                visible: true
            }

            PropertyChanges {
                target: label5
                visible: true
            }

            PropertyChanges {
                target: gridLayout
                visible: true
            }

            PropertyChanges {
                target: frame1
                x: 209
                y: 23
                width: 605
                height: 608
                visible: true
            }

            PropertyChanges {
                target: label6
                x: 211
                y: 0
                width: 165
                height: 52
            }

            PropertyChanges {
                target: quantite_spin
                x: 162
                y: 57
                width: 199
                height: 60
            }

            PropertyChanges {
                target: marche_toggle
                x: 156
                y: 407
                width: 220
                height: 177
                text: qsTr("Arret")
            }

            PropertyChanges {
                target: label8
                x: 10
                y: 147
                width: 114
                height: 48
                text: qsTr("Temps Estimé")
                font.bold: true
                font.pointSize: 18
            }

            PropertyChanges {
                target: label7
                x: 164
                y: 276
            }

            PropertyChanges {
                target: quantite_restant_label
                x: 168
                y: 334
                width: 188
                height: 67
                font.pointSize: 32
            }
        }

    ]


    transitions: [
    Transition {
        from: ""
        to: "State1"
        reversible: false
        ParallelAnimation {

            NumberAnimation {
                properties: "y"
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                properties: "x"
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                properties: "opacity"
                duration: 1000
                easing.type: Easing.InSine
            }



        }
    }
    ]


}


