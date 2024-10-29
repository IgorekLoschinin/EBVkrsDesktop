import QtQuick
import QtQuick.Controls

TextField {
    id: idCustTextFields

    property string phText: qsTr("")
    readonly property color colorText: "#FFFFFF"

    height: 22
    color: colorText

    placeholderText: qsTr(phText)
    placeholderTextColor: colorText

    font.family: "Segoe UI"
    font.pixelSize: sizeTextInSect
    clip: true

    background: Rectangle {
        radius: 3
        color: "#8792A8"        
    }
}
