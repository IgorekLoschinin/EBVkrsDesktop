import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing
    anchors.fill: parent

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

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                text: qsTr("Variance calculation method:")
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            ComboBox {
                                model: ["all", "conf"]
                            }
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxFarm
                                nameChb: "Parallel computing"
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                Label {
                                    text: qsTr("Number of threads:")
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                TextField {
                                    id: idTextInput
                                    placeholderText: qsTr("path to dir")
                                    font.pixelSize: sizeTextInSect

                                    implicitHeight: 22
                                }
                                Item { Layout.fillWidth: true }
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
