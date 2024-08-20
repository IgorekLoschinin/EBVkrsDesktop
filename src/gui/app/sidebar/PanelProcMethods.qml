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

            nameBtn: "Home"
            sourceImg: "../../icons/home.svg"
        }

        ProcessingComboBox {
            id: idComboBoxProcessing

            Layout.fillWidth: true
        }

        Repeater {
            model: ListModel {
                ListElement {
                    name: "Estimate"
                    sourceImg: "../../icons/estimate.svg"
                }
                ListElement {
                    name: "Index"
                    sourceImg: "../../icons/index.svg"
                }
                ListElement {
                    name: "Pipeline"
                    sourceImg: "../../icons/pipeline.svg"
                }
                ListElement {
                    name: "Modeling"
                    sourceImg: "../../icons/modelling.svg"
                }
            }

            delegate: CustomBtnSb {
                Layout.fillWidth: true

                nameBtn: model.name
                sourceImg: model.sourceImg
            }

        }

    }
}
