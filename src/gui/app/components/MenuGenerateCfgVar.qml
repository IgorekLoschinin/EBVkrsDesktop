import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "../pages/controls"


Popup {
    id: modalWindGenCfgVar

    readonly property color bgColorWindow: "#0A1832"

    readonly property color btnColorDef: "#5d6575"
    readonly property color btnColorMouseOver: "#8792A8"
    readonly property color btnColorPressed: "#4A515E"

    function statusGen() {
        {
            switch (backend.ebv_model.generator_var.fin_code) {
            case 0:
                return qsTr("Successful completion!")

            case 1:
                return qsTr("Error completion!")

            case 2:
                return qsTr("processing...")

            case 3:
                return qsTr("Variance is saved!")

            case -1:
                return qsTr("status")
            }
        }
    }

    anchors.centerIn: Overlay.overlay

    width: 450
    height: 240

    dim: true
    visible: false

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

            color: "#ffffff"
            text: qsTr("Generate config")
            font.family: "Segoe UI"
            font.pointSize: 13
            font.bold: true
            wrapMode: Text.WordWrap

            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.bottomMargin: 8

            // Display
            Control {
                id: idDisplay                

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: modalWindGenCfgVar.width * 0.75
                Layout.preferredHeight: modalWindGenCfgVar.height * 0.75


                contentItem: ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Layout.alignment: Qt.AlignCenter

                    Label {
                        id: lblMethodGenerate

                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignBottom

                        color: "#ffffff"
                        text: qsTr("From is ... :")
                        font.family: "Segoe UI"
                        font.pointSize: 12
                        font.bold: true
                        wrapMode: Text.WordWrap

                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        id: lblBody

                        Layout.fillWidth: true
                        color: "#ffffff"
                        text: qsTr("-= Select a file or folder =-")
                        font.family: "Segoe UI"
                        font.pointSize: 12
                        wrapMode: Text.WordWrap

                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        id: lblInfoProgress

                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop

                        color: "#ffffff"
                        text: statusGen()
                        font.family: "Segoe UI"
                        font.pointSize: 12
                        font.bold: true
                        wrapMode: Text.WordWrap

                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    color: "#498AF5"
                    radius: bgRadius
                }

            }

            // ButtonPanel
            Control {
                id: idBtnPanel
                padding: 0

                Layout.fillWidth: true
                Layout.fillHeight: true

                contentItem: ColumnLayout {
                    spacing: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    CustomBtn {
                        id: idBtnFromFile

                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignBottom

                        sizeImgWH: 25
                        srcImg: "qrc:/cfgvar/icons/icBtnGenCfgVar/file.svg"

                        onClicked: idOpenFromFile.open()

                        FileDialog {
                            id: idOpenFromFile
                            fileMode: FileDialog.OpenFile
                            currentFile: StandardPaths.standardLocations(StandardPaths.LocateFile)[0]
                            onAccepted: {
                                backend.ebv_model.generator_var.from_path(
                                    rePath(selectedFile.toString())
                                )
                                lblMethodGenerate.text = qsTr("From is file:")
                                lblBody.text = rePath(selectedFile.toString())
                            }
                        }

                        CustomTooltip {
                            object: idBtnFromFile
                            textLbl: qsTr("From file.")

                            visible: disableTT ? idBtnFromFile.hovered : false
                        }
                    }

                    CustomBtn {
                        id: idBtnFromDir

                        Layout.fillWidth: true

                        sizeImgWH: 25
                        srcImg: "qrc:/cfgvar/icons/icBtnGenCfgVar/open-folder.svg"

                        onClicked: idOpenFromDir.open()

                        FolderDialog {
                            id: idOpenFromDir
                            currentFolder: StandardPaths.standardLocations(StandardPaths.LocateDirectory)[0]
                            onAccepted: {
                                backend.ebv_model.generator_var.from_path(
                                    rePath(selectedFolder.toString())
                                )
                                lblMethodGenerate.text = qsTr("From is dir:")
                                lblBody.text = rePath(selectedFolder.toString())
                            }
                        }

                        CustomTooltip {
                            object: idBtnFromDir
                            textLbl: qsTr("From dir.")

                            visible: disableTT ? idBtnFromDir.hovered : false
                        }
                    }

                    CustomBtn {
                        id: idBtnCreateFileCfg

                        Layout.fillWidth: true
                        Layout.topMargin: 15
                        Layout.alignment: Qt.AlignTop

                        sizeImgWH: 25
                        srcImg: "qrc:/cfgvar/icons/icBtnGenCfgVar/create.svg"

                        onClicked: backend.ebv_model.generator_var.create()

                        CustomTooltip {
                            object: idBtnCreateFileCfg
                            textLbl: qsTr("Create a config file.")

                            visible: disableTT ? idBtnCreateFileCfg.hovered : false
                        }

                        background.implicitWidth: 50
                    }
                }
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

                dlgColorDef: btnColorDef
                dlgColorMouseOver: btnColorMouseOver
                dlgColorPressed: btnColorPressed

                contentItem: Text {
                    text: qsTr("OK")

                    font.family: "Segoe UI"
                    font.pixelSize: 16

                    color: "#ffffff"

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background.implicitWidth: 80
                background.implicitHeight: 33

                onClicked: modalWindGenCfgVar.close()
            }

            CustomBtn {
                id: idBtnSave

                Layout.bottomMargin: 6

                hoverEnabled: backend.ebv_model.generator_var.fin_code === 0
                enabled: backend.ebv_model.generator_var.fin_code === 0
                opacity: backend.ebv_model.generator_var.fin_code === 0 ? 1 : 0.5

                sizeImgWH: 25
                srcImg: "qrc:/icons/save.svg"

                onClicked: idSaveFileConf.open()

                FileDialog {
                    id: idSaveFileConf
                    fileMode: FileDialog.SaveFile
                    currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                    onAccepted: backend.ebv_model.generator_var.save(
                        rePath(selectedFile.toString())
                    )
                }

                CustomTooltip {
                    object: idBtnSave
                    textLbl: qsTr("Save variances data to a file.")

                    visible: disableTT ? idBtnSave.hovered : false
                }

                background.implicitWidth: 80
            }

            Item { Layout.preferredWidth: 20 }
        }
    }

    background: Rectangle {
        radius: bgRadius
        color: bgColorWindow
    }
}
