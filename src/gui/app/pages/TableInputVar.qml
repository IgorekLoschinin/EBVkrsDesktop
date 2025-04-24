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

    // Преобразует объект модели в словарь для передачи в бэкенд
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

    function getDefVariance(objModel) {
        var allData = {};

        for (var i = 0; i < objModel.count; i++) {
            var item = objModel.get(i);

            allData[item.name] = {
                "varE": null,
                "varG": null
            };
        }

        return allData
    }

    function createTablVar(lstSubFt) {
        // var data = {};

        // for (var i = 0; i < lstDubFt.length; i++) {
        //     data[lstDubFt[i]] = {
        //         "varE": null,
        //         "varG": null
        //     };
        // }

        // return data

        if (objModel.count > 0) {
            return objModel
        }

        lstFieldName.forEach(
            (elem) => objModel.append({
                name: elem,
                varE: "0",
                varG: "0"
            })
        )

        return objModel
    }

    // Метод, который заполняет данные из файла когда используется конфиг
    function setVarinace(data) {
        var subFtVar = backend.ebv_model.get_fields_table[idFeatureEbv.currentText]

        if (currentModel !== null) {
            currentModel.clear()

            subFtVar.forEach(
                (elem) => currentModel.append({
                    name: elem,
                    varE: data[elem].varE === undefined ? "0" : data[elem].varE.toString(),
                    varG: data[elem].varG === undefined ? "0" : data[elem].varG.toString()
                })
            )
        }

    }

    // Используется при выборе метода оценки - all or conf
    function reloadTable(curInd) {
        currentModel = modelsFtVar[curInd]
    }

    // Инициализация модели - подготовка модели
    function initTable(objModel, lstFieldName) {

        if (objModel.count > 0) {
            return objModel
        }

        lstFieldName.forEach(
            (elem) => objModel.append({
                name: elem,
                varE: "0",
                varG: "0"
            })
        )

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

                    // highlight: Rectangle { color: "lightblue"; radius: 5 }

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

                            phText: varE

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

                            phText: varG

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
                    onAccepted: backend.ebv_model.save_variance_conf(
                        tabInVar.getVariance(tabInVar.currentModel),
                        rePath(selectedFile.toString())
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
                    onAccepted: backend.ebv_model.load_variance_conf(rePath(selectedFile.toString()))
                }

                CustomTooltip {
                    object: idBtnFileUpload
                    textLbl: qsTr("Load the variance from file.")

                    visible: disableTT ? idBtnFileUpload.hovered : false
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Connections {
        target: backend.ebv_model

        function onUploadVar (data) {
            setVarinace(data)
        }
    }
}
