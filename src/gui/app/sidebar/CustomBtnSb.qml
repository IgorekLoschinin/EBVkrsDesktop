import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: idCustomBtnSb

    property url sourceImg: ""
    property string nameBtn: ""

    property bool sideLightBtn: false
    property string bgTargetColor: ""

    leftPadding: panelSett.lrMargin + 3

    contentItem: RowLayout {
        spacing: 10

        ColorImage {
            source: sourceImg
            color: panelSett.colorImg

            fillMode: Image.PreserveAspectFit
            sourceSize.width: panelSett.shapeImg
            sourceSize.height: panelSett.shapeImg
        }

        Label {
            Layout.fillWidth: true

            color: panelSett.colorText
            text: nameBtn
            opacity: opacityLblP

            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
        }
    }

    background: Rectangle {
        id: bgCustBtSb

        implicitHeight: 20
        implicitWidth: 20

        color: idCustomBtnSb.bgTargetColor

        // Side lighting for button
        Rectangle {
            color: '#2CEF00'
            width: 3
            height: idCustomBtnSb.height

            visible: idCustomBtnSb.sideLightBtn
        }

        border.color: idCustomBtnSb.down ? panelSett.borderColorPressed : bgCustBtSb.color
        border.width: 1
    }
}
