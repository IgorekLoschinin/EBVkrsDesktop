import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idHeaderSectionCont

    property string nameSection: ""

    contentItem: RowLayout {
        spacing: 5

        Text {
            id: idNameSectionProp
            text: qsTr(nameSection)
            font.pixelSize: sizeTextLblSect
            font.bold: true
            color: sectionColor
        }

        Rectangle {
            color: 'white'
            height: 1

            Layout.fillWidth: true
        }
    }
}
