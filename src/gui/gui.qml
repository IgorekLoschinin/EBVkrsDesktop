import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "app"

ApplicationWindow {
    title: "EBVkrsGUI"
    visible: true

    // flags: Qt.Window | Qt.FramelessWindowHint

    property double coefScale: 1.2
    property double bgWidth: 1291 / coefScale
    property double bgHeight: 1054 / coefScale
    property string bgColor: "#0A1832"
    property int bgRadius: 10

    property double opacityPanels: 0.10
    property int spacingPanel: 8

    width: bgWidth
    height: bgHeight
    // minimumHeight: bgHeight
    // minimumWidth: bgWidth


    background: Rectangle {
        id: bgApp
        color: bgColor
        radius: bgRadius
    }

    contentData: AppContentArea {
        id: idAppContentArea
    }
}



