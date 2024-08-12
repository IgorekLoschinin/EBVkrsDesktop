import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Кнопка для открытия и закрытия шторки
Button {
    id: toggleButton
    // anchors.centerIn: parent

    Layout.fillWidth: true
    Layout.fillHeight: true

    contentItem: Label {
        text: customDrawer.state === "opened" ? "Close Drawer" : "Open Drawer"
        anchors.centerIn: parent
    }

    background: Rectangle {
        // anchors.fill: parent
        color: "plum"
        radius: bgRadius
    }

    onClicked: {
        if (customDrawer.state === "opened") {
            customDrawer.closeDrawer()
        } else {
            customDrawer.openDrawer()
        }
    }
}

