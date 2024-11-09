import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: qsTr("Indexing")
    sendForm: {
        'id': 'index',
        'estmethod': {
            'blup': idRadioBtnIndBlup.checked,
            'gblup': idRadioBtnIndGBlup.checked
        },
        'feature': idSelectFeatureForInd.displayText,
        'animal': idComBoxChooseAnimal.displayText,
        'typeind': idComBoxTypeInd.displayText,
        'divdata': idCheckBoxDivData.checked,
        'parallel': idCheckBoxParallelInd.checked,
        'numthread': idInputNumThred.text.length === 0 ? null : idInputNumThred.text,
        'disableoptim': idCheckBoxPrivDisOpt.checked,
        'gengivc': {
            'status': idCheckBoxGivc.checked,
            'dirreport': idInputDirReports.inputText.length === 0 ? null : idInputDirReports.inputText,
            'typereport': idGivcTypeReport.displayText
        }
    }

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            // Section Common
            GroupBox {
                id: idSettingsIndex
                padding: 0

                Layout.fillWidth: true
                Layout.topMargin: 20

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    HeaderSectionContent {
                        id: idHeadSectComm

                        Layout.fillWidth: true

                        nameSection: qsTr("Settings index")
                    }

                    // Content and settings section common
                    ColumnLayout {
                        spacing: 10
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
                                id: idRadioBtnIndBlup
                                text: qsTr("blup")
                                checked: true
                            }

                            CustomRadioBtn {
                                id: idRadioBtnIndGBlup
                                text: qsTr("gblup")
                            }
                        }

                        RowLayout {
                            spacing: 40
                            Layout.fillWidth: true

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
                                    model: ['milk', 'conform', 'reprod', 'scs']
                                }
                            }

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
                                    id: idComBoxChooseAnimal
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
                                    id: idComBoxTypeInd
                                    currentIndex: 0
                                    model: ['index', 'complex']
                                }
                            }

                        }

                        // Additional property
                        ColumnLayout {
                            Layout.fillWidth: true

                            CustomCheckbox {
                                id: idCheckBoxDivData

                                nameChb: qsTr("Divide data into bulls and cows.")

                                enabled: idComBoxChooseAnimal.currentIndex === 2 ? true : false
                                opacity: idComBoxChooseAnimal.currentIndex === 2 ? 1 : 0.5
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
                                        id: idInputNumThred
                                        phText: qsTr("Enter...")

                                        implicitWidth: 80

                                        validator: IntValidator {
                                            bottom: 1
                                            top: 100
                                        }
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

                        }

                    }
                }

                background: null
            }

            // Section Sample for givc
            GroupBox {
                id: idGivc
                padding: 0

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

                    CustomCheckbox {
                        id: idCheckBoxGivc

                        nameChb: qsTr("Generating files for givc")
                    }

                    ColumnLayout {
                        enabled: idCheckBoxGivc.checked
                        opacity: idCheckBoxGivc.checked ? 1 : 0.5

                        InputGroupFolder {
                            id: idInputDirReports
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

                                text: qsTr("Type reports:")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustomComboBox {
                                id: idGivcTypeReport
                                currentIndex: 0
                                model: ['bull', 'cow', 'full']
                            }
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
