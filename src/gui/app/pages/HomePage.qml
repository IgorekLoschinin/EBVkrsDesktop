import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageProcessing
    anchors.fill: parent

    urlPage: "Home:"

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: 30
        anchors.rightMargin: 30

        contentItem: ColumnLayout {
            spacing: 10

            Text {
                id: idDescription
                Layout.fillWidth: true
                Layout.topMargin: 20
                Layout.bottomMargin: 30

                // text: "Configuration of primary data processing for calculations"
                font.pixelSize: 17
                color: "#FFFAFA"  // commonSettingPage.sectionColor
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
                        color: "#FFFAFA"
                    }

                    background: Rectangle {
                        color: "transparent"
                    }

                    onClicked: {
                        switch (model.name) {
                        case "proc":
                            console.log(model.textBtn)
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
