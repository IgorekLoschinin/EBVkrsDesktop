import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Popup {
    id: idProgressWindow
    anchors.centerIn: parent

    width: 380
    height: 200

    // dim: true
    visible: true
    closePolicy: Popup.NoAutoClose

    Overlay.modeless: Rectangle {
        color: "#aacfdbe7"
        radius: bgRadius

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressed: { appWindow.startSystemMove() }
        }
    }

    contentItem: ColumnLayout {
        id: idContent

        spacing: 5

        Layout.fillWidth: true
        Layout.alignment: Qt.AlignCenter

        ColorImage {
            id: logoImage
            color: "#7ece2d"

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            source: "qrc:/icons/logo_app.png"
            sourceSize.width: 40
            sourceSize.height: 90
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: label1
            Layout.alignment: Qt.AlignCenter

            color: "#ffffff"
            text: qsTr("Data processing in progress...")
            font.family: "Segoe UI"
            font.pointSize: 11
        }

        Label {
            id: label2
            Layout.alignment: Qt.AlignCenter

            color: "#ffffff"
            text: qsTr("processing...")
            font.family: "Segoe UI"
            font.pointSize: 11
        }

        CustomBtn {
            onClicked: dim = true
        }
    }

    background: Rectangle {
        radius: bgRadius
        color: "#0A1832"
    }
}
