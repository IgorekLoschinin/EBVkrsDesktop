
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: qsTr("Estimate breeding value")
    sendForm: {
        'id': 'ebv',
        'estMethod': {
            'blup': idRadioBtnBlupEbv.checked,
            'gblup': idRadioBtnGBlupEbv.checked
        },
        'feature': idFeatureEbv.displayText,
        'variance': idSelectTypeCalVar.displayText === "conf" ? tableInVariance.getVariance(tableInVariance.modFtVar) : tableInVariance.defVariance,
        'parallel': idCheckBoxParallelEst.checked,
        'numthread': idInputNumThredEst.text.length === 0 ? null : idInputNumThredEst.text,
    }

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            // Section settings ebv
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

                        nameSection: qsTr("Ebv settings")
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
                                id: idRadioBtnBlupEbv
                                text: qsTr("blup")
                                checked: true
                            }

                            CustomRadioBtn {
                                id: idRadioBtnGBlupEbv
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
                                id: idFeatureEbv
                                currentIndex: 0
                                displayText: currentText
                                model: ['milk', 'conform', 'reprod', 'scs']
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

            Item { Layout.fillHeight: true }

        }

        background: Rectangle {
            color: "transparent"
        }
    }
}
