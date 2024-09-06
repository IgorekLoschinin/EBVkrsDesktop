import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ComboBox {
    id: root

    implicitHeight: 22
    implicitWidth: 110

    readonly property int radius: 4
    readonly property color textColor: "#FFFFFF"
    readonly property color popupBackground: "#333742"
    readonly property color borderColor: "#ffffff"

    property color hoverColor: "#8792A8"
    property color checkedColor: "#8792A8"

    contentItem: Label {
        anchors.fill: parent
        anchors.leftMargin: 10

        opacity: 0.9
        text: root.displayText
        font.pixelSize: 18

        color: root.textColor

        verticalAlignment: Qt.AlignVCenter
    }

    background: Rectangle {
        radius: root.radius
        color: root.down ? Qt.darker(root.checkedColor, 1.2) : root.checkedColor
    }

    delegate: ItemDelegate {
        id: itemDelegate

        focus: true
        hoverEnabled: true

        width: root.implicitWidth
        height: root.implicitHeight

        Label {
            anchors.fill: parent
            anchors.leftMargin: 4

            opacity: 0.9
            text: modelData
            font.pixelSize: 18
            color: textColor

            verticalAlignment: Qt.AlignVCenter
        }

        background: Rectangle {
            anchors.fill: parent
            radius: root.radius
            color: itemDelegate.hovered ? hoverColor : "transparent"
        }
    }

    popup: Popup {
        width: root.implicitWidth
        y: root.height + 2

        contentItem: ListView {
            clip: true
            focus: true
            keyNavigationEnabled: true

            implicitHeight: contentHeight

            model: root.popup.visible ? root.delegateModel : null
        }

        background: Rectangle {
            clip: true
            radius: root.radius

            color: root.popupBackground
            border.width: 0.5
            border.color: root.borderColor
        }
    }

}
