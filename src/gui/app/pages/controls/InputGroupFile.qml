import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs


Control {
    id: idInputGroupFile

    property string nameField: ""
    property string placeholderText: qsTr("Enter file path...")
    property bool selectFile: false
    property bool selectFolder: true

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

            phText: idInputGroupFile.placeholderText
            onEditingFinished: inputText = idTextInput.text
        }

        ButtonFileOpen {
            id: idBtnFileOpen
            hoverEnabled: idInputGroupFile.enabled
            sourceImg: "../../../icons/folder.svg"

            onClicked: windowDialog.open()
        }

        FileDialog {
            id: windowDialog
            currentFolder: StandardPaths.standardLocations(StandardPaths.LocateFile)[0]
            onAccepted: {
                idTextInput.text = selectedFile.toString().replace("file:///", "");
                inputText = selectedFile.toString().replace("file:///", "");
            }
        }
    }
}
