import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idTopBar

    Layout.fillWidth: true    
    Layout.preferredHeight: 63 / coefScale

    contentItem: Rectangle {
        color: '#D9D9D9'
        opacity: opacityPanels
        radius: bgRadius
    }
}
