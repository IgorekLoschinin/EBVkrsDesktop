import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idAreaProcMethods

    contentItem: ColumnLayout {
        spacing: 5

        CustomBtnSb {
            id: idBtnHome
            Layout.fillWidth: true

            nameBtn: qsTr("Home")
            sourceImg: "qrc:/icons/home.svg"

            sideLightBtn: activityLightBtn(nameBtn)
            bgTargetColor: activityTargetBtn(idBtnHome, nameBtn)

            onClicked: {
                idSideBar.activeButton = nameBtn
                idContent.currentIndex = 0
            }
        }

        ProcessingComboBox {
            id: idComboBoxProcessing

            Layout.fillWidth: true
        }

        Repeater {
            model: ListModel {
                ListElement {
                    name: "Estimate"
                    sourceImg: "qrc:/icons/estimate.svg"
                    currInd: 4
                }
                ListElement {
                    name: "Index"
                    sourceImg: "qrc:/icons/index.svg"
                    currInd: 5
                }
                ListElement {
                    name: "Pipeline"
                    sourceImg: "qrc:/icons/pipeline.svg"
                    currInd: 6
                }
                ListElement {
                    name: "Modeling"
                    sourceImg: "qrc:/icons/modelling.svg"
                    currInd: 7
                }
            }

            delegate: CustomBtnSb {
                id: idBtnMeth
                Layout.fillWidth: true

                nameBtn: qsTr(model.name)
                sourceImg: model.sourceImg

                sideLightBtn: activityLightBtn(nameBtn)
                bgTargetColor: activityTargetBtn(idBtnMeth, nameBtn)

                onClicked: {
                    idSideBar.activeButton = nameBtn
                    idContent.currentIndex = model.currInd
                }
            }

        }

    }
}
