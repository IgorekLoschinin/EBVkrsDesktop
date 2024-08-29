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
        border.color: "#800000"
        Rectangle {
            visible: idCustomCheckBox.checked
            width: parent.width / 2
            height: parent.height / 2
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            radius: 2
            color: idCustomCheckBox.down ? "#CD5C5C" : "#B22222"
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}
