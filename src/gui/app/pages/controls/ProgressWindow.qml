import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Popup {
    id: idProgressWindow
    anchors.centerIn: parent

    width: 350
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

        Layout.fillWidth: true
        Layout.fillHeight: true

        ColorImage {
            id: logoImage
            color: "#7ece2d"

            Layout.fillWidth: true
            Layout.topMargin: 8
            Layout.bottomMargin: 15

            source: "qrc:/icons/logo_app.png"
            sourceSize.width: 25
            sourceSize.height: 50
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: lblInfo

            Layout.alignment: Qt.AlignCenter

            color: "#ffffff"
            text: qsTr("Data processing has started!")
            font.family: "Segoe UI"
            font.pointSize: 11
        }

        Label {
            id: labelProgress

            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true

            color: "#ffffff"
            text: qsTr("processing...")
            font.family: "Segoe UI"
            font.pointSize: 11
        }

        ButtonStop {
            Layout.rightMargin: 8
            Layout.bottomMargin: 8
            Layout.alignment: Qt.AlignRight
        }
    }

    background: Rectangle {
        radius: bgRadius
        color: "#0A1832"
    }
}
