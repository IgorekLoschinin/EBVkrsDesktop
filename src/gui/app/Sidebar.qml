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
            anim1.running = true
            anim3.running = true
            idSideBar.checkerOpnCls = false

        } else {
            anim2.running = true
            anim4.running = true
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
        id: anim1
        running: false
        from: 200 / coefScale
        to: 69 / 1.4
        duration: 800

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

    NumberAnimation on Layout.preferredWidth {
        id: anim2
        running: false
        from: anim1.to
        to: anim1.from
        duration: 800

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

    NumberAnimation on opacityLbl {
        id: anim3
        running: false
        from: 1
        to: 0
        duration: 800

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

    NumberAnimation on opacityLbl {
        id: anim4
        running: false
        from: anim3.to
        to: anim3.from
        duration: 800

        easing.type: Easing.InOutElastic
        easing.amplitude: 2.0;
        easing.period: 5
    }

}
