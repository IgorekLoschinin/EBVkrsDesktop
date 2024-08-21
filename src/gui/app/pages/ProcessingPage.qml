import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "../controls"


Page {
    id: idPageProcessing
    anchors.fill: parent

    // header: Control {
    //     id: idHeaderPage

    //     contentItem: RowLayout {
    //         Layout.fillWidth: true

    //         Button {Layout.alignment: Qt.AlignCenter}
    //         Button {Layout.alignment: Qt.AlignCenter}
    //     }

    //     background: Rectangle {
    //         color: "plum"
    //         topLeftRadius: bgRadius
    //         topRightRadius: bgRadius
    //     }
    // }

    // contentData: GroupBox {
    //     id: idContentPage
    //     anchors.fill: parent
    //     // label: CheckBox {
    //     //     id: checkBox
    //     //     checked: true
    //     //     text: qsTr("Synchronize")
    //     // }

    //     ColumnLayout {
    //         anchors.fill: parent
    //         CheckBox { text: qsTr("E-mail")}
    //         CheckBox { text: qsTr("Calendar") }
    //         CheckBox { text: qsTr("Contacts") }
    //     }

    //     // background: Rectangle {
    //     //     color: "green"
    //     // }
    // }



    footer: CstmDialogBtnPage{
        id: idCustomDialogBtn
    }

    // Background page
    background: Rectangle {
        color: "#2E3350"
        radius: bgRadius
    }

}
