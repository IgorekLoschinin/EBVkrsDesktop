import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idContent

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 916 / coefScale

    contentItem: Rectangle {
        color: '#2E3350'
        radius: bgRadius

        Label {
            text: "height"

            anchors.centerIn: parent

            horizontalAlignment: Qt.AlignHCenter

        }
    }
}
