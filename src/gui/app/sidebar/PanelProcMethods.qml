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

            sideLightBtn: activityLightBtn(nameBtn)
            bgTargetColor: activityTargetBtn(idBtnHome, nameBtn)

            onClicked: {
                idSideBar.activeButton = nameBtn
                idContent.newActivity("../pages/HomePage.qml")
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
                    sourceImg: "../../icons/estimate.svg"
                    pathToPage: "../pages/EstimationPage.qml"
                }
                ListElement {
                    name: "Index"
                    sourceImg: "../../icons/index.svg"
                    pathToPage: "../pages/IndexingPage.qml"
                }
                ListElement {
                    name: "Pipeline"
                    sourceImg: "../../icons/pipeline.svg"
                    pathToPage: "../pages/PipelinePage.qml"
                }
                ListElement {
                    name: "Modeling"
                    sourceImg: "../../icons/modelling.svg"
                    pathToPage: "../pages/ModelingPage.qml"
                }
            }

            delegate: CustomBtnSb {
                id: idBtnMeth
                Layout.fillWidth: true

                nameBtn: model.name
                sourceImg: model.sourceImg

                sideLightBtn: activityLightBtn(nameBtn)
                bgTargetColor: activityTargetBtn(idBtnMeth, nameBtn)

                onClicked: {
                    idSideBar.activeButton = nameBtn
                    idContent.newActivity(model.pathToPage)
                }
            }

        }

    }
}
