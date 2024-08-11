import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idBottomBar

    QtObject {
        id: proBotBar
        property int sideMargins: 20
        property int topBotMargins: 6
    }

    Layout.fillWidth: true    
    Layout.preferredHeight: 35 / coefScale

    contentItem: Rectangle {
        color: '#D9D9D9'
        opacity: opacityPanels
        radius: bgRadius

        Label {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: proBotBar.sideMargins
            anchors.bottomMargin: proBotBar.topBotMargins
            anchors.topMargin: proBotBar.topBotMargins

            text: "By igor.loschinin@gmail.com |"
            color: '#E8DDDD'
        }

        Label {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: proBotBar.sideMargins
            anchors.bottomMargin: proBotBar.topBotMargins
            anchors.topMargin: proBotBar.topBotMargins

            text: "| v.1.0.0"
            color: '#E8DDDD'
        }
    }

}
