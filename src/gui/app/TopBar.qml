import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "controls"

Control {
    id: idTopBar

    Layout.fillWidth: true    
    Layout.preferredHeight: 63 / coefScale

    contentItem: Rectangle {
        color: '#1f2b43'
        radius: bgRadius

        Control {
            id: appLogo

            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter

            contentItem: Image {
                id: imgLogo
                source: "../images/LOGOAPP_new.png"

                fillMode: Image.PreserveAspectFit
                sourceSize.height: 45
                sourceSize.width: 151
            }

        }

        WindowCtrlBtn { id: idPnlWinCtrlBtn }
    }
}
