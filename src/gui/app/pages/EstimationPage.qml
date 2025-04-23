import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "controls"
import "../components"


TemplatePage {
    id: idPageEstimation

    urlPage: qsTr("Estimate breeding value")
    sendForm: {
        'id': 'ebv',
        'auto': idChBAutoEstFt.checked,
        'estmethod': idEbvTypeEstMethod.displayText,
        'feature': idChBAutoEstFt.checked ? backend.ebv_model.list_feature : idFeatureEbv.displayText,
        'variance': estimationFunc.handleVar(),     //idSelectTypeCalVar.displayText === "conf" ? tableInVariance.getVariance(tableInVariance.currentModel) : tableInVariance.defVariance,
        'parallel': idCheckBoxParallelEst.checked,
        'numthread': idInputNumThredEst.text.length === 0 ? null : idInputNumThredEst.text,
        'utilsf90': backend.settings_model.settings.utils_f90
    }

    QtObject {
        id: estimationFunc

        function handleVar() {
            if (!idChBAutoEstFt.checked) {
                if (idSelectTypeCalVar.displayText === "conf") {
                    return tableInVariance.getVariance(tableInVariance.currentModel)
                }

                return tableInVariance.defVariance

            } else {

                var list_obj_var = {}
                var lstFt = backend.ebv_model.list_feature

                if (idSelectTypeCalVar.displayText === "conf") {
                    for (var i = 0; i < lstFt.length; i++) {
                        list_obj_var[lstFt[i]] = tableInVariance.getVariance(tableInVariance.modelsFtVar[i])
                    }

                    return list_obj_var
                }

                for (var j = 0; j < lstFt.length; j++) {
                    list_obj_var[lstFt[j]] = tableInVariance.getVariance(
                        tableInVariance.initTable(
                            tableInVariance.modelsFtVar[j],
                            backend.ebv_model.get_fields_table[lstFt[j]]
                        )
                    )
                }

                return list_obj_var


                // tableInVariance.currentModel = tableInVariance.initTable(
                //     tableInVariance.modelsFtVar[currentIndex],
                //     backend.ebv_model.get_fields_table[idFeatureEbv.currentText]
                // )

                // tableInVariance.getVariance(
                //     tableInVariance.initTable(
                //         tableInVariance.modelsFtVar[currentIndex],
                //         backend.ebv_model.get_fields_table[idFeatureEbv.currentText]
                //     )
                // )

            }

        }

    }

    Component {
        id: pBEst
        ProgressWindow {
            nameProcess: qsTr("Calculation of breeding value estimates has started!")
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

                            // Auto estimation feature
                            CustomCheckbox {
                                id: idChBAutoEstFt

                                nameChb: qsTr("Auto")

                                CustomTooltip {
                                    id: idHintAutoEst
                                    object: idChBAutoEstFt
                                    textLbl: qsTr("Automatic (Sequential) estimation of features by list.")

                                    x: idChBAutoEstFt.width
                                    visible: {
                                        if (disableTT) {
                                            return idChBAutoEstFt.hovered ? true : false
                                        }

                                        return false
                                    }
                                }
                            }

                            RowLayout {
                                spacing: 30
                                Layout.fillWidth: true

                                RowLayout {
                                    Layout.fillWidth: true

                                    enabled: idChBAutoEstFt.checked && idSelectTypeCalVar.displayText === "all" ? false : true
                                    opacity: idChBAutoEstFt.checked && idSelectTypeCalVar.displayText === "all" ? 0.5 : 1

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
                                        model: backend.ebv_model.list_feature

                                        hoverEnabled: !(idChBAutoEstFt.checked && idSelectTypeCalVar.displayText === "all")

                                        onCurrentTextChanged: {
                                            if (idSelectTypeCalVar.displayText === "conf") {

                                                tableInVariance.currentModel = tableInVariance.initTable(
                                                    tableInVariance.modelsFtVar[currentIndex],
                                                    backend.ebv_model.get_fields_table[idFeatureEbv.currentText]
                                                )

                                                return
                                            }

                                            tableInVariance.defVariance = tableInVariance.getVariance(
                                                tableInVariance.initTable(
                                                    tableInVariance.modelsFtVar[currentIndex],
                                                    backend.ebv_model.get_fields_table[idFeatureEbv.currentText]
                                                )
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

                                        hoverEnabled: idCheckBoxParallelEst.checked
                                    }
                                    Item { Layout.fillWidth: true }
                                }

                                background: null
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                RowLayout {
                                    Layout.fillWidth: true
                                    Layout.rightMargin: 40

                                    Text {
                                        Layout.rightMargin: 5

                                        text: qsTr("Variance calculation method:")
                                        font.family: "Segoe UI"
                                        font.pixelSize: sizeTextInSect
                                        color: txtSection
                                    }

                                    CustomComboBox {
                                        id: idSelectTypeCalVar
                                        model: ["all", "conf"]

                                        onCurrentTextChanged: {
                                            if (idSelectTypeCalVar.currentText === "conf") {
                                                tableInVariance.reloadTable(idFeatureEbv.currentIndex)
                                            }
                                        }
                                    }
                                }


                                // Generate file conf_var
                                RowLayout {
                                    spacing: 5
                                    Layout.fillWidth: true

                                    MenuGenerateCfgVar { id: idMenuGehCfgVar }

                                    Text {
                                        Layout.rightMargin: 5

                                        color: txtSection

                                        text: qsTr("Create config var: ")
                                        font.pixelSize: sizeTextInSect
                                        font.family: "Segoe UI"
                                        clip: true
                                        wrapMode: Text.WordWrap
                                    }

                                    CustomBtn {
                                        id: idBtnGenerateCfg

                                        sizeImgWH: 25
                                        srcImg: "qrc:/cfgvar/icons/icBtnGenCfgVar/process.svg"

                                        onClicked: idMenuGehCfgVar.open()

                                        CustomTooltip {
                                            object: idBtnGenerateCfg
                                            textLbl: qsTr("Menu for creating a variances configuration file.")

                                            visible: disableTT ? idBtnGenerateCfg.hovered : false
                                        }

                                        background.implicitWidth: 50
                                    }
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
}
