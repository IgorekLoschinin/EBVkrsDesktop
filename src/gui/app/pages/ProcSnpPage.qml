import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

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
                                id: idCheckBoxFarm
                                nameChb: "Additional processing"
                            }

                            contentData: ColumnLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                InputGroup {
                                    id: idInputSampleD
                                    Layout.fillWidth: true

                                    nameField: "Sample animals by id:"
                                    enabled: idCheckBoxFarm.checked
                                }

                                InputGroup {
                                    id: idInputUpdataD
                                    Layout.fillWidth: true

                                    nameField: "Update file snp:"
                                    enabled: idCheckBoxFarm.checked
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

                            contentData: InputGroup {
                                id: idInputFarm
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                nameField: "Choose the file with the sex of the animals:"
                                enabled: idCheckBoxFarm.checked
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
