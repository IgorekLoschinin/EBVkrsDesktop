import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idContent

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 763  // 916 / coefScale

    contentItem: Page {
        anchors.fill: parent

        contentItem: Rectangle {
            color: '#2E3350'
            radius: bgRadius
        }

        Label {
            text: "height"

            anchors.centerIn: parent

            horizontalAlignment: Qt.AlignHCenter

        }

        MouseArea {
            anchors.fill: parent
            onPressed: { appWindow.startSystemMove() }
        }

        background: Rectangle {
            color: "#00000000"
        }
    }
}
