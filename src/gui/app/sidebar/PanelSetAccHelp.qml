import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSetAccHelp

    contentItem: ColumnLayout {
        spacing: 5    

        Button {
            id: idBtnAccount
            hoverEnabled: false

            Layout.fillWidth: true

            leftPadding: panelSett.lrMargin + 3
            contentItem: RowLayout {
                spacing: 10

                ColorImage {
                    source: "../../icons/user.svg"
                    color: panelSett.colorImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: panelSett.shapeImg
                    sourceSize.height: panelSett.shapeImg
                }

                Label {
                    Layout.fillWidth: true

                    color: panelSett.colorText
                    text: "Account"
                    opacity: opacityLblP

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }
            }

            background: Rectangle {
                id: bgBtnAccount

                implicitHeight: 20
                implicitWidth: 20

                color: panelSett.bgBtnColor

                Rectangle {
                    color: '#2CEF00'
                    width: 4
                    height: idBtnAccount.height
                }

                border.color: idBtnAccount.down ? panelSett.borderColorPressed : bgBtnAccount.color
                border.width: 1
            }

            onClicked: {
                console.log("Account")
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.topMargin: 50

            height: 2
            color: 'white'
        }

        Button {
            id: idBtnSettings
            hoverEnabled: false

            Layout.fillWidth: true

            leftPadding: panelSett.lrMargin + 3
            contentItem: RowLayout {
                spacing: 10

                ColorImage {
                    source: "../../icons/setting.svg"
                    color: panelSett.colorImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: panelSett.shapeImg
                    sourceSize.height: panelSett.shapeImg
                }

                Label {
                    Layout.fillWidth: true

                    color: panelSett.colorText
                    text: "Settings"
                    opacity: opacityLblP

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }
            }

            background: Rectangle {
                id: bgBtnSettings

                implicitHeight: 20
                implicitWidth: 20

                color: panelSett.bgBtnColor

                Rectangle {
                    color: '#2CEF00'
                    width: 4
                    height: idBtnSettings.height
                }

                border.color: idBtnSettings.down ? panelSett.borderColorPressed : bgBtnSettings.color
                border.width: 1
            }

            onClicked: {
                console.log("Settings")
            }
        }

        Button {
            id: idBtnHelp
            hoverEnabled: false

            Layout.fillWidth: true

            leftPadding: panelSett.lrMargin + 3
            contentItem: RowLayout {
                spacing: 10

                ColorImage {
                    source: "../../icons/help.svg"
                    color: panelSett.colorImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: panelSett.shapeImg
                    sourceSize.height: panelSett.shapeImg
                }

                Label {
                    Layout.fillWidth: true

                    color: panelSett.colorText
                    text: "Help"
                    opacity: opacityLblP

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }
            }

            background: Rectangle {
                id: bgBtnHelp

                implicitHeight: 30
                implicitWidth: 30

                color: panelSett.bgBtnColor
                visible: true

                Rectangle {
                    color: '#2CEF00'
                    width: 4
                    height: idBtnHelp.height
                }

                border.color: idBtnHelp.down ? panelSett.borderColorPressed : bgBtnHelp.color
                border.width: 1
            }

            onClicked: {
                console.log("Help")
                // bgBtnHelp.visible = true
            }
        }
    }
}
