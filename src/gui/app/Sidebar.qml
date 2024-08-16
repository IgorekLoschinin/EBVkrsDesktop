import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSideBar    

    property double sizeCloseSB: 69 / 1.4
    property double sizeOpenSb: 200 / coefScale
    property bool checkerOpnCls: true  // Проверка на раскрытие закрытие
    property double opacityLbl: 1

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
