import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: idCustomBtnSb

    property url sourceImg: ""
    property string nameBtn: qsTr("")

    property bool sideLightBtn: false
    property string bgTargetColor: ""

    leftPadding: panelSett.lrMargin + 3

    width: 150

    contentItem: RowLayout {
        spacing: 10

        ColorImage {
            source: sourceImg
            color: panelSett.colorImg

            fillMode: Image.PreserveAspectFit
            sourceSize.width: panelSett.shapeImg
            sourceSize.height: panelSett.shapeImg
        }

        Text {
            Layout.fillWidth: true

            color: panelSett.colorText
            text: nameBtn
            font.pixelSize: 15
            font.family: "Segoe UI"
            opacity: opacityLblP
            wrapMode: {
                if (idSideBar.width < panelSett.sizeOpenSb) {
                    return Text.WordWrap
                }
                return Text.Wrap
            }

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
