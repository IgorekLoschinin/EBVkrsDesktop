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

        onClicked: {
            if (idSideBar.checkerOpnCls) {
                checkVisibleProcCB = !checkVisibleProcCB
            }
        }
    }

    ColumnLayout {
        id: idLstMethProcessing
        spacing: 0
        visible: checkVisibleProcCB

        Layout.fillWidth: true

        CustomBtnSb {
            id: idBtnProcPheno
            Layout.fillWidth: true

            nameBtn: "- Phenotype"
        }

        CustomBtnSb {
            id: iBtnProcSNP
            Layout.fillWidth: true

            nameBtn: "- SNP"
        }
    }        
}
