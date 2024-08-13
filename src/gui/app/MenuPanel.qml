import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idMenuPanel
    anchors.fill: parent

    QtObject {
        id: panelSett

        property int tbMargin: 10
        property int lrMargin: 6

        property int shapeImg: 29
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
            }

            // Разделительная линия
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


            Button {
                id: idHome
                hoverEnabled: false

                contentItem: RowLayout {
                    spacing: 5
                    Image {
                        source: "../images/home.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Home"
                        // visible: false
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    opacity: 1
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idHome.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }
            }

            Button {
                id: idProcessing
                hoverEnabled: false

                contentItem: RowLayout {
                    Image {
                        source: "../images/processing.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Processing"
                        // visible: false
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idProcessing.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }
            }

            Button {
                id: idEstimate
                hoverEnabled: false

                contentItem: RowLayout {
                    Image {
                        source: "../images/estimate.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Estimate"
                        // visible: false
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idEstimate.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }
            }

            Button {
                id: idIndex
                hoverEnabled: false

                contentItem: RowLayout {
                    Image {
                        source: "../images/index.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Index"
                        // visible: false
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idIndex.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }
            }

            Button {
                id: idPipeline
                hoverEnabled: false

                contentItem: RowLayout {
                    Image {
                        source: "../images/pipeline.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Pipeline"
                        // visible: false
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idPipeline.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
                }
            }

            Button {
                id: idModeling
                hoverEnabled: false

                contentItem: RowLayout {
                    Image {
                        source: "../images/modelling.png"

                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: panelSett.shapeImg
                        sourceSize.height: panelSett.shapeImg
                    }

                    Label {
                        text: "Modeling"
                        // visible: false
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                background: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20

                    radius: bgRadius

                    border.color: idModeling.down ? "#3D629F" : "#B3C4E0"
                    border.width: 1
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
                        // visible: false
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
            }

            // Разделительная линия
            Rectangle {

                Layout.fillWidth: true
                Layout.topMargin: 50

                color: 'white'

                height: 2
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
                        // visible: false
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
                        // visible: false
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
            }
        }

    }

    background: Rectangle {
        color: "#3e485c"
        radius: bgRadius
    }

}
