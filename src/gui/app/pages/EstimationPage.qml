import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: qsTr("Estimate breeding value")
    sendForm: {
        'id': 'ebv',
        'estmethod': idEbvTypeEstMethod.displayText,
        'feature': idFeatureEbv.displayText,
        'variance': idSelectTypeCalVar.displayText === "conf" ? tableInVariance.getVariance(tableInVariance.currentModel) : tableInVariance.defVariance,
        'parallel': idCheckBoxParallelEst.checked,
        'numthread': idInputNumThredEst.text.length === 0 ? null : idInputNumThredEst.text,
        'utilsf90': backend.get_settings.utils_f90
    }

    Component {
        id: pBEst
        ProgressWindow {
            nameProcess: qsTr("Calculation of breeding value estimates has started!")
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
                    if (idContent.currentIndex === 4) {
                        return pBEst
                    }
                    return null
                }
            }

            // Section settings ebv
            GroupBox {
                id: idCommonSection
                padding: 0

                Layout.fillWidth: true
                Layout.topMargin: 10

                contentItem: ColumnLayout {
                    anchors.fill: parent

                    // Header section
                    HeaderSectionContent {
                        id: idHeadSectComm
                        Layout.fillWidth: true

                        nameSection: qsTr("Ebv settings")
                    }

                    // Content and settings section common
                    ColumnLayout {
                        spacing: 10
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        RowLayout {
                            spacing: 30
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
                                    id: idFeatureEbv
                                    currentIndex: 0
                                    displayText: currentText
                                    model: backend.list_feature

                                    onCurrentTextChanged: {
                                        if (tableInVariance.modelsFtVar[currentIndex].count > 0) {
                                            tableInVariance.reloadTable(currentIndex)
                                            return
                                        }

                                        tableInVariance.currentModel = tableInVariance.createTable(
                                            tableInVariance.modelsFtVar[currentIndex],
                                            backend.get_fields_table[idFeatureEbv.currentText]
                                        )
                                    }
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
                                    id: idEbvTypeEstMethod
                                    currentIndex: 0
                                    model: ['blup', 'gblup']
                                }
                            }

                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true

                            label: CustomCheckbox {
                                id: idCheckBoxParallelEst

                                nameChb: qsTr("Parallel computing")
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxParallelEst.checked
                                opacity: idCheckBoxParallelEst.checked ? 1 : 0.3

                                Label {
                                    Layout.rightMargin: 15

                                    text: qsTr("Number of threads:")
                                    font.family: "Segoe UI"
                                    font.pixelSize: sizeTextInSect
                                    color: txtSection
                                }

                                CustormTextField {
                                    id: idInputNumThredEst
                                    phText: qsTr("Enter...")

                                    implicitWidth: 80

                                    validator: IntValidator {
                                        bottom: 1
                                        top: 99
                                    }
                                }
                                Item { Layout.fillWidth: true }
                            }

                            background: null
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                Layout.rightMargin: 15

                                text: qsTr("Variance calculation method:")
                                font.family: "Segoe UI"
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustomComboBox {
                                id: idSelectTypeCalVar
                                model: ["all", "conf"]
                            }
                        }

                        // Variance table
                        TableInputVar {
                            id: tableInVariance
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.topMargin: 15

                            visible: idSelectTypeCalVar.displayText === "conf" ? true : false
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
