import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "controls"

Control {
    id: idTopBar

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 63 / coefScale

    contentItem: Rectangle {
        color: '#1f2b43'
        radius: bgRadius

        Image {
            id: imgLogo

            anchors.fill: parent
            anchors.leftMargin: 15

            source: "../icons/logo_app.png"

            fillMode: Image.PreserveAspectFit

            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
        }

        WindowCtrlBtn { id: idPnlWinCtrlBtn }
    }
}
