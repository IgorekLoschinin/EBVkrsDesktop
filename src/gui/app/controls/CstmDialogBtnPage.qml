import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idCustomDialogBtn
    height: 50

    QtObject {
        id: idSettingDlgBtn
        // DYNAMIC COLOR
        property color colorDef: "#FABE39"
        property color colorMouseOver: "#CFAF68"  // 4891d9
        property color colorPressed: "#C79831"

        function dynamicColor (idBtn) {
            if (idBtn.down) {
                return colorPressed
            } else {
                if (idBtn.hovered) {
                    return colorMouseOver
                }
            }

            return colorDef
        }
    }

    contentItem: RowLayout {
        spacing: 3

        Layout.fillWidth: true
        Layout.fillHeight: true

        Item { Layout.fillWidth: true }
        Repeater {
            model: ListModel {
                ListElement {
                    name: qsTr("Apply")
                }
                ListElement {
                    name: qsTr("Cancel")
                    rightMargin: 15
                }
            }

            delegate: Button {
                id: idBtnDlgPage

                Layout.rightMargin: {
                    if (model.rightMargin) {
                        return 15
                    }
                    return true
                }

                contentItem: Text {
                    text: qsTr(model.name)

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: idSettingDlgBtn.dynamicColor(idBtnDlgPage)

                    implicitHeight: 30
                    implicitWidth: 80
                    radius: 10
                }

                onClicked: {
                    console.log(model.name)
                }
            }
        }
    }

    background: Rectangle {
        color: "transparent"
        bottomLeftRadius: bgRadius
        bottomRightRadius: bgRadius
    }
}
