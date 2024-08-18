import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "app"

ApplicationWindow {
    id: appWindow
    title: qsTr("EBVkrsGUI")
    visible: true
    color: "#00000000"

    // flags: Qt.Window | Qt.FramelessWindowHint

    // property double coefScale: 1.2
    property double bgWidth: 1076  // 1291 / coefScale
    property double bgHeight: 878  // 1054 / coefScale
    property color bgColor: "#0A1832"
    property int bgRadius: 10

    property int spacingPanel: 8

    width: bgWidth
    height: bgHeight
    minimumHeight: 600
    minimumWidth: 600

    background: Rectangle {
        id: bgApp
        color: bgColor
        radius: bgRadius

        MouseArea {
            anchors.fill: parent
            onPressed: { appWindow.startSystemMove() }
        }
    }

    contentData: AppContentArea {
        id: idAppContentArea
    }
}
