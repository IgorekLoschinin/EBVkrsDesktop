import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idPnlWinCtrlBtn

    anchors.right: parent.right
    anchors.rightMargin: 15
    anchors.verticalCenter: parent.verticalCenter

    QtObject {
        id: propCtrlBtns

        // Dynamic color
        property color colorDef: "#B3C4E0"
        property color colorMouseOver: "#C6B8B8"
        property color colorPressed: "#E0C3C3"

        property color colorBgBtn: "#B3C4E0"
        property color borderColorPress: "#3D629F"
        property int sourceSizeH: 15
        property int sourceSizeW: 15
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
                    sourceImg: "../../icons/collapse.svg"
                }
                ListElement{
                    name: "fullSize"
                    sourceImg: "../../icons/expanding.svg"
                }
                ListElement{
                    name: "close"
                    sourceImg: "../../icons/close.svg"
                }
            }

            delegate: Button {
                id: idBtnWC
                // hoverEnabled: false

                contentItem: Image {
                    source: model.sourceImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: propCtrlBtns.sourceSizeH
                    sourceSize.width: propCtrlBtns.sourceSizeW
                }

                background: Rectangle {
                    color: propCtrlBtns.dynamicColor(idBtnWC)

                    implicitHeight: 20
                    implicitWidth: 20
                    radius: propCtrlBtns.radiusBg

                    border.color: idBtnWC.down ? propCtrlBtns.borderColorPress : propCtrlBtns.colorBgBtn
                    border.width: 1
                }

                onClicked: {
                    switch (model.name) {
                    case "roll":
                        appWindow.showMinimized()
                        return

                    case "fullSize":
                        if (appWindow.visibility === Window.Maximized) {
                            appWindow.showNormal()
                            model.sourceImg = "../../icons/expanding.svg"
                            return
                        }
                        appWindow.showMaximized()
                        model.sourceImg = "../../icons/reduceW.svg"
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
