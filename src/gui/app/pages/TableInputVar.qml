import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "controls"


Control {
    id: tabInVar

    readonly property var modelsFtVar: [
        modelMilk, modelConf, modelRepr, modelScs
    ]

    property var defVariance: null
    property var currentModel: null

    function getVariance(objModel) {
        var allData = {};

        for (var i = 0; i < objModel.count; i++) {
            var item = objModel.get(i);

            allData[item.name] = {
                "varE": item.varE === '0' ? null : item.varE,
                "varG": item.varG === '0' ? null : item.varG
            };
        }

        return allData
    }

    function setVarinace(data) {
        var subFtVar = backend.get_fields_table[idFeatureEbv.currentText]

        if (currentModel !== null) {
            currentModel.clear()
            subFtVar.forEach(
                (elem) => currentModel.append({
                    name: elem,
                    varE: data[elem].varE === 'null' ? "0" : data[elem].varE,
                    varG: data[elem].varG === 'null' ? "0" : data[elem].varG
                })
            )

        }

        // backend.print_qml(getVariance(currentModel))


    }

    function reloadTable(curInd) {
        currentModel = modelsFtVar[curInd]
    }

    function createTable(objModel, lstFieldName) {
        lstFieldName.forEach(
            (elem) => objModel.append({
                name: elem,
                varE: "0",
                varG: "0"
            })
        )

        tabInVar.defVariance = getVariance(objModel);

        return objModel
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

                ListModel { id: modelMilk }
                ListModel { id: modelConf }
                ListModel { id: modelRepr }
                ListModel { id: modelScs }

                ListView {
                    id: listInputVar
                    clip: true
                    spacing: 10

                    implicitHeight: 250
                    implicitWidth: 300

                    model: currentModel

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

                            phText: currentModel.get(index).varE

                            onEditingFinished: {
                                currentModel.set(
                                    index,
                                    {"varE": idInVarE.text}
                                )
                            }

                            validator: DoubleValidator {}
                        }

                        CustormTextField {
                            id: idInVarG
                            Layout.fillWidth: true
                            implicitWidth: 80

                            phText: "0"

                            onEditingFinished: {
                                currentModel.set(
                                    index,
                                    {"varG": idInVarG.text}
                                )
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
                    onAccepted: backend.save_variance_conf(rePath(selectedFile.toString()))
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
                    onAccepted: backend.load_variance_conf(rePath(selectedFile.toString()))
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

    Connections {
        target: backend

        function onUploadVar (data) {
            setVarinace(data)
            // backend.print_qml(data)
        }
    }
}
