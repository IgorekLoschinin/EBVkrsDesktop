import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idSideBar

    // Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredWidth: 200 / coefScale

    contentItem: Rectangle {
        id: customDrawer

        // width: parent.width * 0.5
        // height: parent.height

        color: "#D9D9D9"
        radius: bgRadius
        opacity: opacityPanels + 0.15

        // Кнопка для открытия и закрытия шторки
        Button {
            id: toggleButton
            // anchors.centerIn: parent

            Layout.fillWidth: true
            Layout.fillHeight: true

            contentItem: Label {
                text: customDrawer.state === "opened" ? "Close Drawer" : "Open Drawer"
                anchors.centerIn: parent
            }

            background: Rectangle {
                // anchors.fill: parent
                color: "plum"
                radius: bgRadius
            }

            onClicked: {
                if (customDrawer.state === "opened") {
                    customDrawer.closeDrawer()
                } else {
                    customDrawer.openDrawer()
                }
            }
        }

        // Управление состояниями шторки
        state: "opened"

        states: [
            State {
                name: "opened"
                PropertyChanges {
                    target: customDrawer;
                    x: parent.width - customDrawer.width

                }
            },

            State {
                name: "closed"
                PropertyChanges {
                    target: customDrawer;
                    x: parent.width - 20
                }
            }
        ]

        transitions: Transition {
            from: "closed"
            to: "opened"
            reversible: true
            NumberAnimation {
                target: customDrawer;
                property: "x";
                duration: 300
            }
        }

        function openDrawer() {
            state = "opened"
        }

        function closeDrawer() {
            state = "closed"
        }


    }
}
