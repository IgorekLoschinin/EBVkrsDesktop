import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import "app"


ApplicationWindow {
    id: appWindow
    title: qsTr("EBVkrsGUI")
    visible: true
    color: "transparent"

    flags: Qt.Window | Qt.FramelessWindowHint

    property double bgWidth: 1076
    property double bgHeight: 778
    property color bgColor: "#F3FBF7" //"#0A1832"
    property int bgRadius: 10

    property int spacingPanel: 5

    width: bgWidth
    height: bgHeight
    minimumHeight: 600
    minimumWidth: 600

    background: Rectangle {
        id: bgApp
        color: bgColor
        radius: bgRadius

        border.color: "#0A1832"
        border.width: 2

        MouseArea {
            anchors.fill: parent
            onPressed: { appWindow.startSystemMove() }
        }
    }

    contentData: AppContentArea {
        id: idAppContentArea
    }
}
