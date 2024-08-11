import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idWindowCtrlBtn

    contentItem: Rectangle {

        Row {
            Button {
                id: idBtnRoll
            }

            Button {
                id: idBtnFullSize
            }

            Button {
                id: idBtnClose
            }
        }
    }
}
