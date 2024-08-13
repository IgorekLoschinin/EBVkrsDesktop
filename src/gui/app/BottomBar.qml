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
    Layout.fillHeight: true
    Layout.preferredHeight: 35 / coefScale    

    contentItem: Rectangle {
        color: '#1f2b43'
        radius: bgRadius

        Label {
            anchors.fill: parent
            anchors.leftMargin: proBotBar.sideMargins

            text: "By igor.loschinin@gmail.com |"
            color: '#E8DDDD'

            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
        }

        Label {
            anchors.fill: parent
            anchors.rightMargin: proBotBar.sideMargins

            text: "| v.1.0.0"
            color: '#E8DDDD'

            horizontalAlignment: Qt.AlignRight
            verticalAlignment: Qt.AlignVCenter

        }
    }

}
