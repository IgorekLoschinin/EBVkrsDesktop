import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idBottomBar

    QtObject {
        id: proBotBar
        property int sideMargins: 15
    }

    Layout.fillWidth: true    
    Layout.preferredHeight: 35 / coefScale

    contentItem: Rectangle {
        color: '#1f2b43'
        radius: bgRadius

        Label {
            anchors.left: parent.left
            anchors.leftMargin: proBotBar.sideMargins
            anchors.verticalCenter: parent.verticalCenter

            text: "By igor.loschinin@gmail.com |"
            color: '#E8DDDD'
        }

        Label {
            anchors.right: parent.right            
            anchors.rightMargin: proBotBar.sideMargins            
            anchors.verticalCenter: parent.verticalCenter

            text: "| v.1.0.0"
            color: '#E8DDDD'
        }
    }

}
