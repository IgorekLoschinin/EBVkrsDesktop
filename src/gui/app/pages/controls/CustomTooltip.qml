import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolTip {
    id: control
    text: qsTr("A descriptive tool tip of what the button does")


    contentItem: Text {
        text: control.text
        font: control.font
        color: "#21be2b"
    }

    background: Rectangle {
        border.color: "#21be2b"
    }
}

// Item {
//     id: root
//     width: 200
//     height: 100

//     Rectangle {
//         id: button
//         width: 100
//         height: 50
//         color: "#0078D7"
//         radius: 8
//         anchors.centerIn: parent

//         Text {
//             anchors.centerIn: parent
//             text: "Hover me"
//             color: "#ffffff"
//         }

//         MouseArea {
//             id: buttonArea
//             anchors.fill: parent
//             hoverEnabled: true

//             onEntered: {
//                 root.showTooltip()
//             }
//             onExited: {
//                 root.hideTooltip()
//             }
//         }
//     }

//     Rectangle {
//         id: tooltip
//         width: 150
//         height: implicitHeight
//         color: "#333333"
//         radius: 8
//         visible: false
//         opacity: 0.0
//         anchors.horizontalCenter: button.horizontalCenter
//         y: button.y + button.height + 10
//         z: 10

//         Behavior on opacity {
//             NumberAnimation {
//                 duration: 300
//             }
//         }

//         Label {
//             id: tooltipLabel
//             text: "This is a tooltip"
//             color: "#ffffff"
//             wrapMode: Text.Wrap
//             padding: 10
//             horizontalAlignment: Text.AlignHCenter
//             verticalAlignment: Text.AlignVCenter
//         }

//         SequentialAnimation {
//             id: appearAnimation
//             running: false

//             PropertyAction {
//                 target: tooltip
//                 property: "visible"
//                 value: true
//             }

//             ParallelAnimation {
//                 NumberAnimation {
//                     target: tooltip
//                     property: "opacity"
//                     from: 0.0
//                     to: 1.0
//                     duration: 300
//                 }

//                 NumberAnimation {
//                     target: tooltip
//                     property: "y"
//                     from: button.y + button.height + 10
//                     to: button.y + button.height
//                     duration: 300
//                 }
//             }
//         }

//         SequentialAnimation {
//             id: disappearAnimation
//             running: false

//             ParallelAnimation {
//                 NumberAnimation {
//                     target: tooltip
//                     property: "opacity"
//                     from: 1.0
//                     to: 0.0
//                     duration: 300
//                 }

//                 NumberAnimation {
//                     target: tooltip
//                     property: "y"
//                     from: button.y + button.height
//                     to: button.y + button.height + 10
//                     duration: 300
//                 }
//             }

//             PropertyAction {
//                 target: tooltip
//                 property: "visible"
//                 value: false
//             }
//         }
//     }

//     function showTooltip() {
//         appearAnimation.start()
//     }

//     function hideTooltip() {
//         disappearAnimation.start()
//     }
// }
