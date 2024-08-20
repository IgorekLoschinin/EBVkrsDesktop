import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {

    contentItem: ColumnLayout {
        spacing: 5

        Button {
            id: idBtnMenu
            // hoverEnabled: false

            contentItem: ColorImage {
                source: "../../icons/hamburger.svg"
                color: panelSett.colorImg

                fillMode: Image.PreserveAspectFit
                sourceSize.width: panelSett.shapeImg
                sourceSize.height: panelSett.shapeImg
            }

            background: Rectangle {
                id: bgBtnMenu

                implicitHeight: 20
                implicitWidth: 20

                color: panelSett.dynamicColor(idBtnMenu)  // panelSett.bgBtnColor

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
