import QtQuick
import QtQuick.Controls

Page {
    anchors.fill: parent

    contentItem: Rectangle {
        color: '#2E3350'
        radius: bgRadius
    }

    Label {
        text: "Template page"
        color: "plum"

        anchors.centerIn: parent

        horizontalAlignment: Qt.AlignHCenter

    }

    background: Rectangle {
        color: "transparent"
    }

    MouseArea {
        anchors.fill: parent
        onPressed: { appWindow.startSystemMove() }
    }
}
