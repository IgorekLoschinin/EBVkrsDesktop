import QtQuick
import QtQuick.Controls

Button {
    id: idBtnFileOpen

    property color colorImg: "#F5EDED"

    property color bgBtnColor: "#5d6575"
    property color borderColorPressed: "#4A515E"

    // DYNAMIC COLOR
    property color colorDef: "transparent"
    property color colorMouseOver: "#8792A8"
    property color colorPressed: "#4A515E"

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

    contentItem: ColorImage {
        source: "../../../icons/folder.svg"
        color: idBtnFileOpen.colorImg

        fillMode: Image.PreserveAspectFit
        sourceSize.width: 19
        sourceSize.height: 19
    }

    background: Rectangle {
        id: bgBtnFO

        radius: 4
        color: idInputGroup.enabled ? idBtnFileOpen.dynamicColor(idBtnFileOpen) : "transparent"

        border.color: idBtnFileOpen.down ? idBtnFileOpen.borderColorPressed : bgBtnFO.color
        border.width: 1
    }

}
