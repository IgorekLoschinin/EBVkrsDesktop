import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingSnp

    urlPage: qsTr("Processing -> SNP")

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

                        nameSection: qsTr("Properties")
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        InputGroupFile {
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

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        InputGroupFolder {
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
                                    id: idInputnumThred
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

                        CustomCheckbox {
                            id: idCBSaveFileCr

                            nameChb: qsTr("Save call rate in file")
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
                                    id: idInputFarm
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
