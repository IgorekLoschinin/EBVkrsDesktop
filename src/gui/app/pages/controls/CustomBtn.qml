import QtQuick
import QtQuick.Controls

Button {
    id: idCustBtn

    property string srcImg: ""
    property int sizeImgWH: 19
    property color colorImg: "#F5EDED"

    property color dlgColorDef: "#5d6575"
    property color dlgColorMouseOver: "#8792A8"
    property color dlgColorPressed: "#4A515E"

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
        source: idCustBtn.srcImg
        color: idCustBtn.colorImg

        fillMode: Image.PreserveAspectFit
        sourceSize.height: idCustBtn.sizeImgWH
        sourceSize.width: idCustBtn.sizeImgWH
    }

    background: Rectangle {
        color: dynamicColor(
                   idCustBtn,
                   idCustBtn.dlgColorDef,
                   idCustBtn.dlgColorMouseOver,
                   idCustBtn.dlgColorPressed
        )

        implicitHeight: 30
        implicitWidth: 30
        radius: 4
    }
}
