import QtQuick
import QtQuick.Controls
import QtQuick.Effects

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
        font.pixelSize: sizeTextInSect
        color: txtSection

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    indicator: Rectangle {
        y: idCustomCheckBox.height / 2 - height / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: 5
        color: idCustomCheckBox.dynamicColor(idCustomCheckBox)//"#8792A8"

        Image {
            id: idImgTick
            visible: idCustomCheckBox.checked
            source: "qrc:/icons/tick.svg"

            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2

            fillMode: Image.PreserveAspectFit
            sourceSize.width: 17
            sourceSize.height: 17

            MultiEffect {
                id: effect
                anchors.fill: parent
                source: idImgTick

                colorization: 1.0
                colorizationColor: idCustomCheckBox.down ? "#E9D6D6" : "#FFFFFF"
            }
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}
