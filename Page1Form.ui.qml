import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Extras 1.4
import QtQml.Models 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Page {
    id: page

    property var qte_demande: 100
    // width: 1024
    // height: 800

    //background: "#ef2e2e"
    ColorAnimation {
        from: "white"
        to: "black"
        duration: 2000
    }
    background: Rectangle {
        color: "#FFFFFF"
    }

    property alias quantite_spin: quantite_spin
    property alias quantite_restant_label: quantite_restant_label
    property alias marche_toggle: marche_toggle
    property alias temperature_sv_afficheur: temperature_sv_afficheur
    property alias temperature_sh_afficheur: temperature_sh_afficheur
    property alias temps_sh_spin: temps_sh_spin
    property alias temporise_toggle: temporise_toggle
    property alias vitesse_spin: vitesse_spin
    property alias vitesseGauge: vitesseGauge
    width: 1024
    height: 700
    font.pointSize: 13
    property alias carte_temperature_indicateur: carte_temperature_indicateur
    property alias carte_mere_indicateur: carte_mere_indicateur
    property alias init_servo_indicateur: init_servo_indicateur
    property alias temperature_sv_spin: temperature_sv_spin
    property alias temperature_sh_spin: temperature_sh_spin
    property alias temps_sv_spin: temps_sv_spin

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

        StatusIndicator {
            id: statusIndicator
            x: 183
            y: 45
        }

        StatusIndicator {
            id: statusIndicator1
            x: 196
            y: 253
            color: "#00ff2c"
        }
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
    }

    Gauge {
        id: temperature_sh_afficheur
        x: 36
        y: 314
        width: 63
        height: 306
        tickmarkStepSize: 10
        maximumValue: 160
        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: 16
                color: Qt.rgba(
                           temperature_sh_afficheur.value / temperature_sh_afficheur.maximumValue,
                           0, 1 - temperature_sh_afficheur.value
                           / temperature_sh_afficheur.maximumValue, 1)
            }
        }
    }

    ToggleButton {
        id: lame_de_coupe_toggle
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
        width: 53
        height: 306
        tickmarkStepSize: 10
        maximumValue: 160
        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: 16
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

    SpinBox {
        id: temps_sv_spin
        x: 378
        y: 381
        width: 90
        height: 52
        to: 500
        value: 100
        wheelEnabled: true
        editable: false
    }

    Label {
        id: label4
        x: 297
        y: 391
        width: 65
        height: 55
        text: qsTr("Temps SV")
    }

    SpinBox {
        id: temps_sh_spin
        x: 427
        y: 186
        //z:inputPanel.z+1
        width: 90
        height: 47
        from: 100
        stepSize: 10
        to: 1000
        value: 100
        wheelEnabled: true
        editable: true
    }

    Label {
        id: label5
        x: 304
        y: 200
        text: qsTr("Temps SH (ms)")
    }

    Frame {
        id: frame1
        x: 618
        y: 12
        width: 248
        height: 608

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

        ToggleButton {
            id: marche_toggle
            x: 56
            y: 139
            text: qsTr("Marche")
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
            x: 47
            y: 57
            width: 131
            height: 60
            spacing: 12
            font.bold: true
            font.pointSize: 24
            value: 0
            editable: false
            to: 99999
        }
    }

    GridLayout {
        id: gridLayout
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
            visible: true
            Layout.preferredHeight: 56
            Layout.preferredWidth: 97
            to: 160
            value: 120
            editable: true
            wheelEnabled: true
        }
    }

    Label {
        id: label9
        x: 48
        y: 662
        text: qsTr("Initialisation Servo")
    }

    Label {
        id: label10
        x: 226
        y: 662
        text: qsTr("Communication Carte Mère")
    }

    StatusIndicator {
        id: carte_temperature_indicateur
        x: 437
        y: 658
        color: "#00ff2c"
    }

    Label {
        id: label11
        x: 471
        y: 662
        text: qsTr("Carte Température")
    }
    StatusIndicator {
        id: init_servo_indicateur
        x: 14
        y: 658
        color: "#00ff2c"
        active: false
    }

    StatusIndicator {
        id: carte_mere_indicateur
        x: 190
        y: 658
        color: "#00ff2c"
        active: true
    }

    StatusIndicator {
        id: carte_temperature_indicateur1
        x: 618
        y: 660
        color: "#00ff2c"
    }

    Label {
        id: label12
        x: 652
        y: 662
        width: 146
        height: 23
        text: qsTr("Erreur Limite Bas")
    }

    StatusIndicator {
        id: carte_temperature_indicateur2
        x: 786
        y: 658
        color: "#00ff2c"
    }

    Label {
        id: label13
        x: 820
        y: 662
        width: 146
        height: 23
        text: qsTr("Alarme Servo-Moteur")
    }

    Switch {
        id: spot_toggle
        x: 312
        y: 257
        width: 191
        height: 97
        text: qsTr("Spot")
        font.weight: Font.Medium
        font.bold: true
        font.pointSize: 17
        checked: true
    }
    states: [
        State {
            id: element
            name: "State1"
            when: marche_toggle.checked = true

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
                target: statusIndicator1
                visible: false
            }

            PropertyChanges {
                target: vitesseGauge
                visible: false
            }

            PropertyChanges {
                target: temperature_sh_afficheur
                visible: false
            }

            PropertyChanges {
                target: lame_de_coupe_toggle
                visible: false
            }

            PropertyChanges {
                target: temperature_sv_afficheur
                visible: false
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
                x: 197
                y: 123
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

            PropertyChanges {
                target: temperature_sv_spin
                visible: false
            }

            PropertyChanges {
                target: spot_toggle
                visible: false
            }
        },
        State {
            name: "default"
            when: marche_toggle.checked = false

            PropertyChanges {
                name: "State1"
                target: element
            }
        }
    ]
}
