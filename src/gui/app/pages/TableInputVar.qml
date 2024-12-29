import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "controls"


Control {
    id: tabInVar

    property var defVariance: null

    readonly property var modFtVar: modelFeatureVar
    readonly property var fieldsName: backend.get_fields_table

    function getVariance(ftVar) {
        var allData = {};
        for (var i = 0; i < ftVar.count; i++) {
            var item = ftVar.get(i);

            allData[item.name] = {
                "varE": item.varE === '0' ? null : item.varE,
                "varG": item.varG === '0' ? null : item.varG
            };
        }

        return allData
    }

    function createTable(fields) {
        for (var i = 0; i < fields.length; i++) {
            modelFeatureVar.append({
                // index: i,
                name: fields[i],
                varE: "0",
                varG: "0"
            });
        }

        defVariance = getVariance(modelFeatureVar);

        return modelFeatureVar
    }

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

                ListModel {
                    id: modelFeatureVar
                }

                ListView {
                    id: listInputVar
                    clip: true
                    spacing: 10

                    implicitHeight: 250
                    implicitWidth: 300

                    model: {

                        if (modelFeatureVar.count > 0) {

                            modelFeatureVar.clear()
                            // createTable(fieldsName[idFeatureEbv.displayText])
                            // defVariance = getVariance(modelFeatureVar);
                            // return modelFeatureVar
                        }

                        createTable(fieldsName[idFeatureEbv.displayText])
                        return modelFeatureVar
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
                                        index, {"varE": idInVarE.text}
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
                                        index, {"varG": idInVarG.text}
                                    )
                                    return
                                }
                            }

                            validator: DoubleValidator {}
                        }
                    }

                    // Component.onCompleted: {
                    //     createTable(fieldsName[idFeatureEbv.displayText])
                    //     defVariance = getVariance(modelFeatureVar);
                    // }
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
                    onAccepted: console.log(selectedFile)
                }

                CustomTooltip {
                    object: idBtnFileSave
                    textLbl: qsTr("Save the variance in file.")
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
                    onAccepted: console.log(selectedFile)
                }

                CustomTooltip {
                    object: idBtnFileUpload
                    textLbl: qsTr("Load the variance from file.")
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
