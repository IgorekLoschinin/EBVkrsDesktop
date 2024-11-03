import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingSnp

    urlPage: qsTr("Processing -> SNP")

    sendForm: {
        'id': 'procSnp',
        'snp': {
            'checked': idControlSnpProc.checked,
            'refSnpFile': idInputFileSnpRef.inputText.length ? idInputFileSnpRef.inputText : null,
            'sampleFile': idInputSampleD.inputText.length ? idInputSampleD.inputText : null,
            'updateFile': idInputUpdataD.inputText.length ? idInputUpdataD.inputText : null,
        },
        'fr': {
            'checked': idControlFinalReport.checked,
            'dirFileFr': idInputDirFrFiles.inputText.length ? idInputDirFrFiles.inputText : null,
            'callRate': idInputCR.displayText.length ? idInputCR.displayText : null,
            'saveCrFile': {
                'checked': idCheckBoxSaveCrFile.checked,
                'filename': idInputFilenameSave.displayText.length ? idInputFilenameSave.displayText : null,
            },
            'addsuff': {
                'checked': idCBAddSuffSex.checked,
                'add': idCBAddSuff.checked,
                'fromFile': idInputSexFromFile.inputText.length ? idInputSexFromFile.inputText : null,
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
                    HeaderSectionContent {
                        id: idHeadSectProper

                        Layout.fillWidth: true

                        nameSection: qsTr("Snp processing")
                    }

                    CustomCheckbox {
                        id: idControlSnpProc

                        nameChb: qsTr("SNP Control section")
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

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
                    HeaderSectionContent {
                        id: idHeadSectProperFR
                        Layout.fillWidth: true

                        nameSection: qsTr("Final reports")
                    }

                    CustomCheckbox {
                        id: idControlFinalReport

                        nameChb: qsTr("FR Control section")
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

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

            Item { Layout.fillHeight: true }

        }

        background: Rectangle {
            color: "transparent"
        }
    }
}
