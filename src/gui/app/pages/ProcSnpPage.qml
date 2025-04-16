import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessingSnp

    urlPage: qsTr("Processing of genomic data (SNP)")

    sendForm: {
        'id': 'procsnp',
        'snp': {
            'checked': idSectonSnpProc.checked,
            'refsnpfile': idInputFileSnpRef.inputText.length === 0 ? null : idInputFileSnpRef.inputText,
            'sampleanim': {
                'checked': idCheckBoxSNPSampleByid.checked,
                'file': idInputSampleById.inputText.length === 0 ? null : idInputSampleById.inputText,
            },
            'updatesnp': {
                'checked': idCheckBoxSNPUpdateSnp.checked,
                'file': idInputUpdataD.inputText.length === 0 ? null : idInputUpdataD.inputText,
            },
        },
        'fr': {
            'checked': idHeadSectProperFR.checked,
            'dirfilefr': idInputDirFrFiles.inputText.length === 0 ? null : idInputDirFrFiles.inputText,
            'callrate': idInputCR.displayText.length === 0 ? idInputCR.phText.replace(',', '.') : idInputCR.displayText.replace(',', '.'),
            'savecrfile': {
                'checked': idCheckBoxSaveCrFile.checked,
                'filename': idInputFilenameSave.displayText.length === 0 ? null : idInputFilenameSave.displayText + extensionFileCr.text,
            },
            'addsuff': {
                'checked': idCBAddSuffSex.checked,
                'add': idCBAddSuff.checked,
                'fromfile': idInputSexFromFile.inputText.length === 0 ? null : idInputSexFromFile.inputText,
            }
        }
    }

    Component {
        id: pBsnpProc
        ProgressWindow {
            nameProcess: qsTr("SNP data processing has started!")
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
                        if (idContent.currentIndex === 3) {
                            return pBsnpProc
                        }
                        return null
                    }
                }

                // Section Snp processing
                GroupBox {
                    id: idSnpProccSection
                    padding: 0

                    Layout.topMargin: 10
                    Layout.fillWidth: true

                    contentItem: ColumnLayout {
                        anchors.fill: parent

                        // Header section
                        SwitchHeadSectCont {
                            id: idSectonSnpProc

                            Layout.fillWidth: true
                            Layout.bottomMargin: bottomMarginContentSect

                            nameSection: qsTr("Snp processing")
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: marginContentSect

                            enabled: idSectonSnpProc.checked
                            opacity: idSectonSnpProc.checked ? 1 : 0.5

                            InputGroupFile {
                                id: idInputFileSnpRef
                                nameField: qsTr("Path to file snp:")

                                Layout.fillWidth: true

                                hoverTFileHabler: idSectonSnpProc.checked
                            }

                            // Sample animal by id
                            GroupBox {
                                padding: 0
                                Layout.fillWidth: true
                                Layout.bottomMargin: 10

                                label: CustomCheckbox {
                                    id: idCheckBoxSNPSampleByid
                                    hoverEnabled: idSectonSnpProc.checked

                                    onCheckedChanged: {
                                        if (idCheckBoxSNPSampleByid.checked) {
                                            if (idCheckBoxSNPUpdateSnp.checked) {
                                                idCheckBoxSNPUpdateSnp.checked = false
                                            }
                                        }
                                    }

                                    nameChb: qsTr("Sample snp")
                                }

                                contentData: ColumnLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 30

                                    enabled: idCheckBoxSNPSampleByid.checked
                                    opacity: idCheckBoxSNPSampleByid.checked ? 1 : 0.6

                                    InputGroupFile {
                                        id: idInputSampleById
                                        Layout.fillWidth: true

                                        nameField: qsTr("File animal id:")

                                        enabled: idCheckBoxSNPSampleByid.checked
                                        hoverTFileHabler: {
                                            if (idSectonSnpProc.checked) {
                                                if (idCheckBoxSNPSampleByid.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTInputSamById
                                            object: idInputSampleById
                                            textLbl: qsTr("File with animal numbers (ID00001412_MA) to be sampled from snp_ref.")

                                            visible: {
                                                if (idSectonSnpProc.checked) {
                                                    if (disableTT) {
                                                        return idCheckBoxSNPSampleByid.checked ? idInputSampleById.hovered : false
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

                            // Update animal snp
                            GroupBox {
                                padding: 0
                                Layout.fillWidth: true
                                Layout.bottomMargin: 10

                                label: CustomCheckbox {
                                    id: idCheckBoxSNPUpdateSnp
                                    hoverEnabled: idSectonSnpProc.checked

                                    onCheckedChanged: {
                                        if (idCheckBoxSNPUpdateSnp.checked) {
                                            if (idCheckBoxSNPSampleByid.checked) {
                                                idCheckBoxSNPSampleByid.checked = false
                                            }
                                        }
                                    }

                                    nameChb: qsTr("Update snp")
                                }

                                contentData: ColumnLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 30

                                    enabled: idCheckBoxSNPUpdateSnp.checked
                                    opacity: idCheckBoxSNPUpdateSnp.checked ? 1 : 0.6

                                    InputGroupFile {
                                        id: idInputUpdataD
                                        Layout.fillWidth: true

                                        nameField: qsTr("File snp:")

                                        enabled: idCheckBoxSNPUpdateSnp.checked
                                        hoverTFileHabler: {
                                            if (idSectonSnpProc.checked) {
                                                if (idCheckBoxSNPUpdateSnp.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }

                                        CustomTooltip {
                                            id: idTTUpdateSnp
                                            object: idInputUpdataD
                                            textLbl: qsTr("Snp file “ID00(_MA)1 0120502” to update snp_ref.")

                                            visible: {
                                                if (idSectonSnpProc.checked) {
                                                    if (disableTT) {
                                                        return idCheckBoxSNPUpdateSnp.checked ? idInputUpdataD.hovered : false
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

                // Section FinalReports
                GroupBox {
                    id: idPropertiesFR
                    padding: 0

                    Layout.topMargin: 10
                    Layout.fillWidth: true

                    contentItem: ColumnLayout {
                        anchors.fill: parent

                        // Header section
                        SwitchHeadSectCont {
                            id: idHeadSectProperFR

                            Layout.fillWidth: true
                            Layout.bottomMargin: bottomMarginContentSect

                            nameSection: qsTr("Final reports")
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: marginContentSect

                            enabled: idHeadSectProperFR.checked
                            opacity: idHeadSectProperFR.checked ? 1 : 0.5

                            InputGroupFolder {
                                id: idInputDirFrFiles
                                nameField: qsTr("Directory with finalreports files:")

                                Layout.fillWidth: true

                                hoverTFolderHabler: idHeadSectProperFR.checked
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

                                    validator: DoubleValidator {
                                        bottom: 0
                                        notation: DoubleValidator.StandardNotation
                                        top: 1
                                    }

                                    hoverEnabled: idHeadSectProperFR.checked
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
                                    hoverEnabled: idHeadSectProperFR.checked

                                    nameChb: qsTr("Save call rate in file")
                                }

                                contentData: RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 30

                                    enabled: idCheckBoxSaveCrFile.checked
                                    opacity: idCheckBoxSaveCrFile.checked ? 1 : 0.6

                                    Label {
                                        Layout.rightMargin: 15

                                        text: qsTr("File name:")
                                        font.family: "Segoe UI"
                                        font.pixelSize: sizeTextInSect
                                        color: txtSection
                                    }

                                    CustormTextField {
                                        id: idInputFilenameSave
                                        phText: qsTr("Name ...")

                                        implicitWidth: 200

                                        hoverEnabled: {
                                            if (idHeadSectProperFR.checked) {
                                                if (idCheckBoxSaveCrFile.checked) {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }

                                            return false
                                        }
                                    }

                                    Label {
                                        id: extensionFileCr
                                        text: qsTr(".xlsx")
                                        font.family: "Segoe UI"
                                        font.pixelSize: sizeTextInSect
                                        color: txtSection
                                    }
                                    Item { Layout.fillWidth: true }
                                }

                                background: null
                            }

                            GroupBox {
                                padding: 0
                                Layout.fillWidth: true
                                Layout.bottomMargin: 10

                                label: CustomCheckbox {
                                    id: idCBAddSuffSex
                                    hoverEnabled: idHeadSectProperFR.checked

                                    nameChb: qsTr("Add suffix sex")
                                }

                                contentData: ColumnLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 30

                                    enabled: idCBAddSuffSex.checked
                                    opacity: idCBAddSuffSex.checked ? 1 : 0.6

                                    CustomCheckbox {
                                        id: idCBAddSuff
                                        hoverEnabled: idCBAddSuffSex.checked

                                        nameChb: qsTr("Add")

                                        CustomTooltip {
                                            id: idHintAddSuff
                                            object: idCBAddSuff
                                            textLbl: qsTr("Add suffix from the conversion file.")

                                            visible: {
                                                if (disableTT) {
                                                    return idCBAddSuffSex.checked ? idCBAddSuff.hovered : false
                                                }

                                                return false
                                            }

                                            x: idCBAddSuff.width
                                        }
                                    }

                                    InputGroupFile {
                                        id: idInputSexFromFile
                                        Layout.fillWidth: true

                                        enabled: !idCBAddSuff.checked
                                        opacity: !idCBAddSuff.checked ? 1 : 0.6

                                        nameField: qsTr("From the file:")

                                        hoverTFileHabler: {
                                            if (idHeadSectProperFR.checked) {

                                                if (!idCBAddSuff.checked) {
                                                    if (idCBAddSuffSex.checked) {
                                                        return true
                                                    } else {
                                                        return false
                                                    }
                                                }
                                                return false

                                            }
                                            return false
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
        }
    }
}
