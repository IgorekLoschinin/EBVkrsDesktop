import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../pages/controls"


Popup {
    id: modalWindGenCfgVar

    property string nameProcess: ""
    property string textMsgProgress: ""

    readonly property color colorDef: "transparent"
    readonly property color colorMouseOver: "#8792A8"
    readonly property color colorPressed: "#4A515E"

    anchors.centerIn: Overlay.overlay

    width: 480
    height: 240

    dim: true
    visible: false
    // padding: 0

    closePolicy: Popup.NoAutoClose

    Overlay.modeless: Rectangle {
        color: "transparent"
        radius: bgRadius

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressed: { appWindow.startSystemMove() }
        }

        ColorAnimation on color {
            to: "#aacfdbe7"
            duration: 300
            easing.type: Easing.InOutQuad
            easing.amplitude: 1.0;
            easing.period: 1
        }
    }

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: 0.8
            to: 1.0
            duration: 300
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 200
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "scale"
            from: 1.0
            to: 0.8
            duration: 300
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 200
        }
    }

    contentItem: ColumnLayout {
        id: idContentPB

        Layout.fillWidth: true
        Layout.fillHeight: true

        Label {
            id: lblTitle

            Layout.fillWidth: true
            // // Layout.leftMargin: 8
            // // Layout.rightMargin: 8

            color: "#ffffff"
            text: qsTr("Generate config")
            font.family: "Segoe UI"
            font.pointSize: 15
            font.bold: true
            wrapMode: Text.WordWrap

            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        RowLayout {
            // spacing: 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Layout.leftMargin: 8
            Layout.bottomMargin: 8

            Control {
                id: idDisplay
                // padding: 0

                Layout.fillWidth: true
                Layout.fillHeight: true

                contentItem: ColumnLayout {
                    // spacing: 0

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Label {
                        id: lblMethodGenerate

                        Layout.fillWidth: true
                        // Layout.leftMargin: 8
                        // Layout.rightMargin: 8

                        color: "#ffffff"
                        text: qsTr("From is file:")
                        font.family: "Segoe UI"
                        font.pointSize: 13
                        font.bold: true
                        wrapMode: Text.WordWrap

                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        id: lblBody

                        Layout.fillWidth: true
                        // Layout.leftMargin: 8
                        // Layout.rightMargin: 8

                        color: "#ffffff"
                        text: qsTr("report/blup/STAT_ConformationIndex_COWS.xlsx")
                        font.family: "Segoe UI"
                        font.pointSize: 12
                        // font.bold: true
                        wrapMode: Text.WordWrap

                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        id: lblInfoProgress

                        Layout.fillWidth: true
                        // Layout.leftMargin: 8
                        // Layout.rightMargin: 8

                        color: "#ffffff"
                        text: qsTr("processing...")
                        font.family: "Segoe UI"
                        font.pointSize: 13
                        font.bold: true
                        wrapMode: Text.WordWrap

                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    color: "plum"
                    radius: bgRadius
                }

            }

            Control {
                id: idBtnPanel
                padding: 0

                Layout.fillWidth: true
                Layout.fillHeight: true
                // Layout.leftMargin: 8
                // Layout.rightMargin: 8

                contentItem: ColumnLayout {
                    spacing: 0
                    // Layout.fillWidth: true
                    // Layout.fillHeight: true

                    // Item { Layout.fillWidth: true }

                    CustomBtn {
                        id: idBtnFromFile
                        Layout.alignment: Qt.AlignBottom

                        Layout.fillWidth: true

                        // Layout.bottomMargin: 6

                        // hoverEnabled: backend.finished
                        // enabled: backend.finished
                        // opacity: backend.finished ? 1 : 0.5

                        dlgColorDef: "#5d6575"
                        dlgColorMouseOver: "#8792A8"
                        dlgColorPressed: "#4A515E"

                        contentItem: Text {
                            text: qsTr("from file")

                            font.family: "Segoe UI"
                            font.pixelSize: 16

                            color: "#ffffff"

                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }

                        // background.implicitHeight: 40

                        onClicked: modalWindGenCfgVar.close()
                    }

                    CustomBtn {
                        id: idBtnFromDir

                        Layout.fillWidth: true

                        // Layout.bottomMargin: 6

                        // hoverEnabled: backend.finished
                        // enabled: backend.finished
                        // opacity: backend.finished ? 1 : 0.5

                        dlgColorDef: "#5d6575"
                        dlgColorMouseOver: "#8792A8"
                        dlgColorPressed: "#4A515E"

                        contentItem: Text {
                            text: qsTr("from dir")

                            font.family: "Segoe UI"
                            font.pixelSize: 16

                            color: "#ffffff"

                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }

                        // background.implicitWidth: 80

                        onClicked: modalWindGenCfgVar.close()
                    }

                    CustomBtn {
                        id: idBtnCreate
                        Layout.alignment: Qt.AlignTop

                        Layout.fillWidth: true

                        // Layout.bottomMargin: 6

                        // hoverEnabled: backend.finished
                        // enabled: backend.finished
                        // opacity: backend.finished ? 1 : 0.5

                        dlgColorDef: "#5d6575"
                        dlgColorMouseOver: "#8792A8"
                        dlgColorPressed: "#4A515E"

                        contentItem: Text {
                            text: qsTr("Create")

                            font.family: "Segoe UI"
                            font.pixelSize: 16

                            color: "#ffffff"

                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }

                        // background.implicitWidth: 80

                        onClicked: modalWindGenCfgVar.close()
                    }

                    // Item { Layout.fillWidth: true }
                }

                // background: Rectangle {
                //     color: "yellow"
                //     radius: bgRadius
                // }
            }

        }

        RowLayout {
            id: controlWindowBtn

            Layout.fillWidth: true
            Layout.fillHeight: true

            spacing: 5
            Item { Layout.fillWidth: true }

            CustomBtn {
                id: idBtnOK

                Layout.bottomMargin: 6

                // hoverEnabled: backend.finished
                // enabled: backend.finished
                // opacity: backend.finished ? 1 : 0.5

                dlgColorDef: "#5d6575"
                dlgColorMouseOver: "#8792A8"
                dlgColorPressed: "#4A515E"

                contentItem: Text {
                    text: qsTr("OK")

                    font.family: "Segoe UI"
                    font.pixelSize: 16

                    color: "#ffffff"

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background.implicitWidth: 80

                onClicked: modalWindGenCfgVar.close()
            }

            CustomBtn {
                id: idBtnSave

                Layout.bottomMargin: 6

                // hoverEnabled: backend.finished
                // enabled: backend.finished
                // opacity: backend.finished ? 1 : 0.5

                dlgColorDef: "#5d6575"
                dlgColorMouseOver: "#8792A8"
                dlgColorPressed: "#4A515E"

                contentItem: Text {
                    text: qsTr("Save")

                    font.family: "Segoe UI"
                    font.pixelSize: 16

                    color: "#ffffff"

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background.implicitWidth: 80

                onClicked: modalWindGenCfgVar.close()
            }

            Item {
                // Layout.fillWidth: true
                Layout.preferredWidth: 40
            }
        }
    }

    background: Rectangle {
        radius: bgRadius
        color: "#0A1832"
    }
}
