import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


Control {
    id: idSwitchHeadSectCont

    property string nameSection: ""
    property bool checked: idSwitchSect.checked

    contentItem: RowLayout {
        spacing: 5

        CustomSwitch {
            id: idSwitchSect

            contentItem: Text {
                leftPadding: idSwitchSect.indicator.width + 6

                text: qsTr(nameSection)
                font.pixelSize: sizeTextLblSect
                font.family: "Segoe UI"
                font.bold: true
                color: sectionColor

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            color: 'white'
            height: 1

            Layout.fillWidth: true
        }
    }
}
