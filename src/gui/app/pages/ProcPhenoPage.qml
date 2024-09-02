import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: "Processing -> phenotype"

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

                        nameSection: "Common"
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
                                text: qsTr("Select of Feature:")
                                font.pixelSize: sizeTextInSect
                                color: txtSection

                                Layout.rightMargin: 30
                            }

                            ComboBox {
                                // currentIndex: 0
                                displayText: "Type: " + currentText
                                model: ['milk', 'conform', 'reprod', 'scs']
                            }
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

                        // Layout.fillHeight: true
                        Layout.fillWidth: true

                        nameSection: "Properties"
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        InputGroup {
                            nameField: "Directory data files:"

                            Layout.fillWidth: true
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxFarm
                                nameChb: "Selection code farm"
                            }

                            contentData: InputGroup {
                                id: idInputFarm
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                nameField: "File with code farm:"
                                enabled: idCheckBoxFarm.checked
                            }

                            background: null
                        }

                        RowLayout {                            
                            Layout.fillWidth: true

                            Text {
                                text: qsTr("Number lactation: ")
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            ComboBox {
                                currentIndex: 1
                                model: [0, 1, 2, 3]
                            }
                        }

                        ColumnLayout {
                            spacing: 0
                            Layout.fillWidth: true                            

                            CustomCheckbox {
                                id: idCheckBoxPed

                                nameChb: "Pedigree"
                            }

                            CustomCheckbox {
                                id: idCheckBoxDaug

                                nameChb: "Daughters"
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

                        nameSection: "Addition properties"
                    }

                    ColumnLayout {                        
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true

                            label: CustomCheckbox {
                                id: idCheckBoxAccumD

                                nameChb: "Accumulate data"
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                Text {
                                    text: qsTr("Update data:")
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                InputGroup {
                                    id: idInputUpdateTo
                                    nameField: "to"

                                    Layout.fillWidth: true
                                }

                                InputGroup {
                                    id: idInputUpdateFrom
                                    nameField: "from"

                                    Layout.fillWidth: true
                                    Layout.leftMargin: 30
                                }

                            }

                            background: null
                        }

                        InputGroup {
                            id: idInputSearchDaug
                            nameField: "Search daughters:"

                            Layout.fillWidth: true
                        }

                        InputGroup {
                            id: idInputRemoveDaug
                            nameField: "Remove daughters:"

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
