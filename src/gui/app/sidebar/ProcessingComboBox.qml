import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ColumnLayout {
    id: idComboBoxProcessing
    spacing: 0

    CustomBtnSb {
        id: idProcessing
        Layout.fillWidth: true

        nameBtn: "Processing"
        sourceImg: "../../icons/processing.svg"

        sideLightBtn: activityLightBtn(nameBtn)
        bgTargetColor: activityTargetBtn(idProcessing, nameBtn)

        onClicked: {
            if (idSideBar.checkerOpnCls) {
                checkVisibleProcCB = !checkVisibleProcCB
            }

            idSideBar.activeButton = nameBtn
            idContent.newActivity("../pages/ProcessingPage.qml")
        }
    }

    Control {
        id: idLstMethProcessing
        visible: checkVisibleProcCB

        Layout.fillWidth: true

        contentItem: ColumnLayout {
            spacing: 0

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "- Phenotype"
                        pathToPage: "../pages/ProcPhenoPage.qml"
                    }

                    ListElement {
                        name: "- SNP"
                        pathToPage: "../pages/ProcSnpPage.qml"
                    }
                }

                delegate: CustomBtnSb {
                    id: idBtnSubMethProc
                    Layout.fillWidth: true

                    nameBtn: model.name

                    sideLightBtn: activityLightBtn(nameBtn)
                    bgTargetColor: activityTargetBtn(idBtnSubMethProc, nameBtn)

                    onClicked: {
                        idSideBar.activeButton = nameBtn
                        idContent.newActivity(model.pathToPage)
                    }
                }
            }
        }

    }

}
