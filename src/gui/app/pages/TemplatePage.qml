import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"

Page {
    id: idPage

    property string urlPage: ""

    QtObject {
        id: commonSettingPage

        property int leftRightMargin: 29
        property color sectionColor: "#D9D9D9"
        property color txtSection: "#D1E37D"


        // Dynamic color button arrow
        property color arrColorImg: "#F5EDED"
        property color arrColorDef: "transparent"
        property color arrColorMouseOver: "#8792A8"
        property color arrColorPressed: "#4A515E"

        // Dynamic color dialog button - apply and cancel
        property color dlgColorDef: "#FABE39"
        property color dlgColorMouseOver: "#CFAF68"
        property color dlgColorPressed: "#C79831"

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
    }

    header: Control {
        id: idHeaderPage
        height: 50

        contentItem: RowLayout {
            spacing: 3
            Layout.fillWidth: true
            Layout.fillHeight: true            

            Text {
                text: qsTr(urlPage)
                font.pixelSize: 18
                font.bold: true
                color: "#FFFEF0"

                Layout.fillWidth: true
                Layout.topMargin: 30
                Layout.leftMargin: commonSettingPage.leftRightMargin                

                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "left-arrow"
                        sourceImg: "../../../icons/left-arrow.svg"
                    }
                    ListElement {
                        name: "right-arrow"
                        sourceImg: "../../../icons/right-arrow.svg"
                        rightMargin: true
                    }
                }

                delegate: ArrowBtn {
                    id: idBtnArrow

                    Layout.rightMargin: {
                        if (model.rightMargin) {
                            return commonSettingPage.leftRightMargin
                        }
                        return true
                    }

                    arrSourceImg: model.sourceImg

                    onClicked: {
                        console.log(model.name)
                    }
                }
            }
        }

        background: Rectangle {
            color: "transparent"
            topLeftRadius: bgRadius
            topRightRadius: bgRadius
        }
    }

    footer: CstmDialogBtnPage{
        id: idCustomDialogBtn
    }

    // Background page
    background: Rectangle {
        color: "#2E3350"
        radius: bgRadius
    }

}
