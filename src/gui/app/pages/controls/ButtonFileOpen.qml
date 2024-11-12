import QtQuick
import QtQuick.Controls

Button {
    id: idBtnFileOpen

    property color colorImg: "#F5EDED"
    property string sourceImg: ""
    property int sizeImgWH: 19
    property bool switchBgColor: false


    readonly property color bgBtnColor: "#5d6575"
    readonly property color borderColorPressed: "#4A515E"

    // DYNAMIC COLOR
    readonly property color colorDef: "transparent"
    readonly property color colorMouseOver: "#8792A8"
    readonly property color colorPressed: "#4A515E"

    function dynamicColor (idBtn) {
        if (idBtn.down) {
            return colorPressed
        } else {
            if (idBtn.hovered) {
                return colorMouseOver
            }
        }

        return switchBgColor ? bgBtnColor : colorDef
    }

    contentItem: ColorImage {
        source: idBtnFileOpen.sourceImg
        color: idBtnFileOpen.colorImg

        fillMode: Image.PreserveAspectFit
        sourceSize.width: idBtnFileOpen.sizeImgWH
        sourceSize.height: idBtnFileOpen.sizeImgWH
    }

    background: Rectangle {
        id: bgBtnFO

        radius: 4
        color: idBtnFileOpen.dynamicColor(idBtnFileOpen)

        border.color: idBtnFileOpen.down ? idBtnFileOpen.borderColorPressed : bgBtnFO.color
        border.width: 1
    }

}
