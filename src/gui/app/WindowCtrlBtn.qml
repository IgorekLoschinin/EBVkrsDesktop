import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "pages/controls"

Control {
    id: idPnlWinCtrlBtn

    anchors.right: parent.right
    anchors.rightMargin: 15
    anchors.verticalCenter: parent.verticalCenter

    QtObject {
        id: propCtrlBtns

        // Dynamic color
        property color colorDef: "transparent"
        property color colorMouseOver: "#8792A8"
        property color colorPressed: "#4A515E"

        property color colorBgBtn: "#B3C4E0"
        property color borderColorPress: "#3D629F"
        property int sourceSizeH: 13
        property int sourceSizeW: 13
        property int radiusBg: 5

        function dynamicColor (idBtn) {
            if (idBtn.down) {
                return colorPressed
            } else {
                if (idBtn.hovered) {
                    return colorMouseOver
                }
            }

            return colorDef
        }
    }

    contentItem: RowLayout {
        spacing: 3

        Repeater {
            model: ListModel {
                ListElement{
                    name: "roll"
                    sourceImg: "qrc:/icons/minus.svg"
                    ttName: qsTr("Minimize")
                    positionX: 12
                }
                ListElement{
                    name: "fullSize"
                    sourceImg: "qrc:/icons/maximize.svg"
                    ttName: qsTr("Maximize")
                    positionX: 12
                }
                ListElement{
                    name: "close"
                    sourceImg: "qrc:/icons/close.svg"
                    ttName: qsTr("Close")
                    positionX: 12
                }
            }

            delegate: Button {
                id: idBtnWC

                CustomTooltip {
                    id: ttBtnWC

                    object: idBtnWC
                    textLbl: ttName
                    sizeText: 12

                    x: - ttBtnWC.width + object.width
                }

                contentItem: ColorImage {
                    source: model.sourceImg
                    color: "white"

                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: propCtrlBtns.sourceSizeH
                    sourceSize.width: propCtrlBtns.sourceSizeW
                }

                background: Rectangle {
                    color: {
                        if (model.name === "close") {
                            if (idBtnWC.down) {
                                return Qt.darker("red", 1.2)
                            } else {
                                if (idBtnWC.hovered) {
                                    return "red"
                                }
                            }
                        }

                        propCtrlBtns.dynamicColor(idBtnWC)
                    }

                    implicitHeight: 20
                    implicitWidth: 20
                    radius: propCtrlBtns.radiusBg
                }

                onClicked: {
                    switch (model.name) {
                    case "roll":
                        appWindow.showMinimized()
                        return

                    case "fullSize":
                        if (appWindow.visibility === Window.Maximized) {
                            appWindow.showNormal()
                            model.sourceImg = "qrc:/icons/maximize.svg"
                            return
                        }
                        appWindow.showMaximized()
                        model.sourceImg = "qrc:/icons/squares.svg"
                        model.ttName = qsTr("Restore")
                        return

                    case "close":
                        appWindow.close()
                        return
                    }
                }
            }
        }

    }
}
