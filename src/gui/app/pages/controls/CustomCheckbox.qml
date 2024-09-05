import QtQuick
import QtQuick.Controls

CheckBox {
    id: idCustomCheckBox

    property string nameChb: ""

    contentItem: Text {
        text: qsTr(nameChb)
        color: txtSection

        verticalAlignment: Text.AlignVCenter
        leftPadding: idCustomCheckBox.indicator.width
        font.pixelSize: sizeTextInSect
    }

    indicator: Rectangle {
        y: idCustomCheckBox.height / 2 - height / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: 5
        color: "#8792A8"

        ColorImage {
            id: idImgTick
            visible: idCustomCheckBox.checked
            source: "../../../icons/tick.svg"

            color: idCustomCheckBox.down ? "#E9D6D6" : "#FFFFFF"
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2

            fillMode: Image.PreserveAspectFit
            sourceSize.width: 17
            sourceSize.height: 17
        }

    }

    background: Rectangle {
        color: "transparent"
    }
}
