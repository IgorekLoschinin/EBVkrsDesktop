import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs


Control {
    id: idInputGroupFolder

    property string nameField: ""
    property string placeholderText: qsTr("Enter file path...")

    property string inputText: ''

    contentItem: RowLayout {
        spacing: 2
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter

        Text {
            id: idLblTextField
            Layout.rightMargin: 15

            color: txtSection

            text: qsTr(nameField)
            font.pixelSize: sizeTextInSect
            font.family: "Segoe UI"
            clip: true
            wrapMode: Text.WordWrap
        }

        CustormTextField {
            id: idTextInput
            Layout.fillWidth: true

            phText: idInputGroupFolder.placeholderText
            onEditingFinished: inputText = idTextInput.text
        }

        ButtonFileOpen {
            id: idBtnFileOpen
            hoverEnabled: idInputGroupFolder.enabled
            sourceImg: "qrc:/icons/folder.svg"

            onClicked: windowDialog.open()
        }

        FolderDialog {
            id: windowDialog
            currentFolder: StandardPaths.standardLocations(StandardPaths.LocateDirectory)[0]
            onAccepted: {
                idTextInput.text = rePath(selectedFolder.toString());
                inputText = rePath(selectedFolder.toString());
            }
        }
    }
}
