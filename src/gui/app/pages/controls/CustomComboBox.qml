import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ComboBox {
    id: idCustComboBox

    implicitHeight: 22
    implicitWidth: 110

    readonly property int radius: 4
    readonly property color textColor: "#FFFFFF"
    readonly property color popupBackground: "#333742"
    readonly property color borderColor: "#ffffff"

    property color hoverColor: "#8792A8"
    property color checkedColor: "#8792A8"

    // DYNAMIC COLOR
    function dynamicColor (idBtn) {
        if (idBtn.down) {
            return Qt.darker(idCustComboBox.checkedColor, 1.4)
        } else {
            if (idBtn.hovered) {
                return Qt.darker(idCustComboBox.checkedColor, 1.2)
            }
        }
        return idCustComboBox.checkedColor
    }

    contentItem: Label {
        anchors.fill: parent
        anchors.leftMargin: 10

        opacity: 0.9
        text: idCustComboBox.displayText
        font.pixelSize: 18

        color: idCustComboBox.textColor

        verticalAlignment: Qt.AlignVCenter
    }

    background: Rectangle {
        radius: idCustComboBox.radius
        color: dynamicColor(idCustComboBox)
    }

    delegate: ItemDelegate {
        id: itemDelegate

        focus: true
        hoverEnabled: true

        width: idCustComboBox.implicitWidth
        height: idCustComboBox.implicitHeight

        Label {
            anchors.fill: parent
            anchors.leftMargin: 4

            opacity: 0.9
            text: modelData
            font.family: "Segoe UI"
            font.pixelSize: 18
            color: textColor

            verticalAlignment: Qt.AlignVCenter
        }

        background: Rectangle {
            anchors.fill: parent
            radius: idCustComboBox.radius
            color: itemDelegate.hovered ? hoverColor : "transparent"
        }
    }

    popup: Popup {
        width: idCustComboBox.implicitWidth
        y: idCustComboBox.height + 2

        contentItem: ListView {
            clip: true
            focus: true
            keyNavigationEnabled: true

            implicitHeight: contentHeight

            model: idCustComboBox.popup.visible ? idCustComboBox.delegateModel : null
        }

        background: Rectangle {
            clip: true
            radius: idCustComboBox.radius

            color: idCustComboBox.popupBackground
            border.width: 0.5
            border.color: idCustComboBox.borderColor
        }
    }

}
