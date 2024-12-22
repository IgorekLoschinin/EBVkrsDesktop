import QtQuick
import QtQuick.Controls

CustomBtn {
    id: idBtnCancel

    dlgColorDef: "#5d6575"
    dlgColorMouseOver: "#8792A8"
    dlgColorPressed: "#4A515E"

    contentItem: Text {
        text: qsTr("Cancel")

        font.family: "Segoe UI"
        font.pixelSize: 16

        color: "#ffffff"

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    background.implicitWidth: 80

    onClicked: backend.stop()
}
