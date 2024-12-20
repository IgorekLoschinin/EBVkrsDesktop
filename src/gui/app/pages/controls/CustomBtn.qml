import QtQuick
import QtQuick.Controls

Button {
    id: idBtnRun

    property string srcImg: ""
    property color colorImg: "green"

    property color dlgColorDef: "transparent"
    property color dlgColorMouseOver: "#CFAF68"
    property color dlgColorPressed: "#C79831"

    function dynamicColor (idBtn, cDef, cMO, cP) {
        if (idBtn.down) {
            return cP
        } else {
            if (idBtn.hovered) {
                return cMO
            }
        }

        return cDef
    }

    contentItem: ColorImage {
        source: srcImg
        color: colorImg

        fillMode: Image.PreserveAspectFit
        sourceSize.height: 30
        sourceSize.width: 30
    }

    background: Rectangle {
        color: dynamicColor(
                   idBtnRun,
                   dlgColorDef,
                   dlgColorMouseOver,
                   dlgColorPressed
        )

        implicitHeight: 30
        implicitWidth: 30
        radius: 5
    }
}
