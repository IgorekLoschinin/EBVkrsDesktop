import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSideBar

    Layout.fillHeight: true
    Layout.preferredWidth: 200 / coefScale  // 69 / 1.4

    property bool checkerOpnCls: true  // Проверка на раскрытие закрытие

    contentItem: MenuPanel { id: idMenuPanel }


    // // Кнопка для открытия и закрытия шторки
    // Button {
    //     id: toggleButton

    //     Layout.fillWidth: true
    //     Layout.fillHeight: true

    //     contentItem: Label {
    //         text: "Drawer"
    //         anchors.centerIn: parent
    //     }

    //     background: Rectangle {
    //         color: "plum"
    //         radius: bgRadius
    //     }

    //     onClicked: {

    //         if (idSideBar.checker) {
    //             anim1.running = true
    //             idSideBar.checker = false
    //         } else {
    //             anim2.running = true
    //             idSideBar.checker = true
    //         }
    //     }

    // }


    // NumberAnimation on width {
    //     id: anim1
    //     running: false
    //     from: 200 / coefScale
    //     to: 69 / 1.4
    //     duration: 300
    // }

    // NumberAnimation on width {
    //     id: anim2
    //     running: false
    //     from: anim1.to
    //     to: anim1.from
    //     duration: 300
    // }


    // Item {
    //      id: container
    //      width: 300; height: 300

    //     Row {
    //         spacing: 10

    //      Rectangle {
    //          id: rect0
    //          width: 100; height: 100
    //          color: "red"

    //          MouseArea {
    //             id: mouseArea0
    //             anchors.fill: parent
    //          }
    //      }

    //      Rectangle {
    //          id: rect
    //          width: 100; height: 100
    //          color: "red"

    //          MouseArea {
    //             id: mouseArea
    //             anchors.fill: parent
    //          }

    //      }
    //      }


    //     states: [
    //         State {
    //            name: "resized"
    //            // when: mouseArea0.clicked
    //            PropertyChanges {
    //                rect0 {
    //                    // color: "blue"
    //                    height: container.height
    //                    width: container.width
    //                }
    //            }
    //         },

    //         State {
    //            // name: "resized"
    //            when: mouseArea.pressed
    //            PropertyChanges {
    //                rect {
    //                    // color: "blue"
    //                    height: container.height
    //                    width: container.width
    //                }
    //            }
    //         }
    //     ]

    //     transitions: Transition {
    //         // from: 100
    //         // to: 300

    //         NumberAnimation {
    //             targets: [rect0, rect]
    //             properties: "height, width"
    //             duration: 500
    //             easing.type: Easing.InOutQuad
    //         }

    //     }
    //  }

}
