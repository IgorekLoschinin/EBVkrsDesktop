import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: idCustomBtnSb

    property url sourceImg: ""
    property string nameBtn: ""

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
        id: bgBtnAccount    

        implicitHeight: 20
        implicitWidth: 20

        color: panelSett.dynamicColor(idCustomBtnSb)

        Rectangle {
            color: '#2CEF00'
            width: 4
            height: idCustomBtnSb.height

            visible: false
        }

        border.color: idCustomBtnSb.down ? panelSett.borderColorPressed : bgBtnAccount.color
        border.width: 1
    }

    onClicked: {
        console.log(nameBtn)
    }
}
