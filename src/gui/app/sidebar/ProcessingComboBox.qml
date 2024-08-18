import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ColumnLayout {
    id: idComboBoxProcessing
    spacing: 0

    Button {
        id: custComboBoxProc
        hoverEnabled: false

        Layout.fillWidth: true

        leftPadding: panelSett.lrMargin + 3
        contentItem: RowLayout {
            spacing: 10

            ColorImage {
                source: "../../icons/processing.svg"
                color: panelSett.colorImg

                fillMode: Image.PreserveAspectFit
                sourceSize.width: panelSett.shapeImg
                sourceSize.height: panelSett.shapeImg
            }

            Label {
                Layout.fillWidth: true

                color: panelSett.colorText
                text: "Processing"
                opacity: opacityLblP

                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }
        }

        background: Rectangle {
            id: bgBtnComboBoxProc

            implicitHeight: 20
            implicitWidth: 20

            color: panelSett.bgBtnColor

            Rectangle {
                color: '#2CEF00'
                width: 4
                height: custComboBoxProc.height
            }

            border.color: custComboBoxProc.down ? panelSett.borderColorPressed : bgBtnComboBoxProc.color
            border.width: 1
        }

        onClicked: {
            tstbtn.visible = !tstbtn.visible
        }
    }

    ColumnLayout {
        id: tstbtn
        spacing: 0
        visible: false

        Layout.fillWidth: true


        Button {
            id: idBtnProcPheno
            hoverEnabled: false

            Layout.fillWidth: true

            leftPadding: panelSett.lrMargin + 3
            contentItem: RowLayout {
                spacing: 10

                ColorImage {
                    // source: "../../icons/processing.svg"
                    color: panelSett.colorImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: panelSett.shapeImg
                    sourceSize.height: panelSett.shapeImg
                }

                Label {
                    Layout.fillWidth: true

                    color: panelSett.colorText
                    text: "- Phenotype"
                    opacity: opacityLblP

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }
            }

            background: Rectangle {
                id: bgBtnProcPheno

                implicitHeight: 33
                implicitWidth: 33

                color: panelSett.bgBtnColor

                Rectangle {
                    color: '#21B500'
                    width: 4
                    height: idBtnProcPheno.height
                }

                border.color: idBtnProcPheno.down ? panelSett.borderColorPressed : bgBtnProcPheno.color
                border.width: 1
            }

            onClicked: {
                console.log("Processing -> Phenotype")
            }
        }

        Button {
            id: iBtnProcSNP
            hoverEnabled: false

            Layout.fillWidth: true

            leftPadding: panelSett.lrMargin + 3
            contentItem: RowLayout {
                spacing: 10

                ColorImage {
                    // source: "../../icons/processing.svg"
                    color: panelSett.colorImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: panelSett.shapeImg
                    sourceSize.height: panelSett.shapeImg
                }

                Label {
                    Layout.fillWidth: true

                    color: panelSett.colorText
                    text: "- SNP"
                    opacity: opacityLblP

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }
            }

            background: Rectangle {
                id: bgBtnProcSNP

                implicitHeight: 33
                implicitWidth: 33

                color: panelSett.bgBtnColor

                Rectangle {
                    color: '#21B500'
                    width: 4
                    height: iBtnProcSNP.height
                }

                border.color: iBtnProcSNP.down ? panelSett.borderColorPressed : bgBtnProcSNP.color
                border.width: 1
            }

            onClicked: {
                console.log("Processing -> SNP")
            }
        }
    }        
}
