import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idHomePage

    urlPage: qsTr("Home:")

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

                text: qsTr("    Software for assessing the breeding value of cattle, which offers the following methods for processing, assessing and generating reports:")
                font.pixelSize: 17
                font.family: "Segoe UI"
                color: sectionColor

                wrapMode: Text.WordWrap
            }

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "proc"
                        textBtn: qsTr("Processing")
                    }

                    ListElement {
                        name: "est"
                        textBtn: qsTr("Estimate breeding value")
                    }

                    ListElement {
                        name: "ind"
                        textBtn: qsTr("Idexing estimation")
                    }

                    ListElement {
                        name: "pipe"
                        textBtn: qsTr("Pipeline")
                    }

                    ListElement {
                        name: "mod"
                        textBtn: qsTr("Modeling")
                    }
                }

                delegate: Button {
                    id: idUrlProcessing
                    padding: 0
                    leftPadding: 30

                    contentItem: Text {
                        text: qsTr(model.textBtn)
                        font.pixelSize: 16
                        font.family: "Segoe UI"
                        font.underline: idUrlProcessing.hovered
                        color: sectionColor
                    }

                    background: Rectangle {
                        color: "transparent"
                    }

                    onClicked: {
                        switch (model.name) {
                        case "proc":
                            idContent.currentIndex = 1
                            return

                        case "est":
                            idContent.currentIndex = 4
                            return

                        case "ind":
                            idContent.currentIndex = 5
                            return

                        case "pipe":
                            idContent.currentIndex = 6
                            return

                        case "mod":
                            idContent.currentIndex = 7
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
