import QtQuick
import QtQuick.Controls

TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "#282c34"
    property color colorOnFocus: "#242831"
    property color colorMouseOver: "#2B2F38"

    QtObject{
        id: internal

        property var dynamicColor: if (textField.focus) {
                                        textField.focus ? colorOnFocus : colorDefault
                                   } else {
                                       textField.hovered ? colorMouseOver : colorDefault
                                   }
    }

    implicitWidth: 300
    implicitHeight: 40

    leftPadding: 15

    placeholderText: qsTr("Type something")
    placeholderTextColor: "#81848c"
    color: "#ffffff"

    selectByMouse: true
    selectedTextColor: "#FFFFFF"
    selectionColor: "#ff007f"

    background: Rectangle {
        color: internal.dynamicColor
        radius: 10

        border.color: textField.focus ? "#ffffff" : colorDefault
    }
}
