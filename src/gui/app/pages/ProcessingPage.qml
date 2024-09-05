import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing

    urlPage: "Processing:"

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: 10

            Text {
                id: idDescription
                Layout.fillWidth: true
                Layout.topMargin: 20
                Layout.bottomMargin: 30

                text: qsTr("Configuration of primary data processing for calculations")
                font.pixelSize: 17
                color: sectionColor
            }

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "ProcPheno"
                        textBtn: "Processing phenotype"
                        currInd: 2
                    }

                    ListElement {
                        name: "ProcSnp"
                        textBtn: "Processing SNP"
                        currInd: 3
                    }
                }

                delegate: Button {
                    id: idUrlProcessing
                    padding: 0
                    leftPadding: 30                    

                    contentItem: Text {
                        text: qsTr(model.textBtn)
                        font.pixelSize: 16
                        font.underline: idUrlProcessing.hovered
                        color: sectionColor
                    }

                    background: Rectangle {
                        color: "transparent"
                    }

                    onClicked: {
                        switch (model.name) {
                        case "ProcPheno":
                            console.log(model.textBtn)
                            idContent.currentIndex = model.currInd
                            return

                        case "ProcSnp":
                            console.log(model.textBtn)
                            idContent.currentIndex = model.currInd
                            return

                        }
                    }
                }
            }

            Item { Layout.fillHeight: true }

        }

        background: Rectangle {
            color: "transparent"
        }
    }

    footer: null
}
