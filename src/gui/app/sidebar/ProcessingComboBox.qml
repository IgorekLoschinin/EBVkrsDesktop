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
            idContent.currentIndex = 1
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
                        currInd: 2
                    }

                    ListElement {
                        name: "- SNP"
                        currInd: 3
                    }
                }

                delegate: CustomBtnSb {
                    id: idBtnSubMethProc
                    Layout.fillWidth: true

                    nameBtn: model.name

                    sideLightBtn: activityLightBtn(model.name)
                    bgTargetColor: activityTargetBtn(idBtnSubMethProc, model.name)

                    onClicked: {
                        idSideBar.activeButton = nameBtn
                        idContent.currentIndex = model.currInd
                    }
                }
            }
        }

    }

}
