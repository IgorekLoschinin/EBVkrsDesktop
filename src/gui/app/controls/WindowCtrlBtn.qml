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

        property string colorBgBtn: "#B3C4E0"
        property string borderColorPress: "#3D629F"
        property int sourceSizeH: 15
        property int sourceSizeW: 15
        property int radiusBg: 5

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
                hoverEnabled: false

                contentItem: Image {
                    source: model.sourceImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: propCtrlBtns.sourceSizeH
                    sourceSize.width: propCtrlBtns.sourceSizeW
                }

                background: Rectangle {
                    color: propCtrlBtns.colorBgBtn

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
                        appWindow.showMaximized()
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
