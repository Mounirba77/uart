import QtQuick 2.0
import QtQuick.Controls 2.2


// QMl filename must begin with an uppercase letter.

Tumbler {
    id: control
    model:[0 , 1 , 2, 3 , 4, 5 ,6, 7, 8 , 9]

  //  background: Item {
//        Rectangle {
//            opacity: control.enabled ? 0.2 : 0.1
//            border.color: "#000000"
//            width: parent.width
//            height: 2
//            anchors.top: parent.top
//        }

//        Rectangle {
//            opacity: control.enabled ? 0.2 : 0.1
//            border.color: "#000000"
//            width: parent.width
//            height: 1
//            anchors.bottom: parent.bottom
//        }
  //  }

    delegate: Text {
        text:modelData
       // font: control.font
        font.pointSize: 13;
       // font.bold: true ;
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
    }

    visibleItemCount: 2


}

