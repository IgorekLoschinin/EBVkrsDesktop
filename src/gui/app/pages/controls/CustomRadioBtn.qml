import QtQuick
import QtQuick.Controls

RadioButton {
    id: idRadioBtn
    checked: false

    contentItem: Text {
        text: idRadioBtn.text
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
        border.color: idRadioBtn.down ? "#17a81a" : "#21be2b"

        Rectangle {
            width: parent.width / 2
            height: parent.height / 2
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            radius: 7
            color: idRadioBtn.down ? "#17a81a" : "#21be2b"
            visible: idRadioBtn.checked
        }
    }

    background: Rectangle {
        color: "transparent"
    }

}
