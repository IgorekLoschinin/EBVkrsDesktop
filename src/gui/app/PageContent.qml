import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idContent

    Layout.fillWidth: true
    Layout.preferredHeight: 916 / coefScale

    contentItem: Rectangle {
        color: '#2E3350'
        radius: bgRadius

        Label {
            text: "height"
            horizontalAlignment: Qt.AlignHCenter
            anchors.centerIn: parent
        }
    }
}
