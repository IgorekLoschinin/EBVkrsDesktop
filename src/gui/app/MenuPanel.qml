import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "controls"

Control {
    id: idMenuPanel
    anchors.fill: parent

    property double opacityLblP: 1

    QtObject {
        id: panelSett

        property int tbMargin: 10
        property int lrMargin: 8

        property int shapeImg: 25
        property color colorImg: "#F5EDED"

        property bool visibleText: true
        property color colorText: "#FFFAFA"

        property color bgBtnColor: "#5d6575"
        property color borderColorPressed: "#B3C4E0"
    }

    contentItem: ColumnLayout {

        // Button for expanding menu
        ColumnLayout {
            spacing: 5

            Layout.alignment: Qt.AlignTop

            Layout.topMargin: panelSett.tbMargin
            Layout.leftMargin: panelSett.lrMargin
            Layout.rightMargin: panelSett.lrMargin

            MenuButton { id: idMenu }

            Rectangle {
                color: 'white'
                height: 2

                Layout.fillWidth: true
            }
        }

        // Panel with modeling processing methods
        ColumnLayout {
            spacing: 5

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "Home"
                        sourceImg: "../icons/home.svg"
                    }
                    ListElement {
                        name: "Processing"
                        sourceImg: "../icons/processing.svg"
                    }
                    ListElement {
                        name: "Estimate"
                        sourceImg: "../icons/estimate.svg"
                    }
                    ListElement {
                        name: "Index"
                        sourceImg: "../icons/index.svg"
                    }
                    ListElement {
                        name: "Pipeline"
                        sourceImg: "../icons/pipeline.svg"
                    }
                    ListElement {
                        name: "Modeling"
                        sourceImg: "../icons/modelling.svg"
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

        // Panel with settings, logging and help
        ColumnLayout {
            spacing: 5

            Layout.bottomMargin: panelSett.tbMargin + 20
            Layout.alignment: Qt.AlignBottom

            Button {
                id: idBtnAccount
                hoverEnabled: false

                Layout.fillWidth: true

                leftPadding: panelSett.lrMargin + 3
                contentItem: RowLayout {
                    spacing: 10

                    ColorImage {
                        source: "../icons/user.svg"
                        color: panelSett.colorImg

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        Layout.fillWidth: true

                        color: panelSett.colorText
                        text: "Account"
                        opacity: opacityLblP

                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    id: bgBtnAccount

                    implicitHeight: 20
                    implicitWidth: 20

                    color: panelSett.bgBtnColor

                    Rectangle {
                        color: '#2CEF00'
                        width: 4
                        height: idBtnAccount.height
                    }

                    border.color: idBtnAccount.down ? panelSett.borderColorPressed : bgBtnAccount.color
                    border.width: 1
                }

                onClicked: {
                    console.log("Account")
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.topMargin: 50

                height: 2
                color: 'white'
            }

            Button {
                id: idBtnSettings
                hoverEnabled: false

                Layout.fillWidth: true

                leftPadding: panelSett.lrMargin + 3
                contentItem: RowLayout {
                    spacing: 10

                    ColorImage {
                        source: "../icons/setting.svg"
                        color: panelSett.colorImg

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        Layout.fillWidth: true

                        color: panelSett.colorText
                        text: "Settings"
                        opacity: opacityLblP

                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    id: bgBtnSettings

                    implicitHeight: 20
                    implicitWidth: 20

                    color: panelSett.bgBtnColor

                    Rectangle {
                        color: '#2CEF00'
                        width: 4
                        height: idBtnSettings.height
                    }

                    border.color: idBtnSettings.down ? panelSett.borderColorPressed : bgBtnSettings.color
                    border.width: 1
                }

                onClicked: {
                    console.log("Settings")
                }
            }

            Button {
                id: idBtnHelp
                hoverEnabled: false

                Layout.fillWidth: true

                leftPadding: panelSett.lrMargin + 3
                contentItem: RowLayout {
                    spacing: 10

                    ColorImage {
                        source: "../icons/help.svg"
                        color: panelSett.colorImg

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        Layout.fillWidth: true

                        color: panelSett.colorText
                        text: "Help"
                        opacity: opacityLblP

                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    id: bgBtnHelp

                    implicitHeight: 30
                    implicitWidth: 30

                    color: panelSett.bgBtnColor
                    visible: true

                    Rectangle {
                        color: '#2CEF00'
                        width: 4
                        height: idBtnHelp.height
                    }

                    border.color: idBtnHelp.down ? panelSett.borderColorPressed : bgBtnHelp.color
                    border.width: 1
                }

                onClicked: {
                    console.log("Help")
                    // bgBtnHelp.visible = true
                }
            }
        }

    }

}
