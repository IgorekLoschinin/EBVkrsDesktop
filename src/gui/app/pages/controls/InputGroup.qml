import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs


Control {
    id: idInputGroup

    property string nameField: ""
    property string placeholderText: "Enter file path..."

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
            clip: true
            wrapMode: Text.WordWrap
        }

        CustormTextField {
            id: idTextInput
            Layout.fillWidth: true

            phText: idInputGroup.placeholderText
        }

        ButtonFileOpen {
            id: idBtnFileOpen            

            onClicked: fileDialog.open()
        }

        FileDialog {
            id: fileDialog
            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
            onAccepted: idTextInput.text = selectedFile
        }
    }
}
