import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "controls"


Control {
    id: tabInVar

    readonly property var modFtVar: modelFeatureVar

    contentItem: ColumnLayout {

        // Header table
        RowLayout {
            spacing: 10
            Item {
                Layout.fillWidth: true
            }

            Item {
                implicitWidth: 40
            }

            Control {
                implicitWidth: 80
                contentItem: Label {
                    text: "VarE"
                    color: "plum"
                }

            }

            Control {
                implicitWidth: 80
                contentItem: Label {
                    text: "VarG"
                    color: "plum"
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        RowLayout {
            Item {
                Layout.fillWidth: true
            }

            ListView {
                id: listInputVar
                clip: true
                spacing: 10

                implicitHeight: 200
                implicitWidth: 300

                model: ListModel {
                    id: modelFeatureVar
                }

                delegate: RowLayout {
                    spacing: 10

                    Control {
                        implicitWidth: 40
                        contentItem: Label {
                            text: name
                            color: "plum"
                        }
                    }

                    CustormTextField {
                        id: idInVarE
                        Layout.fillWidth: true
                        implicitWidth: 80

                        phText: varE

                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onEditingFinished: {
                            modelFeatureVar.set(
                                index,
                                {"varE": idInVarE.text}
                            )
                        }
                    }

                    CustormTextField {
                        id: idInVarG
                        Layout.fillWidth: true
                        implicitWidth: 80

                        phText: varG

                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onEditingFinished: {
                            modelFeatureVar.set(
                                index,
                                {"varG": idInVarG.text}
                            )
                        }
                    }
                }

                Component.onCompleted: {
                    // Сюда с бэкенда отправляется список признаков
                    var featureNames = ["tip", "kt", "rost", "gt", "pz"];

                    for (var i = 0; i < featureNames.length; i++) {
                        modelFeatureVar.append({
                            index: i,
                            name: featureNames[i],
                            varE: "0",
                            varG: "0"
                        });
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }

    background: Rectangle {
        color: "transparent"
        border.color: "plum"
    }


}
