import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSideBar

    QtObject {
        id: panelSett

        property int tbMargin: 10
        property int lrMargin: 8

        property int shapeImg: 25
        property color colorImg: "#F5EDED"

        property bool visibleText: true
        property color colorText: "#FFFAFA"

        property color bgBtnColor: "#5d6575"
        property color borderColorPressed: "#B3C4E0"
    }

    property double sizeCloseSB: 49
    property double sizeOpenSb: 167

    property bool checkerOpnCls: true  // Проверка на раскрытие закрытие

    property double opacityLblP: 1

    Layout.fillHeight: true
    Layout.preferredWidth: sizeOpenSb    


    function sidingMenu () {

        if (idSideBar.checkerOpnCls) {
            idPanelCloseAnim.running = true
            idHideLbl.running = true

            idSideBar.checkerOpnCls = false

        } else {
            idPanelOpenAnim.running = true
            idShowLbl.running = true

            idSideBar.checkerOpnCls = true
        }

    }

    contentItem: ColumnLayout {

        // Button for expanding menu
        MenuExpanding {
            id: idExpandMenu

            Layout.fillWidth: parent.width
            Layout.preferredHeight: 40

            Layout.alignment: Qt.AlignTop
            Layout.topMargin: panelSett.tbMargin
            Layout.leftMargin: panelSett.lrMargin
            Layout.rightMargin: panelSett.lrMargin
        }

        // Panel with modeling processing methods
        ScrollView {
            id: flickableContent

            Layout.fillWidth: parent.width
            Layout.preferredHeight: 223

            contentData: PanelProcMethods {
                id: idAreaProcMethods

                width: flickableContent.width
            }
        }

        // Panel with settings, logging and help
        PanelSetAccHelp {
            id: idSetAccHelp

            Layout.fillWidth: true
            Layout.preferredHeight: 166

            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: panelSett.tbMargin + 20

        }

    }

    background: Rectangle {
        color: "#3e485c"
        radius: bgRadius
    }

    NumberAnimation on Layout.preferredWidth {
        id: idPanelCloseAnim
        running: false
        from: sizeOpenSb
        to: sizeCloseSB
        duration: 700

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0
        easing.period: 5
    }

    NumberAnimation on Layout.preferredWidth {
        id: idPanelOpenAnim
        running: false
        from: idPanelCloseAnim.to
        to: idPanelCloseAnim.from
        duration: 700

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0
        easing.period: 5
    }

    NumberAnimation on opacityLblP {
        id: idHideLbl
        running: false
        from: 1
        to: 0
        duration: 700

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

    NumberAnimation on opacityLblP {
        id: idShowLbl
        running: false
        from: idHideLbl.to
        to: idHideLbl.from
        duration: 700

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

}
