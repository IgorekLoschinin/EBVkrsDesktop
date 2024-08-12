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

    contentItem: Row {
        spacing: 3

        Button {
            id: idBtnRoll

            hoverEnabled: false

            contentItem: Image {
                id: rollImg
                source: "../../images/collapse.png"

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
                source: "../../images/expanding-two-opposite-arrows-diagonal-symbol-of-interface.png"

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
                source: "../../images/close.png"

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
