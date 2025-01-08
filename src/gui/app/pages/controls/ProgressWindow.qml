import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Popup {
    id: idProgressWindow

    property string nameProcess: ""
    property string textMsgProgress: ""

    width: 350
    height: 200

    dim: backend.enable_prg_win
    visible: backend.enable_prg_win

    x: appWindow.width / 2 - width - 2
    y: appWindow.height / 2 - height - 2

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
        id: idContentPB

        Layout.fillWidth: true
        Layout.fillHeight: true

        ColorImage {
            id: logoImage
            color: "#7ece2d"

            Layout.fillWidth: true
            Layout.topMargin: 8
            Layout.bottomMargin: 3

            source: "qrc:/icons/logo_app.png"
            sourceSize.width: 25
            sourceSize.height: 50
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: lblInfo

            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8

            color: "#ffffff"
            text: nameProcess
            font.family: "Segoe UI"
            font.pointSize: 13
            font.bold: true
            wrapMode: Text.WordWrap

            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        Label {
            id: labelProgress

            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true

            color: "#ffffff"
            text: {
                switch (backend.finished_code) {
                case 0:
                    return qsTr("Successful completion!")

                case 1:
                    return qsTr("Error completion!")

                case -1:
                    return qsTr("processing...")
                }                
            }

            font.family: "Segoe UI"
            font.pointSize: 11
            wrapMode: Text.WordWrap
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
