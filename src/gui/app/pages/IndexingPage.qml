import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: qsTr("Indexing")

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
                                font.family: "Segoe UI"
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
                                Layout.rightMargin: 15

                                text: qsTr("Select of Feature:")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection                                
                            }

                            CustomComboBox {
                                id: idSelectFeatureForInd
                                currentIndex: 0
                                displayText: currentText
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
                        Layout.fillWidth: true

                        nameSection: qsTr("Properties")
                    }

                    RowLayout {
                        spacing: 40
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                Layout.rightMargin: 15

                                text: qsTr("Choose animal:")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustomComboBox {
                                currentIndex: 0
                                model: ['sire', 'cow', 'all']
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                Layout.rightMargin: 15

                                text: qsTr("Type index:")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustomComboBox {
                                currentIndex: 0
                                model: ['index', 'complex']
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
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        CustomCheckbox {
                            id: idCheckBoxAccumD

                            nameChb: qsTr("Divide data into bulls and cows.")
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxParallelInd

                                nameChb: qsTr("Parallel computing")
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxParallelInd.checked
                                opacity: idCheckBoxParallelInd.checked ? 1 : 0.3

                                Label {
                                    Layout.rightMargin: 15

                                    text: qsTr("Number of threads:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                CustormTextField {
                                    id: idInputnumThred
                                    phText: qsTr("Enter...")

                                    implicitWidth: 80
                                }
                                Item { Layout.fillWidth: true }
                            }

                            background: null
                        }

                        CustomCheckbox {
                            id: idCheckBoxPrivDisOpt
                            nameChb: qsTr("Disabled optimal value")

                            enabled: idSelectFeatureForInd.displayText === "conform"
                            opacity: idSelectFeatureForInd.displayText === "conform" ? 1 : 0.3
                        }

                        CustomCheckbox {
                            id: idCheckBoxGivc

                            nameChb: qsTr("Generating files for givc")
                        }
                    }

                }

                background: null
            }

            // Section Sample for givc
            GroupBox {
                id: idGivc
                padding: 0

                visible: idCheckBoxGivc.checked

                Layout.topMargin: 10
                Layout.fillWidth: true

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    HeaderSectionContent {
                        id: idHeadSectGivc
                        Layout.fillWidth: true

                        nameSection: qsTr("Sample for givc")
                    }

                    InputGroup {
                        nameField: qsTr("Directory with reports:")
                        placeholderText: qsTr("Enter dir... ")

                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        Text {
                            Layout.rightMargin: 15

                            text: qsTr("Choose animal:")
                            font.family: "Segoe UI"
                            font.pixelSize: sizeTextInSect
                            color: txtSection
                        }

                        CustomComboBox {
                            currentIndex: 0
                            model: ['bull', 'cow', 'full']
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
