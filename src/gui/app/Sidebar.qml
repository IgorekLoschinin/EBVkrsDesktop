import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSideBar

    Layout.fillHeight: true
    Layout.preferredWidth: 200 / coefScale  // 69 / 1.4

    property bool checkerOpnCls: true  // Проверка на раскрытие закрытие
    property double opacityLbl: 1

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

    contentItem: MenuPanel {
        id: idMenuPanel
        opacityLblP: opacityLbl
    }

    background: Rectangle {
        color: "#3e485c"
        radius: bgRadius
    }

    NumberAnimation on Layout.preferredWidth {
        id: idPanelCloseAnim
        running: false
        from: 200 / coefScale
        to: 69 / 1.4
        duration: 700

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

    NumberAnimation on Layout.preferredWidth {
        id: idPanelOpenAnim
        running: false
        from: idPanelCloseAnim.to
        to: idPanelCloseAnim.from
        duration: 700

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

    NumberAnimation on opacityLbl {
        id: idHideLbl
        running: false
        from: 1
        to: 0
        duration: 800

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

    NumberAnimation on opacityLbl {
        id: idShowLbl
        running: false
        from: idHideLbl.to
        to: idHideLbl.from
        duration: 800

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

}
