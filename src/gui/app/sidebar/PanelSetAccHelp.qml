import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSetAccHelp

    contentItem: ColumnLayout {
        spacing: 5

        CustomBtnSb {
            id: idBtnAccount
            Layout.fillWidth: true

            nameBtn: "Account"
            sourceImg: "../../icons/user.svg"
        }

        Rectangle {
            Layout.fillWidth: true

            Layout.topMargin: 50
            Layout.leftMargin: panelSett.lrMargin
            Layout.rightMargin: panelSett.lrMargin

            height: 2
            color: 'white'
        }

        CustomBtnSb {
            id: idBtnSettings
            Layout.fillWidth: true

            nameBtn: "Settings"
            sourceImg: "../../icons/setting.svg"
        }

        CustomBtnSb {
            id: idBtnHelp
            Layout.fillWidth: true

            nameBtn: "Help"
            sourceImg: "../../icons/help.svg"
        }
    }
}
