import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "app"

ApplicationWindow {
    id: appWindow
    title: qsTr("EBVkrsGUI")
    visible: true
    color: "transparent"

    // flags: Qt.Window | Qt.FramelessWindowHint

    property double bgWidth: 1076
    property double bgHeight: 878
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
