import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingPheno

    urlPage: qsTr("Processing -> phenotype")

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

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: comSpacing

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
                                }

                                InputGroupFile {
                                    id: idInputSearchDaug
                                    nameField: qsTr("File bulls:")

                                    Layout.fillWidth: true
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
                                    model: ['milk', 'conform', 'reprod', 'scs']
                                }

                            }
                        }

                        CustomCheckbox {
                            id: idAccumulateDp

                            nameChb: qsTr("Accumulate data")

                            CustomTooltip {
                                object: idAccumulateDp
                                textLbl: qsTr("Connection of the accumulation methodology.")
                            }
                        }

                        ColumnLayout {
                            spacing: comSpacing
                            Layout.fillWidth: true

                            CustomCheckbox {
                                id: idCheckBoxPed

                                nameChb: qsTr("Pedigree")

                                CustomTooltip {
                                    object: idCheckBoxPed
                                    textLbl: qsTr("Building a file pedigree.")
                                }
                            }

                            CustomCheckbox {
                                id: idCheckBoxDaug

                                nameChb: qsTr("Daughters")

                                CustomTooltip {
                                    object: idCheckBoxDaug
                                    textLbl: qsTr("Building a file daughters.")
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

                    }

                }

                background: null
            }
            Rectangle {
                color: 'white'
                height: 1

                Layout.fillWidth: true
                Layout.bottomMargin: bottomMarginContentSect
            }
            Item { Layout.fillHeight: true }

        }

        background: Rectangle {
            color: "transparent"
        }
    }
}
