import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
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
        'variance': getVariance(),
        'parallel': idCheckBoxParallelEst.checked,
        'numthread': idInputNumThredEst.text.length === 0 ? null : idInputNumThredEst.text,
    }

    function getVariance() {
        var allData = {};
        for (var i = 0; i < tableInVariance.modFtVar.count; i++) {
            var item = tableInVariance.modFtVar.get(i);

            allData[item.name] = {
                "varE": item.varE,
                "varG": item.varG
            };
        }

        return allData
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

                        // Variance table
                        ColumnLayout {
                            Layout.fillWidth: true

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

                            RowLayout {
                                spacing: 0
                                visible: idSelectTypeCalVar.displayText === "conf" ? true : false
                                Layout.fillWidth: true

                                TableInputVar {
                                    id: tableInVariance
                                    Layout.fillHeight: true
                                }

                                ColumnLayout {

                                    CustomBtn {
                                        nameBtn: qsTr("load")

                                        implicitWidth: 100

                                        onClicked: idLoadFileConf.open()

                                        FileDialog {
                                            id: idLoadFileConf
                                            currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
                                            onAccepted: console.log(selectedFile)
                                        }
                                    }

                                    CustomBtn {
                                        nameBtn: qsTr("save")

                                        implicitWidth: 100

                                        onClicked: idSaveFileConf.open()

                                        FileDialog {
                                            id: idSaveFileConf
                                            fileMode: FileDialog.SaveFile
                                            currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                                            onAccepted: console.log(selectedFile)
                                        }
                                    }

                                }

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
