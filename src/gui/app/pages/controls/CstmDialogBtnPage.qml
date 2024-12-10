import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: idCustomDialogBtn
    height: 50

    // Dynamic color dialog button - apply and cancel
    readonly property color dlgColorDef: "transparent"
    readonly property color dlgColorMouseOver: "#CFAF68"
    readonly property color dlgColorPressed: "#C79831"

    function dynamicColor (idBtn, cDef, cMO, cP) {
        if (idBtn.down) {
            return cP
        } else {
            if (idBtn.hovered) {
                return cMO
            }
        }

        return cDef
    }

    contentItem: RowLayout {
        spacing: 3

        Layout.fillWidth: true
        Layout.fillHeight: true

        Item { Layout.fillWidth: true }
        Repeater {
            model: ListModel {
                ListElement {
                    name: qsTr("run")
                    srcImage: "../../../icons/play.svg"
                    colorImg: "green"
                }
                ListElement {
                    name: qsTr("stop")
                    srcImage: "../../../icons/stop.svg"
                    colorImg: "red"
                    rightMargin: true
                }
            }

            delegate: Button {
                id: idBtnDlgPage

                Layout.rightMargin: {
                    if (model.rightMargin) {
                        return leftRightMargin
                    }
                    return true
                }

                contentItem: ColorImage {
                    source: model.srcImage
                    color: model.colorImg

                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: 25
                    sourceSize.width: 25
                }

                background: Rectangle {
                    color: dynamicColor(
                               idBtnDlgPage,
                               dlgColorDef,
                               dlgColorMouseOver,
                               dlgColorPressed
                    )

                    implicitHeight: 30
                    implicitWidth: 30
                    radius: 10
                }

                onClicked: {
                    switch (model.name) {
                    case "run":
                        backend.run(sendForm)
                        return

                    case "stop":
                        backend.stop()
                        return

                    default:
                        return
                    }
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
