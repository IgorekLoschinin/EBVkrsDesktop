import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "controls"


Control {
    id: tabInVar

    readonly property var modFtVar: modelFeatureVar

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

                    model: ListModel {
                        id: modelFeatureVar
                    }

                    delegate: RowLayout {
                        spacing: 10

                        Control {
                            implicitWidth: 80
                            contentItem: Label {
                                text: name
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

                            phText: "0"

                            onEditingFinished: {
                                if (idInVarE.text.length) {
                                    modelFeatureVar.set(
                                        index,
                                        {"varE": idInVarE.text}
                                    )
                                    return
                                }
                            }

                            validator: DoubleValidator {}
                        }

                        CustormTextField {
                            id: idInVarG
                            Layout.fillWidth: true
                            implicitWidth: 80

                            phText: "0"

                            onEditingFinished: {
                                if (idInVarG.text.length) {
                                    modelFeatureVar.set(
                                        index,
                                        {"varG": idInVarG.text}
                                    )
                                    return
                                }
                            }

                            validator: DoubleValidator {}
                        }
                    }

                    Component.onCompleted: {
                        // Сюда с бэкенда отправляется список признаков
                        var featureNames = ["tip", "kt", "rost", "gt", "pz", "conform",
                                            "1tip", "1kt", "1rost", "1gt", "1pz", "1conform",
                                            "2tip", "2kt", "2rost", "2gt", "2pz", "2conform"];

                        for (var i = 0; i < featureNames.length; i++) {
                            modelFeatureVar.append({
                                index: i,
                                name: featureNames[i],
                                varE: "0",
                                varG: "0"
                            });
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
                sourceImg: "../../../icons/save3.svg"
                switchBgColor: true

                onClicked: idSaveFileConf.open()

                FileDialog {
                    id: idSaveFileConf
                    fileMode: FileDialog.SaveFile
                    currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                    onAccepted: console.log(selectedFile)
                }
            }

            ButtonFileOpen {
                id: idBtnFileUpload
                implicitWidth: 80

                sizeImgWH: 25
                sourceImg: "../../../icons/upload3.svg"
                switchBgColor: true

                onClicked: idLoadFileConf.open()

                FileDialog {
                    id: idLoadFileConf
                    fileMode: FileDialog.OpenFile
                    currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
                    onAccepted: console.log(selectedFile)
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
