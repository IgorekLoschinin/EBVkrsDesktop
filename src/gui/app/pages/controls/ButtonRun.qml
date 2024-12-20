import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

CustomBtn {
    id: idBtnRun

    srcImg: "qrc:/icons/play.svg"
    colorImg: "green"

    dlgColorDef: "#5d6575"
    dlgColorMouseOver: "#8792A8"
    dlgColorPressed: "#4A515E"

    contentItem: RowLayout {
        spacing: 3

        Layout.fillWidth: true
        Layout.fillHeight: true

        Item { Layout.fillWidth: true }
        Text {
            text: qsTr("Run")

            font.family: "Segoe UI"
            font.pixelSize: 15

            color: "#ffffff"

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        ColorImage {
            source: srcImg
            color: colorImg

            fillMode: Image.PreserveAspectFit
            sourceSize.height: 26
            sourceSize.width: 26
        }
        Item { Layout.fillWidth: true }
    }

    onClicked: backend.run(sendForm)

    background.implicitWidth: 90
    background.implicitHeight: 26
}
