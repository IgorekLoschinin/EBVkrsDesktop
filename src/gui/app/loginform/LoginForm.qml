import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Timeline

import "components"


Control {
    id: idLogingApp
    width: 380
    height: 580

    x: parent.width/2 - width/2
    y: parent.height/2 - height/2

    property bool unlockApp: false

    // Internal Functions
    QtObject{
        id: internal

        function checkLogin(username, password){
            if (username === "belplem" && password === "123") {
                idLogingApp.visible = false
                idMainContent.visible = true
            } else {
                if (username !== "belplem") {
                    errorUsername.visible = true

                } else {
                    errorUsername.visible = false
                }

                if (password !== "123") {
                    errorPassword.visible = true
                } else {
                    errorPassword.visible = false
                }
            }


        }
    }

    background: Rectangle {
        radius: 10
        color: "#0A1832"
    }

    contentItem: ColumnLayout {
        id: idContent

        CustomButton {
            id: btnClose

            Layout.topMargin: 15
            Layout.rightMargin: 15
            Layout.alignment: Qt.AlignRight

            nameBtn: "X"
            fontPointSize: 10

            colorPressed: "#558b1f"
            colorMouseOver: "#7ece2d"
            colorDefault: "#67aa25"

            onClicked: close()
        }

        ColorImage {
            id: logoImage
            color: "#7ece2d"

            Layout.fillWidth: true
            Layout.topMargin: 30
            Layout.bottomMargin: 100
            Layout.alignment: Qt.AlignTop

            source: "../../icons/logo_app.png"
            sourceSize.width: 40
            sourceSize.height: 90
            fillMode: Image.PreserveAspectFit
        }

        ColumnLayout {
            id: idLayoutInput
            spacing: 5

            Layout.fillWidth: true
            Layout.bottomMargin: 40
            Layout.alignment: Qt.AlignCenter

            Label {
                id: label1
                Layout.alignment: Qt.AlignCenter

                color: "#ffffff"
                text: qsTr("Sign in to KRS estiamtion")
                font.family: "Segoe UI"
                font.pointSize: 11
            }

            Label {
                id: label2
                Layout.bottomMargin: 15
                Layout.alignment: Qt.AlignCenter

                color: "#ffffff"
                text: qsTr("Username and password")
                font.family: "Segoe UI"
                font.pointSize: 10
            }

            CustomTextField {
                id: textUsername
                Layout.alignment: Qt.AlignCenter

                placeholderText: "Username"
            }

            Label {
                id: errorUsername
                Layout.leftMargin: 10
                visible: false

                color: "red"
                text: qsTr("username incorrect")
                font.family: "Segoe UI"
                font.pointSize: 9
            }

            CustomTextField {
                id: textPassword
                Layout.alignment: Qt.AlignCenter

                placeholderText: "Password"
                echoMode: TextInput.Password
            }

            Label {
                id: errorPassword
                Layout.leftMargin: 10
                visible: false

                color: "red"
                text: qsTr("password incorrect")
                font.family: "Segoe UI"
                font.pointSize: 9
            }

            CustomButton {
                id: btnLogin
                Layout.alignment: Qt.AlignCenter

                implicitWidth: textUsername.implicitWidth
                implicitHeight: textUsername.implicitHeight

                nameBtn: "Sign in"
                fontPointSize: 11

                colorPressed: "#558b1f"
                colorMouseOver: "#7ece2d"
                colorDefault: "#67aa25"

                onClicked: internal.checkLogin(textUsername.text, textPassword.text)
            }
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                duration: 500
                running: true
                loops: 1
                to: 3000
                from: 0
            }
        ]
        enabled: true
        startFrame: 0
        endFrame: 3000

        KeyframeGroup {
            target: logoImage
            property: "opacity"
            Keyframe {
                frame: 1801
                value: 0
            }

            Keyframe {
                frame: 2300
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: label2
            property: "opacity"
            Keyframe {
                frame: 1899
                value: 0
            }

            Keyframe {
                frame: 2396
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: label1
            property: "opacity"
            Keyframe {
                frame: 1996
                value: 0
            }

            Keyframe {
                frame: 2504
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: textUsername
            property: "opacity"
            Keyframe {
                frame: 2097
                value: 0
            }

            Keyframe {
                frame: 2652
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: textPassword
            property: "opacity"
            Keyframe {
                frame: 2198
                value: 0
            }

            Keyframe {
                frame: 2796
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: btnLogin
            property: "opacity"
            Keyframe {
                frame: 2298
                value: 0
            }

            Keyframe {
                frame: 2951
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        // KeyframeGroup {
        //     target: idLogingApp
        //     property: "height"
        //     Keyframe {
        //         frame: 1301
        //         value: 360
        //     }

        //     Keyframe {
        //         easing.bezierCurve: [0.221,-0.00103,0.222,0.997,1,1]
        //         frame: 1899
        //         value: 560
        //     }

        //     Keyframe {
        //         frame: 0
        //         value: 360
        //     }
        // }
    }

}
