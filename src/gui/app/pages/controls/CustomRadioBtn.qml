import QtQuick
import QtQuick.Controls

RadioButton {
    id: idRadioBtn

    // DYNAMIC COLOR
    readonly property color colorDef: "#8792A8"
    readonly property color colorMouseOver: "#7a8397"
    readonly property color colorPressed: "#4A515E"

    function dynamicColor (idBtn) {
        if (idBtn.down) {
            return colorPressed
        } else {
            if (idBtn.hovered) {
                return colorMouseOver
            }
        }
        return colorDef
    }

    checked: false

    contentItem: Text {
        text: qsTr(idRadioBtn.text)
        font.family: "Segoe UI"
        font.pixelSize: sizeTextInSect
        color: txtSection
        opacity: enabled ? 1.0 : 0.3

        verticalAlignment: Text.AlignVCenter
        leftPadding: idRadioBtn.indicator.width + idRadioBtn.spacing
    }

    indicator: Rectangle {

        implicitWidth: 20
        implicitHeight: 20
        x: idRadioBtn.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13

        color: dynamicColor(idRadioBtn)

        Rectangle {
            width: parent.width / 2
            height: parent.height / 2
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            radius: 7
            color: idRadioBtn.down ? "#E9D6D6" : "#FFFFFF"
            visible: idRadioBtn.checked
        }

    }

    background: Rectangle {
        color: "transparent"
    }

}
