import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idCustomDialogBtn
    height: 50

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
                    rightMargin: true
                }
            }

            delegate: Button {
                id: idBtnDlgPage

                Layout.rightMargin: {
                    if (model.rightMargin) {
                        return commonSettingPage.leftRightMargin
                    }
                    return true
                }

                contentItem: Text {
                    text: qsTr(model.name)

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: commonSettingPage.dynamicColor(
                               idBtnDlgPage,
                               commonSettingPage.dlgColorDef,
                               commonSettingPage.dlgColorMouseOver,
                               commonSettingPage.dlgColorPressed
                    )

                    implicitHeight: 30
                    implicitWidth: 80
                    radius: 10
                }

                onClicked: {
                    switch (model.name) {
                    case "Cancel":
                        console.log(urlPage)

                    case "Apply":
                        console.log(urlPage)
                    }

                    // console.log(model.name)
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
