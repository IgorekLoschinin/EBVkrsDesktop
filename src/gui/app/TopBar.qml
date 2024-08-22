import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idTopBar

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 52

    contentItem: Rectangle {
        color: '#1f2b43'
        radius: bgRadius

        Image {
            id: imgLogo

            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.topMargin: 7
            anchors.bottomMargin: 7

            source: "../icons/logo_app.png"

            fillMode: Image.PreserveAspectFit

            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
        }

        WindowCtrlBtn { id: idPnlWinCtrlBtn }
    }
}
