import QtQuick
import QtQuick.Controls

Page {

    contentItem: Rectangle {
        color: '#1f2b43'
        radius: bgRadius
    }

    Label {
        text: "Settings page"
        color: "plum"

        anchors.centerIn: parent

        horizontalAlignment: Qt.AlignHCenter

    }

    MouseArea {
        anchors.fill: parent
        onPressed: { appWindow.startSystemMove() }
    }

    background: Rectangle {
        color: "transparent"
    }
}

// import QtQuick 2.15
// import QtQuick.Controls 2.15

// ApplicationWindow {
//     visible: true
//     width: 640
//     height: 480
//     title: "Пример модального окна с Popup"

//     // Кнопка для вызова модального окна
//     Button {
//         text: "Открыть модальное окно"
//         anchors.centerIn: parent
//         onClicked: myPopup.open()
//     }

//     // Модальное окно
//     Popup {
//         id: myPopup
//         modal: true  // Делаем его модальным
//         width: 300
//         height: 200

//         anchors.centerIn: parent
//         closePolicy: Popup.CloseOnPressOutsideParent

//         Rectangle {
//             anchors.fill: parent
//             color: "white"
//             border.color: "black"

//             Column {
//                 anchors.centerIn: parent
//                 spacing: 10

//                 Text {
//                     text: "Это модальное окно Popup."
//                     horizontalAlignment: Text.AlignHCenter
//                 }

//                 Button {
//                     text: "Закрыть"
//                     onClicked: myPopup.close()
//                 }
//             }
//         }
//     }
// }

