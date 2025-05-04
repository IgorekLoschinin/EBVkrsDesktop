import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageIndex

    urlPage: qsTr("Index estimate of breeding value")
    sendForm: {
        'id': 'index',
        'auto': idChBAutoIndexing.checked,
        'estmethod': idComBoxTypeEstMethod.displayText,
        'feature': idChBAutoIndexing.checked ? backend.ind_model.list_feature : idSelectFeatureForInd.displayText,
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

    contentData: ScrollView {
        anchors.fill: parent

        clip: true
        contentWidth: parent.width

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        Control {
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

                    enabled: !idHeadSectGivc.checked
                    opacity: !idHeadSectGivc.checked ? 1 : 0.5

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


                            // Auto index processing feature
                            CustomCheckbox {
                                id: idChBAutoIndexing

                                nameChb: qsTr("Auto")

                                enabled: !idRadioBtnComplexInd.checked
                                opacity: !idRadioBtnComplexInd.checked ? 1 : 0.5
                                hoverEnabled: !idRadioBtnComplexInd.checked

                                CustomTooltip {
                                    id: idHintAutoInd
                                    object: idChBAutoIndexing
                                    textLbl: qsTr("Automatic (Sequential) indexing of features by list.")

                                    x: idChBAutoIndexing.width
                                    visible: {
                                        if (disableTT) {
                                            return idChBAutoIndexing.hovered ? true : false
                                        }

                                        return false
                                    }
                                }
                            }

                            RowLayout {
                                spacing: 10
                                Layout.fillWidth: true

                                enabled: idChBAutoIndexing.checked ? false : true
                                opacity: idChBAutoIndexing.checked ? 0.5 : 1

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

                                    hoverEnabled: !idHeadSectGivc.checked
                                }

                                CustomRadioBtn {
                                    id: idRadioBtnComplexInd
                                    text: qsTr("complex")

                                    hoverEnabled: !idHeadSectGivc.checked
                                }
                            }

                            RowLayout {
                                spacing: 30
                                Layout.fillWidth: true

                                RowLayout {
                                    Layout.fillWidth: true

                                    enabled: !idRadioBtnTypeSubindex.checked || idChBAutoIndexing.checked ? false : true
                                    opacity: !idRadioBtnTypeSubindex.checked || idChBAutoIndexing.checked ? 0.5 : 1

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
                                        model: backend.ind_model.list_feature

                                        hoverEnabled: idHeadSectGivc.checked || idChBAutoIndexing.checked ? false : true
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

                                        hoverEnabled: !idHeadSectGivc.checked
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

                                        hoverEnabled: !idHeadSectGivc.checked
                                    }
                                }

                            }

                            // Additional property
                            ColumnLayout {
                                Layout.fillWidth: true

                                CustomCheckbox {
                                    id: idCheckBoxDivData
                                    nameChb: qsTr("Divide data.")

                                    hoverEnabled: !idHeadSectGivc.checked ? idComBoxChooseAnimal.currentIndex === 2 ? true : false : false
                                    enabled: idComBoxChooseAnimal.currentIndex === 2 ? true : false
                                    opacity: idComBoxChooseAnimal.currentIndex === 2 ? 1 : 0.5

                                    CustomTooltip {
                                        id: idHintDivData
                                        object: idCheckBoxDivData
                                        textLbl: qsTr("Dividing these results into fathers and daughters reports.")

                                        visible: {
                                            if (!idHeadSectGivc.checked) {
                                                if (disableTT) {
                                                    return idComBoxChooseAnimal.currentIndex === 2 ? idCheckBoxDivData.hovered : false
                                                }
                                            }

                                            return false
                                        }

                                        x: idCheckBoxDivData.width
                                    }
                                }

                                GroupBox {
                                    padding: 0
                                    Layout.fillWidth: true
                                    Layout.bottomMargin: 10

                                    enabled: idRadioBtnTypeSubindex.checked
                                    opacity: idRadioBtnTypeSubindex.checked ? 1 : 0.5

                                    label: CustomCheckbox {
                                        id: idCheckBoxParallelInd

                                        opacity: idRadioBtnTypeSubindex.checked ? 1 : 0.5

                                        nameChb: qsTr("Parallel computing")

                                        hoverEnabled: !idHeadSectGivc.checked ? idRadioBtnComplexInd.checked ? false : true : false
                                    }

                                    contentData: RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 30

                                        enabled: idCheckBoxParallelInd.checked
                                        opacity: idCheckBoxParallelInd.checked ? 1 : 0.5

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

                                            hoverEnabled: {
                                                if (!idHeadSectGivc.checked) {
                                                    if (idRadioBtnComplexInd.checked) {
                                                        return !idRadioBtnComplexInd.checked
                                                    }

                                                    return idCheckBoxParallelInd.checked
                                                }

                                                return false
                                            }
                                        }

                                        Item { Layout.fillWidth: true }
                                    }

                                    background: null
                                }

                                CustomCheckbox {
                                    id: idCheckBoxPrivDisOpt
                                    nameChb: qsTr("Disabled optimal value")

                                    hoverEnabled: {
                                        // !idHeadSectGivc.checked ? idSelectFeatureForInd.displayText === "conform" : false
                                        if (idHeadSectGivc.checked || idChBAutoIndexing.checked || !idRadioBtnTypeSubindex.checked) {
                                            return false
                                        }

                                        return idSelectFeatureForInd.displayText === "conform"
                                    }

                                    enabled: {
                                        // idRadioBtnTypeSubindex.checked ? idSelectFeatureForInd.displayText === "conform" : false
                                        if (!idRadioBtnTypeSubindex.checked || idChBAutoIndexing.checked) {
                                            return false
                                        }

                                        return idSelectFeatureForInd.displayText === "conform"
                                    }

                                    opacity: {
                                        // idRadioBtnTypeSubindex.checked ? idSelectFeatureForInd.displayText === "conform" ? 1 : 0.3 : 0.3
                                        if (idChBAutoIndexing.checked) {
                                            return 0.3

                                        } else if (!idRadioBtnTypeSubindex.checked) {
                                            return 0.3

                                        } else if (idSelectFeatureForInd.displayText === "conform") {
                                            return 1
                                        }

                                        return 0.3
                                    }

                                    checked: idChBAutoIndexing.checked ? false : false

                                    CustomTooltip {
                                        id: idHintPrivDisOpt
                                        object: idCheckBoxPrivDisOpt
                                        textLbl: qsTr("The function cancels the transformation of data to the optimal value.")

                                        visible: {
                                            if (!idHeadSectGivc.checked) { // idRadioBtnTypeSubindex.checked
                                                if (disableTT) {
                                                    return idSelectFeatureForInd.displayText === "conform" ? idCheckBoxPrivDisOpt.hovered : false
                                                }
                                            }

                                            return false
                                        }

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

                                hoverTFolderHabler: idHeadSectGivc.checked
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

                                    hoverEnabled: idHeadSectGivc.checked
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
}
