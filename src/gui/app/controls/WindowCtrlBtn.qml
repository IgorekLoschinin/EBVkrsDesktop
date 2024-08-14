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
        property int sourceSizeH: 15
        property int sourceSizeW: 15
        property int radiusBg: 5

    }

    contentItem: RowLayout {
        spacing: 3

        Button {
            id: idBtnRoll

            hoverEnabled: false

            contentItem: Image {
                id: rollImg
                source: "../../icons/collapse.svg"

                fillMode: Image.PreserveAspectFit
                sourceSize.height: propCtrlBtns.sourceSizeH
                sourceSize.width: propCtrlBtns.sourceSizeW
            }

            background: Rectangle {
                color: propCtrlBtns.colorBgBtn

                implicitHeight: 20
                implicitWidth: 20
                radius: propCtrlBtns.radiusBg

                border.color: idBtnRoll.down ? "#3D629F" : "#B3C4E0"
                border.width: 1
            }

            onClicked: {
                appWindow.showMinimized()
            }
        }

        Button {
            id: idBtnFullSize

            hoverEnabled: false

            contentItem: Image {
                id: sizeWindImg
                source: "../../icons/expanding.svg"

                fillMode: Image.PreserveAspectFit
                sourceSize.height: propCtrlBtns.sourceSizeH
                sourceSize.width: propCtrlBtns.sourceSizeW
            }

            background: Rectangle {
                color: propCtrlBtns.colorBgBtn

                implicitHeight: 20
                implicitWidth: 20
                radius: propCtrlBtns.radiusBg

                border.color: idBtnFullSize.down ? "#3D629F" : "#B3C4E0"
                border.width: 1
            }

            onClicked: {
                appWindow.showMaximized()
            }
        }

        Button {
            id: idBtnClose
            hoverEnabled: false

            contentItem: Image {
                id: closeImg
                source: "../../icons/close.svg"

                fillMode: Image.PreserveAspectFit
                sourceSize.height: propCtrlBtns.sourceSizeH
                sourceSize.width: propCtrlBtns.sourceSizeW
            }

            background: Rectangle {
                color: propCtrlBtns.colorBgBtn

                implicitHeight: 20
                implicitWidth: 20
                radius: propCtrlBtns.radiusBg

                border.color: idBtnClose.down ? "#3D629F" : "#B3C4E0"
                border.width: 1
            }

            onClicked: {
                appWindow.close()
            }
        }

    }
}
