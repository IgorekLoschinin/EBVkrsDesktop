import QtQuick
import QtQuick.Controls

Button {
    id: idBtnRoll
    hoverEnabled: false

    property url sourceImg: ""

    // contentItem: Image {
    //     id: rollImg
    //     source: sourceImg

    //     fillMode: Image.PreserveAspectFit
    //     sourceSize.height: propCtrlBtns.sourceSizeH
    //     sourceSize.width: propCtrlBtns.sourceSizeW
    // }

    // background: Rectangle {
    //     color: propCtrlBtns.colorBgBtn

    //     implicitHeight: 20
    //     implicitWidth: 20
    //     radius: propCtrlBtns.radiusBg

    //     border.color: idBtnRoll.down ? "#3D629F" : "#B3C4E0"
    //     border.width: 1
    // }

}
