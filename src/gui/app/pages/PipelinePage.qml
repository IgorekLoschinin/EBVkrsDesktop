import QtQuick
import QtQuick.Controls

Page {

    contentItem: Rectangle {
        color: '#2E3350'
        radius: bgRadius
    }

    Label {
        text: "Pipline page"
        color: "plum"

        anchors.centerIn: parent

        horizontalAlignment: Qt.AlignHCenter

    }

    MouseArea {
        anchors.fill: parent
        onPressed: { appWindow.startSystemMove() }
    }

    background: Rectangle {
        color: "transparent"
    }
}
