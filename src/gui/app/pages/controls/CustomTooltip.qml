import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: tooltip

    property var object: null
    property string textLbl: ''
    property int sizeText: 14

    width: 120
    height: implicitHeight

    modal: false
    focus: false
    padding: 4
    visible: object.hovered

    x: object.width / 2 - width / 2
    y: object.height + 5

    contentItem: Text {
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        text: tooltip.textLbl
        font.family: "Segoe UI"
        font.pixelSize: sizeText
        color: "#49454f"
        wrapMode: Text.Wrap
        clip: true
    }

    background: Rectangle {
        color: "#f3edf7"
        radius: 5
        border.color: "#f3edf7"
    }

    onVisibleChanged: {
        if (visible) {
            opacity = 0.0;
            open();
            fadeIn.start();
        }
    }

    NumberAnimation on opacity {
        id: fadeIn
        from: 0;
        to: 1;
        duration: 500
    }
}
