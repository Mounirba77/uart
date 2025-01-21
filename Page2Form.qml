

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Extras 1.4
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.0

Page {
    width: 1024
    height: 560
    property alias lame_de_coupe_toogle: lame_de_coupe_toogle
    property alias doseur_toogle: doseur_toogle
    property alias sh_toogle: sh_toogle
    property alias tirage_toggle: tirage_toggle
    property alias sv_toogle: sv_toogle
    font.pointSize: 16

    Connections {
        target: sv_toogle
        onClicked: sv_status.on = sv_toogle.checked
    }

    GridLayout {
        x: 41
        y: 41
        rows: 12
        columns: 2

        ToggleButton {
            id:  sv_toogle
            objectName: "sv_toogle"
            text: qsTr("Soudure Verticale")
            checked: false
            signal clickedButton(string str)
             onClicked: {
                 if (sv_toogle.checked){

            var par="@,MV,"+temps_sv_spin.value
                     console.log(par )
             sv_toogle.clickedButton(par)
                }
             }
            Layout.rowSpan: 3
        }

        Item {
            id: spacer
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        StatusIndicator {
            id: sv_status
            active: false
        }

        Item {
            id: spacer1
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        ToggleButton {
            id: sh_toogle
            objectName: "sh_toogle"
            text: qsTr("Soudure Horizontale")
            Layout.rowSpan: 3
            signal clickedButton(string str)
             onClicked: {
                 if (sh_toogle.checked){

            var par="@,MH,"+temps_sh_spin.value
                     console.log(par )
             sh_toogle.clickedButton(par)
                }
             }
        }

        Item {
            id: spacer2
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        StatusIndicator {
            id: sh_status
            active: false
        }

        Item {
            id: spacer3
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        ToggleButton {
            id: doseur_toogle
            objectName: "doseur_toogle"
            text: qsTr("Doseur")
            Layout.rowSpan: 3
            signal clickedButton(string str)
             onClicked: {
                 if ( doseur_toogle.checked){

            var par="@,MD,000"
             doseur_toogle.clickedButton(par)
                }
             }
        }

        Item {
            id: spacer4
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        StatusIndicator {
            id: doseur_status
            active: false
        }

        Item {
            id: spacer5
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        ToggleButton {
            id: lame_de_coupe_toogle
            objectName: "lame_de_coupe_toogle"
            text: qsTr("Lame de coupe")
            Layout.rowSpan: 3
            signal clickedButton(string str)
             onClicked: {
                 if ( lame_de_coupe_toogle.checked){

            var par="@,ML,000"
             lame_de_coupe_toogle.clickedButton(par)
                }
             }
        }

        Item {
            id: spacer6
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        StatusIndicator {
            id: lame_de_coupe_status
            active: false
        }

        Item {
            id: spacer7
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }
    }

    StatusIndicator {
        id: tirage_status
        x: 559
        y: 83
    }

    ToggleButton {
        id: tirage_toggle
        x: 433
        y: 41
        text: qsTr("Tirage ")
    }

    Gauge {
        id: sv_gauge
        x: 686
        y: 41
        width: 47
        height: 408
    }

    Gauge {
        id: sh_gauge
        x: 865
        y: 41
        width: 47
        height: 408
    }

    Label {
        id: label
        x: 646
        y: 477
        width: 128
        height: 56
        text: qsTr("Temperature Horizontale")
        wrapMode: Text.WordWrap
    }

    Label {
        id: label1
        x: 835
        y: 477
        width: 128
        height: 56
        text: qsTr("Temperature Verticale")
        wrapMode: Text.WordWrap
    }

    CircularGauge {
        id: circularGauge
        x: 377
        y: 220
    }

    SpinBox {
        id: spinBox
        x: 453
        y: 485
    }

    Label {
        id: label2
        x: 433
        y: 450
        text: qsTr("Vitesse Tirage")
    }

    SpinBox {
        id: temps_sv_spin
        x: 213
        y: 77
    }

    SpinBox {
        id: temps_sh_spin
        x: 213
        y: 189
    }

    Label {
        id: label3
        x: 213
        y: 154
        text: qsTr("Temps Soudure Horizontale")
        font.pointSize: 11
    }

    Label {
        id: label4
        x: 219
        y: 52
        text: qsTr("Temps Soudure Verticale")
        font.pointSize: 11
    }

    //    header: Label {
    //        text: qsTr("Page 2")
    //        font.pixelSize: Qt.application.font.pixelSize * 2
    //        padding: 10
    //    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
