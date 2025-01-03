import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: qsTr("Indexing")
    sendForm: {
        'id': 'index',
        'estmethod': idComBoxTypeEstMethod.displayText,
        'feature': idSelectFeatureForInd.displayText,
        'animal': idComBoxChooseAnimal.displayText,
        'index': idRadioBtnTypeSubindex.checked,
        'complex_i': idRadioBtnComplexInd.checked,
        'divdata': idCheckBoxDivData.checked,
        'parallel': idCheckBoxParallelInd.checked,
        'numthread': idInputNumThred.text.length === 0 ? null : idInputNumThred.text,
        'disableoptim': idCheckBoxPrivDisOpt.checked,
        'gengivc': {
            'status': idHeadSectGivc.checked,
            'dirreport': idInputDirReports.inputText.length === 0 ? null : idInputDirReports.inputText,
            'typereport': idGivcTypeReport.displayText
        }
    }

    Component {
        id: pBpheno
        ProgressWindow {
            nameProcess: qsTr("Calculation of breeding value indices has started!")
        }
    }

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            Loader {
                sourceComponent: {
                    if (idContent.currentIndex === 5) {
                        return pBpheno
                    }
                    return null
                }
            }

            // Section Common
            GroupBox {
                id: idSettingsIndex
                padding: 0

                Layout.fillWidth: true
                Layout.topMargin: 10

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
                                text: qsTr("Type index: ")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustomRadioBtn {
                                id: idRadioBtnTypeSubindex
                                text: qsTr("subindex")
                                checked: true
                            }

                            CustomRadioBtn {
                                id: idRadioBtnComplexInd
                                text: qsTr("complex")
                            }
                        }

                        RowLayout {
                            spacing: 30
                            Layout.fillWidth: true

                            RowLayout {
                                Layout.fillWidth: true

                                enabled: idRadioBtnTypeSubindex.checked
                                opacity: idRadioBtnTypeSubindex.checked ? 1 : 0.5

                                Text {
                                    Layout.rightMargin: 8

                                    text: qsTr("Select of Feature:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                CustomComboBox {
                                    id: idSelectFeatureForInd
                                    currentIndex: 0
                                    model: backend.list_feature
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    Layout.rightMargin: 8

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
                                    Layout.rightMargin: 8

                                    text: qsTr("Method estimate:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                CustomComboBox {
                                    id: idComBoxTypeEstMethod
                                    currentIndex: 0
                                    model: ['blup', 'gblup']
                                }
                            }

                        }

                        // Additional property
                        ColumnLayout {
                            Layout.fillWidth: true

                            CustomCheckbox {
                                id: idCheckBoxDivData

                                nameChb: qsTr("Divide data.")

                                enabled: idComBoxChooseAnimal.currentIndex === 2 ? true : false
                                opacity: idComBoxChooseAnimal.currentIndex === 2 ? 1 : 0.5

                                CustomTooltip {
                                    id: idHintDivData
                                    object: idCheckBoxDivData
                                    textLbl: qsTr("Dividing these results into fathers and daughters reports.")

                                    visible: idComBoxChooseAnimal.currentIndex === 2 ? idCheckBoxDivData.hovered : false
                                    x: idCheckBoxDivData.width
                                }
                            }

                            GroupBox {
                                padding: 0
                                Layout.fillWidth: true
                                Layout.bottomMargin: 10

                                enabled: idRadioBtnTypeSubindex.checked

                                label: CustomCheckbox {
                                    id: idCheckBoxParallelInd

                                    opacity: idRadioBtnTypeSubindex.checked ? 1 : 0.5

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

                                CustomTooltip {
                                    id: idHintPrivDisOpt
                                    object: idCheckBoxPrivDisOpt
                                    textLbl: qsTr("The function cancels the transformation of data to the optimal value.")

                                    visible: idSelectFeatureForInd.displayText === "conform" ? idCheckBoxPrivDisOpt.hovered : false
                                    x: idCheckBoxPrivDisOpt.width
                                }
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
                    SwitchHeadSectCont {
                        id: idHeadSectGivc

                        Layout.fillWidth: true
                        Layout.bottomMargin: bottomMarginContentSect

                        nameSection: qsTr("Sample for givc")
                    }

                    ColumnLayout {
                        enabled: idHeadSectGivc.checked
                        opacity: idHeadSectGivc.checked ? 1 : 0.5

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
