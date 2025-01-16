import QtQuick
import QtQuick.Controls

TextField {
    id: idCustTextFields

    property string phText: qsTr("")
    readonly property color colorText: "#FFFFFF"

    property color colorDefault: "#8792A8"
    property color colorOnFocus: Qt.darker(idCustTextFields.colorDefault, 1.5)
    property color colorMouseOver:Qt.darker(idCustTextFields.colorDefault, 1.2)

    implicitHeight: 27

    placeholderText: qsTr(phText)
    placeholderTextColor: colorText

    font.family: "Segoe UI"
    font.pixelSize: sizeTextInSect - 1
    clip: true
    color: colorText

    background: Rectangle {
        radius: 3
        color: idCustTextFields.hovered ? colorMouseOver : colorDefault
    }
}
