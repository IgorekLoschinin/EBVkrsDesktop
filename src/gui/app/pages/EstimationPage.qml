import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: "Estimate breeding value"

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
                                Layout.rightMargin: 15

                                text: qsTr("Select of Feature:")
                                font.pixelSize: sizeTextInSect
                                color: txtSection                                
                            }

                            CustomComboBox {
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

                        nameSection: "Properties"
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.leftMargin: marginContentSect

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                Layout.rightMargin: 15

                                text: qsTr("Variance calculation method:")
                                font.pixelSize: sizeTextInSect
                                color: txtSection
                            }

                            CustomComboBox {
                                id: idSelectTypeCalVar
                                model: ["all", "conf"]
                            }
                        }

                        Label {
                            text: qsTr("Manually set variations for calculations:")
                            Layout.fillWidth: true

                            color: "plum"

                            horizontalAlignment: Qt.AlignHCenter
                        }

                        TableInputVar {
                            id: tableInVariance
                            Layout.fillWidth: true

                            visible: idSelectTypeCalVar.displayText === "conf" ? true : false
                        }

                        Button {
                            text: "Собрать данные"
                            // anchors.bottom: parent.bottom
                            // anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                var allData = {};
                                for (var i = 0; i < tableInVariance.modFtVar.count; i++) {
                                    var item = tableInVariance.modFtVar.get(i);

                                    allData[item.name] = {
                                        "varE": item.varE,
                                        "varG": item.varG
                                    };
                                }

                                // Можем передать собранные данные для дальнейшего использования
                                console.log(allData['tip']['varE'], allData['tip']['varG']);  // Вывод массива всех элементов
                            }
                        }

                        GroupBox {
                            padding: 0
                            Layout.fillWidth: true
                            Layout.bottomMargin: 10

                            label: CustomCheckbox {
                                id: idCheckBoxParallelEst
                                nameChb: "Parallel computing"
                            }

                            contentData: RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 30

                                enabled: idCheckBoxParallelEst.checked
                                opacity: idCheckBoxParallelEst.checked ? 1 : 0.3

                                Label {
                                    Layout.rightMargin: 15

                                    text: qsTr("Number of threads:")
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
