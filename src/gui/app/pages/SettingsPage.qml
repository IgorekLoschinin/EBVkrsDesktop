import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageSettings
    urlPage: qsTr("Settings")

    contentData: Control {
        anchors.fill: parent
        anchors.leftMargin: marginContentD
        anchors.rightMargin: marginContentD

        contentItem: ColumnLayout {
            spacing: comSpacing

            Layout.fillWidth: true
            Layout.fillHeight: true

            // Divining top line
            Rectangle {
                color: 'white'
                height: 1

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                Layout.topMargin: 10
                Layout.bottomMargin: bottomMarginContentSect
            }

            // Language panel
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

                Text {
                    Layout.rightMargin: 3

                    text: qsTr("Language: ")
                    font.pixelSize: sizeTextInSect
                    font.family: "Segoe UI"
                    color: txtSection

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                CustomComboBox {
                    id: idLangPanel

                    Layout.alignment: Qt.AlignHCenter

                    implicitWidth: 90

                    currentIndex: 0
                    model: ["English", "Russian"]
                }
            }

            // Select path to utils *f90.exe
            InputGroupFolder {
                id: idInputUtilf90
                nameField: qsTr("Dir utils *f90.exe:")

                Layout.fillWidth: true
            }

            // Divining bottom line
            Rectangle {
                color: 'white'
                height: 1

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                Layout.topMargin: 10
                Layout.bottomMargin: bottomMarginContentSect
            }

            Item { Layout.fillHeight: true }
        }
    }

    footer: null
}
