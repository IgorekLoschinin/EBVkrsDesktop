import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

CustomBtn {
    id: idBtnRun

    srcImg: "qrc:/icons/play.svg"
    colorImg: "#0ff54c"

    dlgColorDef: "#5d6575"
    dlgColorMouseOver: "#8792A8"
    dlgColorPressed: "#4A515E"

    contentItem: RowLayout {
        spacing: 3

        Layout.fillWidth: true
        Layout.fillHeight: true

        CustomTooltip {
            object: idBtnRun
            textLbl: qsTr("Run 'app'")

            // width: 80
            x: - object.width + 14
            y: object.height - 2
        }

        Item { Layout.fillWidth: true }
        Text {
            text: qsTr("Run")

            font.family: "Segoe UI"
            font.pixelSize: 15

            color: "#ffffff"

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Image {
            id: idIconRunBtn
            source: srcImg

            fillMode: Image.PreserveAspectFit
            sourceSize.height: 26
            sourceSize.width: 26

            MultiEffect {
                id: effect
                anchors.fill: parent
                source: idIconRunBtn

                colorization: 1.0
                colorizationColor: colorImg
            }
        }
        Item { Layout.fillWidth: true }
    }

    background.implicitWidth: 90
    background.implicitHeight: 26
}
