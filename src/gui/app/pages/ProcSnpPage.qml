import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingSnp

    urlPage: qsTr("Processing -> SNP")

    sendForm: {
        'id': 'procsnp',
        'snp': {
            'checked': idSectonSnpProc.checked,
            'refsnpfile': idInputFileSnpRef.inputText.length === 0 ? null : idInputFileSnpRef.inputText,
            'samplefile': idInputSampleD.inputText.length === 0 ? null : idInputSampleD.inputText,
            'updatefile': idInputUpdataD.inputText.length === 0 ? null : idInputUpdataD.inputText,
        },
        'fr': {
            'checked': idHeadSectProperFR.checked,
            'dirfilefr': idInputDirFrFiles.inputText.length === 0 ? null : idInputDirFrFiles.inputText,
            'callrate': idInputCR.displayText.length === 0 ? null : idInputCR.displayText,
            'savecrfile': {
                'checked': idCheckBoxSaveCrFile.checked,
                'filename': idInputFilenameSave.displayText.length === 0 ? null : idInputFilenameSave.displayText,
            },
            'addsuff': {
                'checked': idCBAddSuffSex.checked,
                'add': idCBAddSuff.checked,
                'fromfile': idInputSexFromFile.inputText.length === 0 ? null : idInputSexFromFile.inputText,
            }
        }
    }

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            // Section Snp processing
            GroupBox {
                id: idSnpProccSection
                padding: 0

                Layout.topMargin: 10
                Layout.fillWidth: true

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    SwitchHeadSectCont {
                        id: idSectonSnpProc

                        Layout.fillWidth: true
                        Layout.bottomMargin: bottomMarginContentSect

                        nameSection: qsTr("Snp processing")
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        enabled: idSectonSnpProc.checked
                        opacity: idSectonSnpProc.checked ? 1 : 0.5

                        InputGroupFile {
                            id: idInputFileSnpRef
                            nameField: qsTr("Path to file snp:")

                            Layout.fillWidth: true
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxSNPAddProc

                                nameChb: qsTr("Additional processing")
                            }

                            contentData: ColumnLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxSNPAddProc.checked
                                opacity: idCheckBoxSNPAddProc.checked ? 1 : 0.3

                                InputGroupFile {
                                    id: idInputSampleD
                                    Layout.fillWidth: true

                                    nameField: qsTr("Sample animals by id:")
                                    enabled: idCheckBoxSNPAddProc.checked
                                }

                                InputGroupFile {
                                    id: idInputUpdataD
                                    Layout.fillWidth: true

                                    nameField: qsTr("Update file snp:")
                                    enabled: idCheckBoxSNPAddProc.checked
                                }
                            }

                            background: null
                        }

                    }

                }

                background: null
            }

            // Section FinalReports
            GroupBox {
                id: idPropertiesFR
                padding: 0

                Layout.topMargin: 10
                Layout.fillWidth: true

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    SwitchHeadSectCont {
                        id: idHeadSectProperFR

                        Layout.fillWidth: true
                        Layout.bottomMargin: bottomMarginContentSect

                        nameSection: qsTr("Final reports")
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        enabled: idHeadSectProperFR.checked
                        opacity: idHeadSectProperFR.checked ? 1 : 0.5

                        InputGroupFolder {
                            id: idInputDirFrFiles
                            nameField: qsTr("Directory with finalreports files:")

                            Layout.fillWidth: true
                        }

                        RowLayout {
                            Label {
                                Layout.rightMargin: 15

                                text: qsTr("Call rate:")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustormTextField {
                                id: idInputCR
                                implicitWidth: 80

                                phText: qsTr("0.90")

                                validator: DoubleValidator {
                                    bottom: 0
                                    top: 1
                                }
                            }

                            Label {
                                text: qsTr(", %")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxSaveCrFile

                                nameChb: qsTr("Save call rate in file")
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxSaveCrFile.checked
                                opacity: idCheckBoxSaveCrFile.checked ? 1 : 0.3

                                Label {
                                    Layout.rightMargin: 15

                                    text: qsTr("File name:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                CustormTextField {
                                    id: idInputFilenameSave
                                    phText: qsTr("Name ...")

                                    implicitWidth: 200
                                }

                                Label {
                                    text: qsTr(".xlsx")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }
                                Item { Layout.fillWidth: true }
                            }

                            background: null
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCBAddSuffSex

                                nameChb: qsTr("Add suffix sex")
                            }

                            contentData: ColumnLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCBAddSuffSex.checked
                                opacity: idCBAddSuffSex.checked ? 1 : 0.6

                                CustomCheckbox {
                                    id: idCBAddSuff

                                    nameChb: qsTr("Add suffix")

                                    CustomTooltip {
                                        object: idCBAddSuff
                                        textLbl: qsTr("Adding suffixes from the animal number file.")

                                        visible: idCBAddSuffSex.checked ? idCBAddSuff.hovered : false
                                    }
                                }

                                InputGroupFile {
                                    id: idInputSexFromFile
                                    Layout.fillWidth: true

                                    enabled: !idCBAddSuff.checked
                                    opacity: !idCBAddSuff.checked ? 1 : 0.3

                                    nameField: qsTr("Choose the file with the sex of the animals:")
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
