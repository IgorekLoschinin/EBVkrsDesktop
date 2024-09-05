import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idBottomBar

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 25  // 35 / coefScale - 4

    QtObject {
        id: proBotBar
        property int sideMargins: 15
        property color colorTxt: '#E8DDDD'
    }

    contentItem: Rectangle {
        color: '#1f2b43'
        radius: bgRadius - 4
        anchors.fill: parent

        Label {
            anchors.fill: parent
            anchors.leftMargin: proBotBar.sideMargins

            text: "By igor.loschinin@gmail.com |"
            font.pixelSize: 12
            color: proBotBar.colorTxt

            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
        }

        Label {
            anchors.fill: parent
            anchors.rightMargin: proBotBar.sideMargins

            text: "| v.1.0.0"
            font.pixelSize: 12
            color: proBotBar.colorTxt

            horizontalAlignment: Qt.AlignRight
            verticalAlignment: Qt.AlignVCenter

        }
    }

}
