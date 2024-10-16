import QtQuick
import QtQuick.Controls

Button {
    id: button

    property string nameBtn: qsTr("Button")
    property int fontPointSize: 10

    // Custom Properties
    property color colorDefault: "#4891d9"
    property color colorMouseOver: "#55AAFF"
    property color colorPressed: "#3F7EBD"

    QtObject{
        id: internal

        property var dynamicColor: if(button.down){
                                       button.down ? colorPressed : colorDefault
                                   }else{
                                       button.hovered ? colorMouseOver : colorDefault
                                   }
    }

    implicitWidth: 30
    implicitHeight: 30

    contentItem: Text {
        text: qsTr(nameBtn)

        font.family: "Segoe UI"
        font.pointSize: fontPointSize

        color: "#ffffff"

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    background: Rectangle{
        color: internal.dynamicColor
        radius: 10
    }
}
