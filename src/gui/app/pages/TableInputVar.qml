import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "controls"


Control {
    id: tabInVar

    property alias tableVar: listInputVar.model
    property string tableName: ""

    contentItem: RowLayout {

        Item {
            Layout.fillWidth: true
        }

        ColumnLayout {
            // Header table
            RowLayout {
                spacing: 10

                Control {
                    Layout.leftMargin: 105

                    implicitWidth: 80
                    contentItem: Label {
                        text: "VarE"
                        font.pixelSize: sizeTextInSect
                        font.family: "Segoe UI"
                        color: txtSection

                        leftPadding: 13
                    }
                }

                Control {
                    implicitWidth: 80
                    contentItem: Label {
                        text: "VarG"
                        font.pixelSize: sizeTextInSect
                        font.family: "Segoe UI"
                        color: txtSection

                        leftPadding: 13
                    }
                }
            }

            // Body - row and col
            RowLayout {
                ListView {
                    id: listInputVar
                    clip: true
                    spacing: 10

                    implicitHeight: 250
                    implicitWidth: 300

                    // highlight: Rectangle { color: "lightblue"; radius: 5 }

                    delegate: RowLayout {
                        spacing: 10

                        Control {
                            implicitWidth: 80
                            contentItem: Label {
                                text: ftName
                                font.pixelSize: sizeTextInSect
                                font.family: "Segoe UI"
                                color: txtSection

                                horizontalAlignment: Qt.AlignRight
                            }
                        }

                        CustormTextField {
                            id: idInVarE
                            Layout.fillWidth: true
                            implicitWidth: 80

                            phText: '0'
                            text: varE // === undefined ? "" : varE

                            onEditingFinished: varE = idInVarE.text
                            onTextEdited: {
                                if (idInVarE.text.length === 0) {
                                    varE = null
                                }
                            }

                            validator: DoubleValidator {}
                        }

                        CustormTextField {
                            id: idInVarG
                            Layout.fillWidth: true
                            implicitWidth: 80

                            phText: '0'
                            text: varG // === undefined ? "" : varG

                            onEditingFinished: varG = idInVarG.text
                            onTextEdited: {
                                if (idInVarG.text.length === 0) {
                                    varG = null
                                }
                            }

                            validator: DoubleValidator {}
                        }
                    }
                }
            }
        }

        RowLayout {
            spacing: 5
            Layout.fillWidth: true

            ButtonFileOpen {
                id: idBtnFileSave
                implicitWidth: 80

                sizeImgWH: 25
                sourceImg: "qrc:/icons/save.svg"
                switchBgColor: true

                onClicked: idSaveFileConf.open()

                FileDialog {
                    id: idSaveFileConf
                    fileMode: FileDialog.SaveFile
                    currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                    onAccepted: backend.ebv_model.save_variance_conf(
                        tabInVar.tableName, rePath(selectedFile.toString())
                    )
                }

                CustomTooltip {
                    object: idBtnFileSave
                    textLbl: qsTr("Save the variance in file.")

                    visible: disableTT ? idBtnFileSave.hovered : false
                }
            }

            ButtonFileOpen {
                id: idBtnFileUpload
                implicitWidth: 80

                sizeImgWH: 25
                sourceImg: "qrc:/icons/upload.svg"
                switchBgColor: true

                onClicked: idLoadFileConf.open()

                FileDialog {
                    id: idLoadFileConf
                    fileMode: FileDialog.OpenFile
                    currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
                    onAccepted: backend.ebv_model.load_variance_conf(tabInVar.tableName, rePath(selectedFile.toString()))
                }

                CustomTooltip {
                    object: idBtnFileUpload
                    textLbl: qsTr("Load the variance from file.")

                    visible: disableTT ? idBtnFileUpload.hovered : false
                }
            }

            CustomBtn {
                id: idResetModel

                sizeImgWH: 25
                srcImg: "qrc:/icons/reset.svg"

                onClicked: listInputVar.model.reset()

                CustomTooltip {
                    object: idResetModel
                    textLbl: qsTr("Reset entered data.")

                    visible: disableTT ? idResetModel.hovered : false
                }

                background.implicitWidth: 80
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }

}
