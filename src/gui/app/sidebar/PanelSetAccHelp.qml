import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSetAccHelp

    contentItem: ColumnLayout {
        spacing: 5

        Rectangle {
            Layout.fillWidth: true

            Layout.topMargin: 50
            Layout.leftMargin: panelSett.lrMargin
            Layout.rightMargin: panelSett.lrMargin

            height: 2
            color: '#ffffff'
        }

        CustomBtnSb {
            id: idBtnSettings
            Layout.fillWidth: true

            nameBtn: qsTr("Settings")
            sourceImg: "qrc:/icons/setting.svg"

            sideLightBtn: activityLightBtn(nameBtn)
            bgTargetColor: activityTargetBtn(idBtnSettings, nameBtn)

            onClicked: {
                idSideBar.activeButton = nameBtn
                idContent.currentIndex = 8
            }
        }

        CustomBtnSb {
            id: idBtnHelp
            Layout.fillWidth: true

            nameBtn: qsTr("Help")
            sourceImg: "qrc:/icons/help.svg"

            sideLightBtn: activityLightBtn(nameBtn)
            bgTargetColor: activityTargetBtn(idBtnHelp, nameBtn)

            onClicked: idSideBar.activeButton = nameBtn
        }

    }
}
