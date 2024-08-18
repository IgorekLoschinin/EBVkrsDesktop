import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idAreaProcMethods

    contentItem: ColumnLayout {
        spacing: 5        

        Button {
            id: idBtnHome
            hoverEnabled: false

            Layout.fillWidth: true

            leftPadding: panelSett.lrMargin + 3
            contentItem: RowLayout {
                spacing: 10
                ColorImage {
                    source: "../../icons/home.svg"
                    color: panelSett.colorImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: panelSett.shapeImg
                    sourceSize.height: panelSett.shapeImg
                }

                Label {
                    Layout.fillWidth: true

                    text: "Home"
                    color: panelSett.colorText
                    opacity: opacityLblP

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }
            }

            background: Rectangle {
                id: bgBtnHome
                opacity: 1
                implicitHeight: 20
                implicitWidth: 20

                color: panelSett.bgBtnColor

                Rectangle {
                    color: '#2CEF00'
                    width: 4
                    height: idBtnHome.height
                }

                border.color: idBtnHome.down ? panelSett.borderColorPressed : bgBtnHome.color
                border.width: 1
            }

            onClicked: {
                console.log("Home")
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

            delegate: Button {
                id: idBtnMethods
                hoverEnabled: false

                Layout.fillWidth: true

                leftPadding: panelSett.lrMargin + 3
                contentItem: RowLayout {
                    spacing: 10
                    ColorImage {
                        source: model.sourceImg
                        color: panelSett.colorImg

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        Layout.fillWidth: true

                        text: model.name
                        color: panelSett.colorText
                        opacity: opacityLblP

                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    id: bgBtnMethod
                    opacity: 1
                    implicitHeight: 20
                    implicitWidth: 20

                    color: panelSett.bgBtnColor

                    Rectangle {
                        color: '#2CEF00'
                        width: 4
                        height: idBtnMethods.height
                    }

                    border.color: idBtnMethods.down ? panelSett.borderColorPressed : bgBtnMethod.color
                    border.width: 1
                }

                onClicked: {
                    console.log(model.name)
                }
            }

        }

    }
}
