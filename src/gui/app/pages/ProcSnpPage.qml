import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingSnp

    urlPage: "Processing -> SNP"

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            // Section FinalReports
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

                        nameSection: "Properties"
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        InputGroup {
                            nameField: "Path to file snp:"

                            Layout.fillWidth: true
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxSNPAddProc
                                nameChb: "Additional processing"
                            }

                            contentData: ColumnLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxSNPAddProc.checked
                                opacity: idCheckBoxSNPAddProc.checked ? 1 : 0.3

                                InputGroup {
                                    id: idInputSampleD
                                    Layout.fillWidth: true

                                    nameField: "Sample animals by id:"
                                    enabled: idCheckBoxSNPAddProc.checked
                                }

                                InputGroup {
                                    id: idInputUpdataD
                                    Layout.fillWidth: true

                                    nameField: "Update file snp:"
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

                        nameSection: "Final reports"
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        InputGroup {
                            nameField: "Directory with finalreports files:"

                            Layout.fillWidth: true
                        }

                        RowLayout {
                            Label {
                                Layout.rightMargin: 15

                                text: qsTr("Call rate:")
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustormTextField {
                                id: idInputCR
                                implicitWidth: 80

                                phText: "0.90"
                            }

                            Label {
                                text: qsTr(", %")
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
                                nameChb: "Save call rate in file"
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxSaveCrFile.checked
                                opacity: idCheckBoxSaveCrFile.checked ? 1 : 0.3

                                Label {
                                    Layout.rightMargin: 15

                                    text: qsTr("File name:")
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                CustormTextField {
                                    id: idInputnumThred
                                    phText: qsTr("Name ...")

                                    implicitWidth: 200
                                }

                                Label {
                                    text: qsTr(".xlsx")
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }
                                Item { Layout.fillWidth: true }
                            }

                            background: null
                        }

                        CustomCheckbox {
                            id: idCBSaveFileCr
                            nameChb: "Save animals with low call rate"
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCBAddSuffSex
                                nameChb: "Add suffix sex"
                            }

                            contentData: ColumnLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCBAddSuffSex.checked
                                opacity: idCBAddSuffSex.checked ? 1 : 0.6

                                CustomCheckbox {
                                    id: idCBAddSuff
                                    nameChb: "Add suffix"
                                }

                                InputGroup {
                                    id: idInputFarm
                                    Layout.fillWidth: true

                                    enabled: !idCBAddSuff.checked
                                    opacity: !idCBAddSuff.checked ? 1 : 0.3

                                    nameField: "Choose the file with the sex of the animals:"
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
