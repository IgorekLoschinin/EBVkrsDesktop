import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingPheno
    urlPage: qsTr("Processing of phenotypic data")

    sendForm: {
        'id': 'procpheno',
        'preparation': {
            'checked': idSHeadSectAddProp.checked,
            'updatabd': {
                'checked': idCheckBoxUpdataDB.checked,
                'pathto': idInputUpdateTo.inputText.length === 0 ? null : idInputUpdateTo.inputText,
                'pathfrom': idInputUpdateFrom.inputText.length === 0 ? null : idInputUpdateFrom.inputText,
            },
            'searchdaug': {
                'datafiles': idDirDataFilesForSearch.inputText.length === 0 ? null : idDirDataFilesForSearch.inputText,
                'filesires': idInputSearchDaug.inputText.length === 0 ? null : idInputSearchDaug.inputText,
            }
        },
        'phendata': idDirDataFiles.inputText.length === 0 ? null : idDirDataFiles.inputText,
        'feature': !idControlSelectFtDp.checked ? null : idSelectFeatureDp.displayText,
        'accummeth': idAccumulateDp.checked,
        'numlact': idNumLactation.currentIndex,
        'ped': idCheckBoxPed.checked,
        'daughters': idCheckBoxDaug.checked,
        'selectdata': {
            'checked': idCBSelectData.checked,
            'filefarm': idInputFarm.inputText.length === 0 ? null : idInputFarm.inputText,
            'removedaug': idInputRemoveDaug.inputText.length === 0 ? null : idInputRemoveDaug.inputText,
        }
    }

    Component {
        id: pBpheno
        ProgressWindow {
            nameProcess: qsTr("Data processing has started!")
        }
    }

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: comSpacing

            Loader {
                sourceComponent: {
                    if (idContent.currentIndex === 2) {
                        return pBpheno
                    }
                    return null
                }
            }

            // Section preparation data
            GroupBox {
                id: idAdditPropSection
                padding: 0

                Layout.topMargin: 10
                Layout.fillWidth: true

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    SwitchHeadSectCont {
                        id: idSHeadSectAddProp

                        Layout.fillWidth: true
                        Layout.bottomMargin: bottomMarginContentSect

                        nameSection: qsTr("Preparation data")
                    }                

                    ColumnLayout {
                        spacing: comSpacing
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        enabled: idSHeadSectAddProp.checked
                        opacity: idSHeadSectAddProp.checked ? 1 : 0.5

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true

                            label: CustomCheckbox {
                                id: idCheckBoxUpdataDB

                                nameChb: qsTr("Updata data base")
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxUpdataDB.checked
                                opacity: idCheckBoxUpdataDB.checked ? 1 : 0.5

                                Text {
                                    text: qsTr("Update data:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                InputGroupFolder {
                                    id: idInputUpdateTo
                                    nameField: qsTr("to")

                                    Layout.fillWidth: true
                                }

                                InputGroupFolder {
                                    id: idInputUpdateFrom
                                    nameField: qsTr("from")

                                    Layout.fillWidth: true
                                    Layout.leftMargin: 30
                                }

                            }

                            background: null
                        }

                        GroupBox {
                            id: idLblSearchDaug
                            padding: 0
                            Layout.fillWidth: true

                            enabled: !idCheckBoxUpdataDB.checked
                            opacity: !idCheckBoxUpdataDB.checked ? 1 : 0.5

                            label: Label {
                                text: qsTr("Search daughters:")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            contentData: ColumnLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                InputGroupFolder {
                                    id: idDirDataFilesForSearch
                                    nameField: qsTr("Dir data files:")

                                    Layout.fillWidth: true

                                    CustomTooltip {
                                        id: idTTDirFilesSearch
                                        object: idDirDataFilesForSearch
                                        textLbl: qsTr("Directory with primary phenotypic data.")

                                        visible: {
                                            if (idSHeadSectAddProp.checked) {
                                                if (idCheckBoxUpdataDB.checked) {
                                                    return false
                                                }
                                                return idDirDataFilesForSearch.hovered
                                            }

                                            return false
                                        }
                                        x: 30
                                    }
                                }

                                InputGroupFile {
                                    id: idInputSearchDaug
                                    nameField: qsTr("File bulls:")

                                    Layout.fillWidth: true

                                    CustomTooltip {
                                        id: idTTFileBulls
                                        object: idInputSearchDaug
                                        textLbl: qsTr("File with bull registration numbers.")

                                        visible: {
                                            if (idSHeadSectAddProp.checked) {
                                                if (idCheckBoxUpdataDB.checked) {
                                                    return false
                                                }
                                                return idInputSearchDaug.hovered
                                            }

                                            return false
                                        }
                                        x: 30
                                    }
                                }

                            }

                            background: null
                        }

                    }

                }

                background: null

            }

            // Section Properties
            GroupBox {
                id: idPropertiesSection
                padding: 0

                Layout.topMargin: 10
                Layout.fillWidth: true

                contentItem: ColumnLayout {
                    spacing: comSpacing
                    anchors.fill: parent

                    // Header section
                    HeaderSectionContent {
                        id: idHeadSectProper                        
                        Layout.fillWidth: true
                        Layout.bottomMargin: bottomMarginContentSect

                        nameSection: qsTr("Phenotype settings")
                    }

                    ColumnLayout {
                        spacing: comSpacing
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        enabled: !idSHeadSectAddProp.checked
                        opacity: !idSHeadSectAddProp.checked ? 1 : 0.5

                        InputGroupFolder {
                            id: idDirDataFiles
                            nameField: qsTr("Directory data files:")

                            Layout.fillWidth: true

                            CustomTooltip {
                                id: idTTDirFF
                                object: idDirDataFiles
                                textLbl: qsTr("Directory with primary phenotypic data.")
                                // Директория с первичными фенотипическими данными

                                x: 30
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                Layout.rightMargin: 15

                                text: qsTr("Number lactation: ")
                                font.pixelSize: sizeTextInSect
                                font.family: "Segoe UI"
                                color: txtSection
                            }

                            CustomComboBox {
                                id: idNumLactation
                                currentIndex: 1
                                model: [0, 1, 2, 3]
                            }
                        }

                        CustomCheckbox {
                            id: idControlSelectFtDp

                            contentItem: RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    leftPadding: idControlSelectFtDp.indicator.width + 6

                                    text: qsTr("Select of Feature:")
                                    font.pixelSize: sizeTextInSect
                                    font.family: "Segoe UI"
                                    color: txtSection

                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                }

                                CustomComboBox {
                                    id: idSelectFeatureDp

                                    enabled: idControlSelectFtDp.checked
                                    opacity: idControlSelectFtDp.checked ? 1 : 0.5

                                    currentIndex: 0
                                    displayText: currentText
                                    model: backend.list_feature
                                }

                            }
                        }

                        CustomCheckbox {
                            id: idAccumulateDp
                            nameChb: qsTr("Accumulate data")

                            CustomTooltip {
                                id: idHintAcumDp
                                object: idAccumulateDp
                                textLbl: qsTr("Connection of the accumulation methodology.")

                                x: idAccumulateDp.width
                            }
                        }

                        ColumnLayout {
                            spacing: comSpacing
                            Layout.fillWidth: true

                            CustomCheckbox {
                                id: idCheckBoxPed
                                nameChb: qsTr("Pedigree")

                                CustomTooltip {
                                    id: idHintPed
                                    object: idCheckBoxPed
                                    textLbl: qsTr("Building a file pedigree.")

                                    x: idCheckBoxPed.width
                                }
                            }

                            CustomCheckbox {
                                id: idCheckBoxDaug
                                nameChb: qsTr("Daughters")

                                CustomTooltip {
                                    id: idHintDaug
                                    object: idCheckBoxDaug
                                    textLbl: qsTr("Building a file daughters.")

                                    x: idCheckBoxDaug.width
                                }
                            }

                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCBSelectData
                                nameChb: qsTr("Selection data:")

                                CustomTooltip {
                                    id: idTTSelectData
                                    object: idCBSelectData
                                    textLbl: qsTr("Data pre-filtering.")

                                    x: idCBSelectData.width
                                }
                            }

                            contentData: ColumnLayout {
                                anchors.fill: parent

                                InputGroupFile {
                                    id: idInputFarm
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 30

                                    enabled: idCBSelectData.checked
                                    opacity: idCBSelectData.checked ? 1 : 0.5

                                    nameField: qsTr("File with code farm:")

                                    CustomTooltip {
                                        id: idTTFarmCode
                                        object: idInputFarm
                                        textLbl: qsTr("Selection of data by farm number or code. For example, an active population.")

                                        visible: idCBSelectData.checked ? idInputFarm.hovered : false
                                        x: idTTFarmCode.width / 4
                                    }
                                }

                                InputGroupFile {
                                    id: idInputRemoveDaug
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 30

                                    enabled: idCBSelectData.checked
                                    opacity: idCBSelectData.checked ? 1 : 0.5

                                    nameField: qsTr("Remove daughters:")

                                    CustomTooltip {
                                        id: idTTRemoveDaug
                                        object: idInputFarm
                                        textLbl: qsTr("Excluding daughters of bulls from the data sample, which should not be included in the calculation of ebv.")

                                        visible: idCBSelectData.checked ? idInputRemoveDaug.hovered : false
                                        x: idTTRemoveDaug.width / 3
                                    }
                                }
                            }

                            background: null
                        }

                    }

                }

                background: null
            }
            Item { Layout.fillHeight: true }

        }

        background: Rectangle {
            color: "transparent"
        }
    }
}
