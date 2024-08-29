import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs


Control {
    id: idInputGroup

    property string nameField: ""

    contentItem: RowLayout {
        Layout.fillHeight: true
        Layout.fillWidth: true

        Text {
            text: qsTr(nameField)
            font.pixelSize: sizeTextInSect
            color: txtSection

            clip: true
            // Layout.fillWidth: true
            wrapMode: Text.WordWrap
        }

        TextField {
            id: idTextInput
            placeholderText: qsTr("path to dir")
            font.pixelSize: sizeTextInSect

            implicitHeight: 22

            Layout.fillWidth: true
        }

        Button {
            id: idBtnBrowser
            text: qsTr("browser")
            onClicked: fileDialog.open()

            implicitHeight: 22
        }

        FileDialog {
            id: fileDialog
            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
            onAccepted: idTextInput.text = selectedFile
        }
    }
}
