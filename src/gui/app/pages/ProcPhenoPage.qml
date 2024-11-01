import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingPheno

    urlPage: qsTr("Processing -> phenotype")

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            // Section Common
            GroupBox {
                id: idCommonSection
                padding: 0

                Layout.fillWidth: true
                Layout.topMargin: 20

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    HeaderSectionContent {
                        id: idHeadSectComm

                        Layout.fillWidth: true

                        nameSection: qsTr("Common")
                    }

                    // Content and settings section common
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        RowLayout {
                            spacing: 10
                            Layout.fillWidth: true

                            Text {
                                text: qsTr("Estimation method:")
                                font.pixelSize: sizeTextInSect
                                font.family: "Segoe UI"
                                color: txtSection
                            }

                            CustomRadioBtn {
                                text: qsTr("blup")
                                checked: true
                            }

                            CustomRadioBtn {
                                text: qsTr("gblup")
                            }
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
                                currentIndex: 0
                                displayText: currentText
                                model: ['milk', 'conform', 'reprod', 'scs']
                            }

                        }

                        CustomCheckbox {
                            id: idCheckBoxAccumD

                            nameChb: qsTr("Accumulate data")
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

                        InputGroup {
                            nameField: qsTr("Directory data files:")

                            Layout.fillWidth: true
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxFarm
                                nameChb: qsTr("Selection code farm")
                            }

                            contentData: InputGroup {
                                id: idInputFarm
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxFarm.checked
                                opacity: idCheckBoxFarm.checked ? 1 : 0.3

                                nameField: qsTr("File with code farm:")
                            }

                            background: null
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
                                currentIndex: 1
                                model: [0, 1, 2, 3]
                            }
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

            // Section AddiProperties
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

                        nameSection: qsTr("Addition properties")
                    }

                    ColumnLayout {
                        // spacing: 3
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

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
                                opacity: idCheckBoxUpdataDB.checked ? 1 : 0.3

                                Text {
                                    text: qsTr("Update data:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                InputGroup {
                                    id: idInputUpdateTo
                                    nameField: qsTr("to")

                                    Layout.fillWidth: true
                                }

                                InputGroup {
                                    id: idInputUpdateFrom
                                    nameField: qsTr("from")

                                    Layout.fillWidth: true
                                    Layout.leftMargin: 30
                                }

                            }

                            background: null
                        }

                        InputGroup {
                            id: idInputSearchDaug
                            nameField: qsTr("Search daughters:")

                            Layout.fillWidth: true
                        }

                        InputGroup {
                            id: idInputRemoveDaug
                            nameField: qsTr("Remove daughters:")

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
