import QtQuick
import QtQuick.Controls

Switch {
    id:idCustomSwitch

    property string nameChb: qsTr("")

    readonly property color fromBackgroundColor: "#7a859b"
    readonly property color toBackgroundColor: "#67aa25"
    readonly property color toFromCheckerColor: "#F3FBF7"

    padding: 0

    contentItem: Text {
        leftPadding: idCustomSwitch.indicator.width + 6

        text: qsTr(nameChb)
        font.family: "Segoe UI"
        font.pixelSize: sizeTextInSect
        color: txtSection

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    indicator: Rectangle{
        id: idBgIndic
        y: parent.height / 2 - height / 2

        implicitHeight: 20
        implicitWidth: 40
        radius: width / 2
        color: idCustomSwitch.checked ? idCustomSwitch.toBackgroundColor : idCustomSwitch.fromBackgroundColor

        border.width: 1
        border.color: idCustomSwitch.checked ? idCustomSwitch.toBackgroundColor : idCustomSwitch.fromBackgroundColor

        Rectangle {
            x: idCustomSwitch.checked ? (parent.width - width) - 1: 1
            width: 18
            height: 18
            radius: height / 2
            color: idCustomSwitch.toFromCheckerColor
            anchors.verticalCenter: parent.verticalCenter

            Behavior on x {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                    easing.amplitude: 1.0;
                    easing.period: 1
                }
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 250
                easing.type: Easing.InOutQuad
                easing.amplitude: 1.0;
                easing.period: 1
            }
        }
    }
}
