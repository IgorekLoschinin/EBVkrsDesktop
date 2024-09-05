import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"

Page {
    id: idPage

    property string urlPage: ""

    readonly property int leftRightMargin: 29
    readonly property int marginContentD: 30
    readonly property int marginContentSect: 15

    readonly property int sizeTextLblSect: 17  // размер текста у названий секций
    readonly property int sizeTextInSect: 16  // размер текста внутри секций

    readonly property color sectionColor: "#FFFAFA"
    readonly property color txtSection: "#D1E37D"

    header: Control {
        id: idHeaderPage
        height: 50

        contentItem: RowLayout {            
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                text: qsTr(urlPage)
                font.pixelSize: 18
                font.bold: true
                color: "#FFFEF0"

                Layout.fillWidth: true
                Layout.topMargin: 15
                Layout.leftMargin: leftRightMargin

                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }
        }

        background: Rectangle {
            color: "transparent"
            topLeftRadius: bgRadius
            topRightRadius: bgRadius
        }
    }

    footer: CstmDialogBtnPage{
        id: idCustomDialogBtn
    }

    // Background page
    background: Rectangle {
        color: '#1f2b43' //"#2E3350"
        radius: bgRadius - 3
    }

}
