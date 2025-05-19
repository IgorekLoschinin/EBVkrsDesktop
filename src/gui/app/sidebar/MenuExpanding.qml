import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects


Control {

    contentItem: ColumnLayout {
        spacing: 5

        Button {
            id: idBtnMenu

            contentItem: Image {
                id: idImgHamburg
                source: "qrc:/icons/hamburger.svg"

                fillMode: Image.PreserveAspectFit
                sourceSize.width: panelSett.shapeImg
                sourceSize.height: panelSett.shapeImg

                MultiEffect {
                    id: effect
                    anchors.fill: parent
                    source: idImgHamburg

                    colorization: 1.0
                    colorizationColor: panelSett.colorImg
                }
            }

            background: Rectangle {
                id: bgBtnMenu

                implicitHeight: 20
                implicitWidth: 20

                color: panelSett.dynamicColor(idBtnMenu)

                radius: bgRadius

                border.color: idBtnMenu.down ? panelSett.borderColorPressed : bgBtnMenu.color
                border.width: 1
            }

            onClicked: sidingMenu()
        }

        Rectangle {
            color: 'white'
            height: 2

            Layout.fillWidth: true
        }
    }
}
