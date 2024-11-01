import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingPheno

    urlPage: qsTr("Processing -> phenotype")

    sendForm: {
        'id': 'procPheno',
        'preparation': {
            'checked': idPreparationDp.checked,
            'updatabd': {
                'checked': idCheckBoxUpdataDB.checked,
                'pathTo': idInputUpdateTo.inputText.length ? idInputUpdateTo.inputText : null,
                'pathFrom': idInputUpdateFrom.inputText.length ? idInputUpdateFrom.inputText : null,
            },
            'searchDaug': idInputSearchDaug.inputText.length ? idInputSearchDaug.inputText : null,
        },
        'phendata': idDirDataFiles.inputText.length ? idDirDataFiles.inputText : null,
        'feature': idSelectFeatureDp.displayText,
        'accummeth': idAccumulateDp.checked,
        'numlact': idNumLactation.currentIndex,
        'ped': idCheckBoxPed.checked,
        'daughters': idCheckBoxDaug.checked,
        'selectdata': {
            'checked': idCBSelectData.checked,
            'filefarm': idInputFarm.inputText.length ? idInputFarm.inputText : null,
            'removedaug': idInputRemoveDaug.inputText.length ? idInputRemoveDaug.inputText : null,
        }
    }

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            // Section Properties
            GroupBox {
                id: idPropertiesSection
                padding: 0

                Layout.topMargin: 10
                Layout.fillWidth: true

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    HeaderSectionContent {
                        id: idHeadSectProper                        
                        Layout.fillWidth: true

                        nameSection: qsTr("Properties")
                    }

                    CustomCheckbox {
                        id: idPreparationDp
                        Layout.leftMargin: marginContentSect

                        nameChb: qsTr("Preparation data")

                        onCheckStateChanged: idPageProcessingPheno.sendForm['preparation']['checked'] = checked
                    }

                    ColumnLayout {
                        spacing: 5
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        enabled: !idPreparationDp.checked
                        opacity: !idPreparationDp.checked ? 1 : 0.5

                        InputGroupFolder {
                            id: idDirDataFiles
                            nameField: qsTr("Directory data files:")

                            Layout.fillWidth: true
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                Layout.rightMargin: 15

                                text: qsTr("Select of Feature:")
                                font.pixelSize: sizeTextInSect
                                font.family: "Segoe UI"
                                color: txtSection
                            }

                            CustomComboBox {
                                id: idSelectFeatureDp
                                currentIndex: 0
                                displayText: currentText
                                model: ['milk', 'conform', 'reprod', 'scs']
                            }

                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                Layout.rightMargin: 15

                                text: qsTr("Number lactation: ")
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustomComboBox {
                                id: idNumLactation
                                currentIndex: 1
                                model: [0, 1, 2, 3]
                            }
                        }

                        CustomCheckbox {
                            id: idAccumulateDp

                            nameChb: qsTr("Accumulate data")
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCBSelectData
                                nameChb: qsTr("Selection data:")

                                onCheckStateChanged: {
                                    idPageProcessingPheno.sendForm['selectdata']['checked'] = checked
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
                                }

                                InputGroupFile {
                                    id: idInputRemoveDaug
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 30

                                    enabled: idCBSelectData.checked
                                    opacity: idCBSelectData.checked ? 1 : 0.5

                                    nameField: qsTr("Remove daughters:")
                                }
                            }

                            background: null
                        }

                        ColumnLayout {
                            spacing: 0
                            Layout.fillWidth: true                            

                            CustomCheckbox {
                                id: idCheckBoxPed

                                nameChb: qsTr("Pedigree")
                            }

                            CustomCheckbox {
                                id: idCheckBoxDaug

                                nameChb: qsTr("Daughters")
                            }

                        }

                    }

                }

                background: null
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
                    HeaderSectionContent {
                        id: idHeadSectAddProp

                        Layout.fillWidth: true

                        nameSection: qsTr("Preparation data")
                    }

                    ColumnLayout {
                        // spacing: 3
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        enabled: idPreparationDp.checked
                        opacity: idPreparationDp.checked ? 1 : 0.5

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true

                            label: CustomCheckbox {
                                id: idCheckBoxUpdataDB

                                nameChb: qsTr("Updata data base")

                                onCheckStateChanged: {
                                    idPageProcessingPheno.sendForm['preparation']['updatabd']['checked'] = checked
                                }
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

                        InputGroupFile {
                            id: idInputSearchDaug
                            nameField: qsTr("Search daughters:")

                            enabled: !idCheckBoxUpdataDB.checked
                            opacity: !idCheckBoxUpdataDB.checked ? 1 : 0.5

                            Layout.fillWidth: true
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
