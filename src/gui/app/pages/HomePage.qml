import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idHomePage

    urlPage: "Home:"

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

//                 text: qsTr("    Программное обеспечение для оценки племенной ценности крупнорогатого скота, которая предлогает
// следующие методы для обработки, оценки и формирования отчетов: ")
                text: qsTr("    Software for assessing the breeding value of cattle, which offers the following methods for processing, assessing and generating reports:")
                font.pixelSize: 17
                color: sectionColor

                wrapMode: Text.WordWrap
            }

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "proc"
                        textBtn: "Processing"
                    }

                    ListElement {
                        name: "est"
                        textBtn: "Estimate breeding value"
                    }

                    ListElement {
                        name: "ind"
                        textBtn: "Idexing estimation"
                    }

                    ListElement {
                        name: "pipe"
                        textBtn: "Pipeline"
                    }

                    ListElement {
                        name: "mod"
                        textBtn: "Modeling"
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
                        case "proc":
                            console.log(model.textBtn)

                            // idSideBar.activeButton = nameBtn
                            // idContent.newActivity("./ProcessingPage.qml")

                            return

                        case "est":
                            console.log(model.textBtn)
                            return

                        case "ind":
                            console.log(model.textBtn)
                            return

                        case "pipe":
                            console.log(model.textBtn)
                            return

                        case "mod":
                            console.log(model.textBtn)
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
}
