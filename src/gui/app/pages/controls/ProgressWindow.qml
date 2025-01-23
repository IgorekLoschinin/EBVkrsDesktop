import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Popup {
    id: idProgressWindow

    property string nameProcess: ""
    property string textMsgProgress: ""

    readonly property color colorDef: "transparent"
    readonly property color colorMouseOver: "#8792A8"
    readonly property color colorPressed: "#4A515E"

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

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.topMargin: 8
            Layout.bottomMargin: 3
            Layout.rightMargin: 8

            ColorImage {
                id: logoImage
                color: "#7ece2d"

                Layout.leftMargin: 90

                source: "qrc:/icons/logo_app.png"
                sourceSize.width: 25
                sourceSize.height: 50
                fillMode: Image.PreserveAspectFit
            }

            Item { Layout.fillWidth: true }

            Button {
                id: idBtnRoll

                Layout.alignment: Qt.AlignTop

                CustomTooltip {
                    id: ttBtnWC

                    object: idBtnRoll
                    textLbl: qsTr("Minimize")
                    sizeText: 12

                    x: - ttBtnWC.width + object.width
                }

                contentItem: ColorImage {
                    source: "qrc:/icons/minus.svg"
                    color: "white"

                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: 13
                    sourceSize.width: 13
                }

                background: Rectangle {
                    color: {
                        if (idBtnRoll.down) {
                            return colorPressed
                        } else {
                            if (idBtnRoll.hovered) {
                                return colorMouseOver
                            }
                        }

                        return colorDef
                    }

                    implicitHeight: 20
                    implicitWidth: 20
                    radius: 5
                }

                onClicked: appWindow.showMinimized()
            }
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

        RowLayout {
            spacing: 5
            Item { Layout.fillWidth: true }
            CustomBtn {
                id: idBtnOK

                Layout.bottomMargin: 6

                hoverEnabled: backend.finished
                enabled: backend.finished
                opacity: backend.finished ? 1 : 0.5

                dlgColorDef: "#5d6575"
                dlgColorMouseOver: "#8792A8"
                dlgColorPressed: "#4A515E"

                contentItem: Text {
                    text: qsTr("Ok")

                    font.family: "Segoe UI"
                    font.pixelSize: 16

                    color: "#ffffff"

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background.implicitWidth: 80

                onClicked: backend.ok()
            }

            ButtonStop {
                hoverEnabled: !backend.finished
                enabled: !backend.finished
                opacity: !backend.finished ? 1 : 0.5

                Layout.rightMargin: 6
                Layout.bottomMargin: 6
            }
        }
    }

    background: Rectangle {
        radius: bgRadius
        color: "#0A1832"
    }
}
