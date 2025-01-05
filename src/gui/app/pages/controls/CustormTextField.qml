import QtQuick
import QtQuick.Controls

TextField {
    id: idCustTextFields

    property string phText: qsTr("")
    readonly property color colorText: "#FFFFFF"

    implicitHeight: 27


    placeholderText: qsTr(phText)
    placeholderTextColor: colorText

    font.family: "Segoe UI"
    font.pixelSize: sizeTextInSect - 1
    clip: true
    color: colorText

    background: Rectangle {
        radius: 3
        color: "#8792A8"
    }
}
