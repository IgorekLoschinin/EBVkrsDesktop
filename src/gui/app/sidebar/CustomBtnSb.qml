import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects


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

        Image {
            id: idBtnMenuSideB
            source: sourceImg

            fillMode: Image.PreserveAspectFit
            sourceSize.width: panelSett.shapeImg
            sourceSize.height: panelSett.shapeImg

            MultiEffect {
                id: effect
                anchors.fill: parent
                source: idBtnMenuSideB

                colorization: 1.0
                colorizationColor: panelSett.colorImg
            }
        }

        Text {
            Layout.fillWidth: true

            color: panelSett.colorText
            text: nameBtn
            font.pixelSize: 14
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
