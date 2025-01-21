import QtQuick
import QtQuick.Controls

CheckBox {
    id: idCustomCheckBox

    property string nameChb: qsTr("")

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

    padding: 0

    contentItem: Text {        
        leftPadding: idCustomCheckBox.indicator.width + 6

        text: qsTr(nameChb)
        font.family: "Segoe UI"
        font.pointSize: 10
        color: "#D1E37D"

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    indicator: Rectangle {
        y: idCustomCheckBox.height / 2 - height / 2
        implicitWidth: 15
        implicitHeight: 15
        radius: 3
        color: idCustomCheckBox.dynamicColor(idCustomCheckBox)

        ColorImage {
            id: idImgTick
            visible: idCustomCheckBox.checked
            source: "qrc:/icons/tick.svg"

            color: idCustomCheckBox.down ? "#E9D6D6" : "#FFFFFF"
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2

            fillMode: Image.PreserveAspectFit
            sourceSize.width: 15
            sourceSize.height: 15
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}
