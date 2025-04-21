import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingPheno
    urlPage: qsTr("Processing of phenotypic data")

    sendForm: {
        'id': 'procpheno',
        'preparation': {
            'checked': idSHeadSectAddProp.checked,
            'updatabd': {
                'checked': idCheckBoxUpdataDB.checked,
                'pathto': idInputUpdateTo.inputText.length === 0 ? null : idInputUpdateTo.inputText,
                'pathfrom': idInputUpdateFrom.inputText.length === 0 ? null : idInputUpdateFrom.inputText,
            },
            'searchdaug': {
                'datafiles': idDirDataFilesForSearch.inputText.length === 0 ? null : idDirDataFilesForSearch.inputText,
                'filesires': idInputSearchDaug.inputText.length === 0 ? null : idInputSearchDaug.inputText,
            }
        },
        'phendata': idDirDataFiles.inputText.length === 0 ? null : idDirDataFiles.inputText,
        'feature': !idControlSelectFtDp.checked ? null : idSelectFeatureDp.displayText,
        'accummeth': idAccumulateDp.checked,
        'numlact': idNumLactation.currentIndex,
        'ped': idCheckBoxPed.checked,
        'daughters': idCheckBoxDaug.checked,
        'addfilesnp': !idAdditionSnpData.checked ? null : idInputPathSnpFile.inputText.length === 0 ? null : idInputPathSnpFile.inputText,
        'selectdata': {
            'checked': idCBSelectData.checked,
            'filefarm': idInputFarm.inputText.length === 0 ? null : idInputFarm.inputText,
            'removedaug': idInputRemoveDaug.inputText.length === 0 ? null : idInputRemoveDaug.inputText,
        }
    }

    Component {
        id: pBpheno
        ProgressWindow {
            nameProcess: qsTr("Data processing has started!")
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
                spacing: comSpacing
                anchors.fill: parent

                Loader {
                    sourceComponent: {
                        if (idContent.currentIndex === 2) {
                            return pBpheno
                        }
                        return null
                    }
                }

                // Section preparation data
                GroupBox {
                    id: idAdditPropSection
                    padding: 0

                    Layout.topMargin: 10
                    Layout.fillWidth: true

                    contentItem: ColumnLayout {
                        anchors.fill: parent

                        // Header section
                        SwitchHeadSectCont {
                            id: idSHeadSectAddProp

                            Layout.fillWidth: true
                            Layout.bottomMargin: bottomMarginContentSect

                            nameSection: qsTr("Preparation data")
                        }

                        ColumnLayout {
                            spacing: comSpacing
                            Layout.fillWidth: true
                            Layout.leftMargin: marginContentSect

                            enabled: idSHeadSectAddProp.checked
                            opacity: idSHeadSectAddProp.checked ? 1 : 0.5

                            GroupBox {
                                padding: 0
                                Layout.fillWidth: true

                                label: CustomCheckbox {
                                    id: idCheckBoxUpdataDB
                                    hoverEnabled: idSHeadSectAddProp.checked

                                    nameChb: qsTr("Updata data base")
                                }

                                contentData: RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 30

                                    enabled: idCheckBoxUpdataDB.checked
                                    opacity: idCheckBoxUpdataDB.checked ? 1 : 0.5

                                    Text {
                                        text: qsTr("Update data:")
                                        font.family: "Segoe UI"
                                        font.pixelSize: sizeTextInSect
                                        color: txtSection
                                    }

                                    InputGroupFolder {
                                        id: idInputUpdateTo
                                        nameField: qsTr("to")

                                        Layout.fillWidth: true

                                        hoverTFolderHabler: {
                                            if (idSHeadSectAddProp.checked) {
                                                if (idCheckBoxUpdataDB.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTUpdateToDB
                                            object: idInputUpdateTo
                                            textLbl: qsTr("Directory with new files that will be updated.")

                                            visible: {
                                                if (idSHeadSectAddProp.checked) {
                                                    if (disableTT) {
                                                        return idCheckBoxUpdataDB.checked ? idInputUpdateTo.hovered : false
                                                    }
                                                }

                                                return false
                                            }

                                            x: 30
                                        }
                                    }

                                    InputGroupFolder {
                                        id: idInputUpdateFrom
                                        nameField: qsTr("from")

                                        Layout.fillWidth: true
                                        Layout.leftMargin: 30

                                        hoverTFolderHabler: {
                                            if (idSHeadSectAddProp.checked) {
                                                if (idCheckBoxUpdataDB.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTUpdateFromDB
                                            object: idInputUpdateFrom
                                            textLbl: qsTr("Directory with old data - last used for estimation.")

                                            visible: {
                                                if (idSHeadSectAddProp.checked) {
                                                    if (disableTT) {
                                                        return idCheckBoxUpdataDB.checked ? idInputUpdateFrom.hovered : false
                                                    }
                                                }

                                                return false
                                            }

                                            x: 30
                                        }
                                    }

                                }

                                background: null
                            }

                            GroupBox {
                                id: idLblSearchDaug
                                padding: 0
                                Layout.fillWidth: true

                                enabled: !idCheckBoxUpdataDB.checked
                                opacity: !idCheckBoxUpdataDB.checked ? 1 : 0.5

                                label: Label {
                                    text: qsTr("Search daughters:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                contentData: ColumnLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 30

                                    InputGroupFolder {
                                        id: idDirDataFilesForSearch
                                        nameField: qsTr("Dir data files:")

                                        Layout.fillWidth: true

                                        hoverTFolderHabler: {
                                            if (idSHeadSectAddProp.checked) {
                                                if (idCheckBoxUpdataDB.checked) {
                                                    return false
                                                }
                                                return true
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTDirFilesSearch
                                            object: idDirDataFilesForSearch
                                            textLbl: qsTr("Directory with primary phenotypic data.")

                                            visible: {
                                                if (disableTT) {

                                                    if (idSHeadSectAddProp.checked) {
                                                        if (idCheckBoxUpdataDB.checked) {
                                                            return false
                                                        }
                                                        return idDirDataFilesForSearch.hovered
                                                    }

                                                }

                                                return false
                                            }
                                            x: 30
                                        }
                                    }

                                    InputGroupFile {
                                        id: idInputSearchDaug
                                        nameField: qsTr("File bulls:")

                                        Layout.fillWidth: true

                                        hoverTFileHabler: {
                                            if (idSHeadSectAddProp.checked) {
                                                if (idCheckBoxUpdataDB.checked) {
                                                    return false
                                                }
                                                return true
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTFileBulls
                                            object: idInputSearchDaug
                                            textLbl: qsTr("File with bull registration numbers.")

                                            visible: {
                                                if (disableTT) {
                                                    if (idSHeadSectAddProp.checked) {
                                                        if (idCheckBoxUpdataDB.checked) {
                                                            return false
                                                        }
                                                        return idInputSearchDaug.hovered
                                                    }
                                                }

                                                return false
                                            }
                                            x: 30
                                        }
                                    }

                                }

                                background: null
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
                        spacing: comSpacing
                        anchors.fill: parent

                        // Header section
                        HeaderSectionContent {
                            id: idHeadSectProper
                            Layout.fillWidth: true
                            Layout.bottomMargin: bottomMarginContentSect

                            nameSection: qsTr("Phenotype settings")
                        }

                        ColumnLayout {
                            spacing: comSpacing
                            Layout.fillWidth: true
                            Layout.leftMargin: marginContentSect

                            enabled: !idSHeadSectAddProp.checked
                            opacity: !idSHeadSectAddProp.checked ? 1 : 0.5

                            InputGroupFolder {
                                id: idDirDataFiles
                                nameField: qsTr("Directory data files:")

                                Layout.fillWidth: true

                                hoverTFolderHabler: !idSHeadSectAddProp.checked

                                CustomTooltip {
                                    id: idTTDirFF
                                    object: idDirDataFiles
                                    textLbl: qsTr("Directory with primary phenotypic data.")

                                    x: 30
                                    visible: {
                                        if (disableTT) {
                                            return !idSHeadSectAddProp.checked ? idDirDataFiles.hovered : false
                                        }

                                        return false
                                    }
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    Layout.rightMargin: 15

                                    text: qsTr("Number lactation: ")
                                    font.pixelSize: sizeTextInSect
                                    font.family: "Segoe UI"
                                    color: txtSection
                                }

                                CustomComboBox {
                                    id: idNumLactation
                                    currentIndex: 1
                                    model: [0, 1, 2, 3]

                                    hoverEnabled: !idSHeadSectAddProp.checked
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                // Selection feature panel
                                CustomCheckbox {
                                    id: idControlSelectFtDp

                                    hoverEnabled: {
                                        if (!idSHeadSectAddProp.checked) {
                                            if (!idChBAutoProcFt) {
                                                return idChBAutoProcFt.checked
                                            }

                                            return !idChBAutoProcFt.checked
                                        }

                                        return !idSHeadSectAddProp.checked
                                    }

                                    enabled: !idChBAutoProcFt.checked
                                    opacity: !idChBAutoProcFt.checked ? 1 : 0.7
                                    checked: !idChBAutoProcFt.checked ? idChBAutoProcFt.checked : false

                                    contentItem: RowLayout {
                                        Layout.fillWidth: true

                                        Text {
                                            leftPadding: idControlSelectFtDp.indicator.width + 6

                                            text: qsTr("Select of Feature:")
                                            font.pixelSize: sizeTextInSect
                                            font.family: "Segoe UI"
                                            color: txtSection

                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                        }

                                        CustomComboBox {
                                            id: idSelectFeatureDp

                                            hoverEnabled: idControlSelectFtDp.checked ? !idChBAutoProcFt.checked : false
                                            enabled: idControlSelectFtDp.checked
                                            opacity: idControlSelectFtDp.checked ? 1 : 0.5

                                            currentIndex: 0
                                            displayText: currentText
                                            model: backend.phen_model.list_feature
                                        }

                                    }
                                }

                                // Autoproc feature selecton
                                CustomCheckbox {
                                    id: idChBAutoProcFt
                                    Layout.leftMargin: 15

                                    nameChb: qsTr("Auto")

                                    hoverEnabled: !idSHeadSectAddProp.checked

                                    CustomTooltip {
                                        id: idHintAutoProc
                                        object: idChBAutoProcFt
                                        textLbl: qsTr("Automatic (Sequential) processing of features by list.")

                                        x: idChBAutoProcFt.width
                                        visible: {
                                            if (disableTT) {
                                                return !idSHeadSectAddProp.checked ? idChBAutoProcFt.hovered : false
                                            }

                                            return false
                                        }
                                    }
                                }

                            }

                            // // Selection feature panel
                            // CustomCheckbox {
                            //     id: idControlSelectFtDp

                            //     hoverEnabled: !idSHeadSectAddProp.checked

                            //     contentItem: RowLayout {
                            //         Layout.fillWidth: true

                            //         Text {
                            //             leftPadding: idControlSelectFtDp.indicator.width + 6

                            //             text: qsTr("Select of Feature:")
                            //             font.pixelSize: sizeTextInSect
                            //             font.family: "Segoe UI"
                            //             color: txtSection

                            //             verticalAlignment: Text.AlignVCenter
                            //             horizontalAlignment: Text.AlignHCenter
                            //         }

                            //         CustomComboBox {
                            //             id: idSelectFeatureDp

                            //             hoverEnabled: idControlSelectFtDp.checked
                            //             enabled: idControlSelectFtDp.checked
                            //             opacity: idControlSelectFtDp.checked ? 1 : 0.5

                            //             currentIndex: 0
                            //             displayText: currentText
                            //             model: backend.phen_model.list_feature
                            //         }

                            //     }
                            // }

                            CustomCheckbox {
                                id: idAccumulateDp
                                nameChb: qsTr("Accumulate data")

                                hoverEnabled: !idSHeadSectAddProp.checked

                                CustomTooltip {
                                    id: idHintAcumDp
                                    object: idAccumulateDp
                                    textLbl: qsTr("Connection of the accumulation methodology.")

                                    x: idAccumulateDp.width
                                    visible: {
                                        if (disableTT) {
                                            return !idSHeadSectAddProp.checked ? idAccumulateDp.hovered : false
                                        }

                                        return false
                                    }
                                }
                            }

                            ColumnLayout {
                                spacing: comSpacing
                                Layout.fillWidth: true

                                CustomCheckbox {
                                    id: idCheckBoxPed
                                    nameChb: qsTr("Pedigree")

                                    hoverEnabled: !idSHeadSectAddProp.checked

                                    CustomTooltip {
                                        id: idHintPed
                                        object: idCheckBoxPed
                                        textLbl: qsTr("Building a file pedigree.")

                                        x: idCheckBoxPed.width
                                        visible: {
                                            if (disableTT) {
                                                return !idSHeadSectAddProp.checked ? idCheckBoxPed.hovered : false
                                            }

                                            return false
                                        }
                                    }
                                }

                                CustomCheckbox {
                                    id: idCheckBoxDaug
                                    nameChb: qsTr("Daughters")

                                    hoverEnabled: !idSHeadSectAddProp.checked

                                    CustomTooltip {
                                        id: idHintDaug
                                        object: idCheckBoxDaug
                                        textLbl: qsTr("Building a file daughters.")

                                        x: idCheckBoxDaug.width
                                        visible: {
                                            if (disableTT) {
                                                return !idSHeadSectAddProp.checked ? idCheckBoxDaug.hovered : false
                                            }
                                            return false
                                        }
                                    }
                                }

                            }

                            // Addition snp file
                            GroupBox {
                                padding: 0
                                Layout.fillWidth: true
                                Layout.bottomMargin: 10

                                label: CustomCheckbox {
                                    id: idAdditionSnpData
                                    nameChb: qsTr("Add snp file")

                                    hoverEnabled: !idSHeadSectAddProp.checked

                                    CustomTooltip {
                                        id: idTTAddSnpData
                                        object: idAdditionSnpData
                                        textLbl: qsTr("Adding a snp file to the input files when calculating gblup.")

                                        x: idAdditionSnpData.width
                                        visible: {
                                            if (disableTT) {
                                                return !idSHeadSectAddProp.checked ? idAdditionSnpData.hovered : false
                                            }
                                            return false
                                        }
                                    }
                                }

                                contentData: ColumnLayout {
                                    anchors.fill: parent

                                    InputGroupFile {
                                        id: idInputPathSnpFile
                                        nameField: qsTr("File snp:")

                                        Layout.fillWidth: true
                                        Layout.leftMargin: 30

                                        enabled: idAdditionSnpData.checked
                                        opacity: idAdditionSnpData.checked ? 1 : 0.5

                                        hoverTFileHabler: {
                                            if (!idSHeadSectAddProp.checked) {
                                                if (idAdditionSnpData.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }
                                    }
                                }

                                background: null
                            }

                            // Selection data
                            GroupBox {
                                padding: 0
                                Layout.fillWidth: true
                                Layout.bottomMargin: 10

                                label: CustomCheckbox {
                                    id: idCBSelectData
                                    nameChb: qsTr("Selection data:")

                                    hoverEnabled: !idSHeadSectAddProp.checked

                                    CustomTooltip {
                                        id: idTTSelectData
                                        object: idCBSelectData
                                        textLbl: qsTr("Data pre-filtering.")

                                        x: idCBSelectData.width
                                        visible: {
                                            if (disableTT) {
                                                return !idSHeadSectAddProp.checked ? idCBSelectData.hovered : false
                                            }
                                            return false
                                        }
                                    }
                                }

                                contentData: ColumnLayout {
                                    anchors.fill: parent

                                    InputGroupFile {
                                        id: idInputFarm
                                        nameField: qsTr("File with code farm:")

                                        Layout.fillWidth: true
                                        Layout.leftMargin: 30

                                        enabled: idCBSelectData.checked
                                        opacity: idCBSelectData.checked ? 1 : 0.5

                                        hoverTFileHabler: {
                                            if (!idSHeadSectAddProp.checked) {
                                                if (idCBSelectData.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTFarmCode
                                            object: idInputFarm
                                            textLbl: qsTr("Selection of data by farm number or code. For example, an active population.")

                                            x: idTTFarmCode.width / 4
                                            visible: {
                                                if (disableTT) {

                                                    if (!idSHeadSectAddProp.checked) {
                                                        if (idCBSelectData.checked) {
                                                            return idInputFarm.hovered
                                                        } else {
                                                            return false
                                                        }
                                                    }

                                                }
                                                return false
                                            }
                                        }
                                    }

                                    InputGroupFile {
                                        id: idInputRemoveDaug
                                        nameField: qsTr("Remove daughters:")

                                        Layout.fillWidth: true
                                        Layout.leftMargin: 30

                                        enabled: idCBSelectData.checked
                                        opacity: idCBSelectData.checked ? 1 : 0.5

                                        hoverTFileHabler: {
                                            if (!idSHeadSectAddProp.checked) {
                                                if (idCBSelectData.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTRemoveDaug
                                            object: idInputFarm
                                            textLbl: qsTr("Excluding daughters of bulls from the data sample, which should not be included in the calculation of ebv.")

                                            x: idTTRemoveDaug.width / 3
                                            visible: {
                                                if (disableTT) {
                                                    if (!idSHeadSectAddProp.checked) {
                                                        if (idCBSelectData.checked) {
                                                            return idInputRemoveDaug.hovered
                                                        } else {
                                                            return false
                                                        }
                                                    }
                                                }
                                                return false
                                            }
                                        }
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
        } // End contentData control
    }
}
