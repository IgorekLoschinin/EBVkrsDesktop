import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


TemplatePage {
    id: idPageSettings
    urlPage: qsTr("Settings")

    property bool changeFlag: false

    sendForm: {
        'id': 'settings',
        'utils_f90': idInputUtilf90.inputText.length === 0 ? backend.get_settings.utils_f90 : idInputUtilf90.inputText,
        'disabletooltip': true
    }

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
                    model: translationManager.languages

                    onCurrentTextChanged: translationManager.load_language(currentText)
                }
            }

            // Select path to utils *f90.exe
            InputGroupFolder {
                id: idInputUtilf90
                nameField: qsTr("Dir utils *f90.exe:")

                Layout.fillWidth: true
                placeholderText: backend.get_settings.utils_f90

                onEnterTextChanges: changeFlag = true
            }

            // Enable  and disable tooltip
            CustomSwitch {
                id: idSwitchSect

                contentItem: Text {
                    leftPadding: idSwitchSect.indicator.width + 6

                    text: qsTr("Disabling tooltips")
                    font.pixelSize: sizeTextInSect
                    font.family: "Segoe UI"
                    color: txtSection

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Item { Layout.fillHeight: true }
        }
    }

    footer: ColumnLayout {
        spacing: 0
        height: 50

        Layout.fillWidth: true
        Layout.fillHeight: true

        Rectangle {
            color: 'white'
            height: 1

            Layout.fillWidth: true
            Layout.leftMargin: marginContentD
            Layout.rightMargin: marginContentD
            Layout.alignment: Qt.AlignTop
        }

        RowLayout {
            Item { Layout.fillWidth: true }
            CustomBtn {
                id: idBtnApply

                Layout.rightMargin: leftRightMargin

                enabled: changeFlag
                hoverEnabled: changeFlag
                opacity: changeFlag ? 1 : 0.5

                dlgColorDef: enabled ? dlgColorPressed : "#5d6575"
                dlgColorMouseOver: "#8792A8"
                dlgColorPressed: "#4A515E"

                contentItem: Text {
                    text: qsTr("Apply")

                    font.family: "Segoe UI"
                    font.pixelSize: 16

                    color: "#ffffff"

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background.implicitWidth: 80

                onClicked: {
                    backend.set_settings(idPageSettings.sendForm)
                    changeFlag = false
                }
            }
        }
    }
}
