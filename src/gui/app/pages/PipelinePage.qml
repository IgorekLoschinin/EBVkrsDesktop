import QtQuick
import QtQuick.Controls

Page {

    contentItem: Rectangle {
        color: '#1f2b43'
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
