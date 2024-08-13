import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "controls"

Control {
    id: idMenuPanel
    anchors.fill: parent

    QtObject {
        id: panelSett

        property int tbMargin: 10
        property int lrMargin: 7

        property int shapeImg: 25
        property bool visibleText: true
    }

    contentItem: ColumnLayout {

        ColumnLayout {
            spacing: 5

            Layout.alignment: Qt.AlignTop

            Layout.topMargin: panelSett.tbMargin
            Layout.leftMargin: panelSett.lrMargin
            Layout.rightMargin: panelSett.lrMargin

            Button {
                id: idMenu
                hoverEnabled: false

                contentItem: Image {
                    source: "../images/hamburger.png"
                    // color: "#F5EDED"

                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: panelSett.shapeImg
                    sourceSize.height: panelSett.shapeImg
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius
                    // opacity: 0.3

                    border.color: idMenu.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }

                onClicked: {

                    if (idSideBar.checkerOpnCls) {
                        anim1.running = true
                        idSideBar.checkerOpnCls = false
                        panelSett.visibleText = false

                    } else {
                        anim2.running = true
                        idSideBar.checkerOpnCls = true
                        panelSett.visibleText = true
                    }

                }
            }

            Rectangle {
                color: 'white'
                height: 2

                Layout.fillWidth: true
            }
        }

        ColumnLayout {
            // spacing: 5

            Layout.leftMargin: panelSett.lrMargin
            Layout.rightMargin: panelSett.lrMargin

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "Home"
                        sourceImg: "../images/home.png"
                    }
                    ListElement {
                        name: "Processing"
                        sourceImg: "../images/processing.png"
                    }
                    ListElement {
                        name: "Estimate"
                        sourceImg: "../images/estimate.png"
                    }
                    ListElement {
                        name: "Index"
                        sourceImg: "../images/index.png"
                    }
                    ListElement {
                        name: "Pipeline"
                        sourceImg: "../images/pipeline.png"
                    }
                    ListElement {
                        name: "Modeling"
                        sourceImg: "../images/modelling.png"
                    }
                }

                delegate: Button {
                    id: idMenuBtn
                    hoverEnabled: false

                    contentItem: RowLayout {
                        spacing: 5
                        Image {
                            source: model.sourceImg

                            fillMode: Image.PreserveAspectFit
                            sourceSize.width: panelSett.shapeImg
                            sourceSize.height: panelSett.shapeImg
                        }

                        Label {
                            text: model.name
                            visible: panelSett.visibleText
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }
                    }

                    background: Rectangle {
                        opacity: 1
                        implicitHeight: 20
                        implicitWidth: 20

                        radius: bgRadius

                        border.color: idMenuBtn.down ? "#3D629F" : "#B3C4E0"
                        border.width: 1
                    }

                    onClicked: {
                        console.log(model.name)
                    }
                }

            }

        }

        ColumnLayout {
            spacing: 5

            Layout.bottomMargin: panelSett.tbMargin + 20
            Layout.leftMargin: panelSett.lrMargin
            Layout.rightMargin: panelSett.lrMargin

            Layout.alignment: Qt.AlignBottom

            Button {
                id: idAccount
                hoverEnabled: false

                contentItem: RowLayout {
                    Image {
                        source: "../images/user.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Account"
                        visible: panelSett.visibleText
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idAccount.down ? "#3D629F" : "#B3C4E0"
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
                id: idSettings
                hoverEnabled: false

                contentItem: RowLayout {

                    Image {
                        source: "../images/setting.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Settings"
                        visible: panelSett.visibleText
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idSettings.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }

                onClicked: {
                    console.log("Settings")
                }
            }

            Button {
                id: idHelp
                hoverEnabled: false                                

                contentItem: RowLayout {
                    Image {
                        source: "../images/help.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Help"
                        visible: panelSett.visibleText
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idHelp.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }

                onClicked: {
                    console.log("Help")
                }
            }
        }

    }

    background: Rectangle {
        color: "#3e485c"
        radius: bgRadius
    }

}
