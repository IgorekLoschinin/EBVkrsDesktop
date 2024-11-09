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

            Control {
                Layout.leftMargin: 73

                implicitWidth: 80
                contentItem: Label {
                    text: "VarE"
                    color: "plum"

                    leftPadding: 13
                }
            }

            Control {
                implicitWidth: 80
                contentItem: Label {
                    text: "VarG"
                    color: "plum"

                    leftPadding: 13
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        // Body - row and col
        RowLayout {
            Item {
                Layout.fillWidth: true
            }

            ListView {
                id: listInputVar
                clip: true
                spacing: 10

                implicitHeight: 250
                implicitWidth: 300

                model: ListModel {
                    id: modelFeatureVar
                }

                delegate: RowLayout {
                    spacing: 10

                    Control {
                        implicitWidth: 80
                        contentItem: Label {
                            text: name
                            color: "plum"

                            horizontalAlignment: Qt.AlignRight
                        }
                    }

                    CustormTextField {
                        id: idInVarE
                        Layout.fillWidth: true
                        implicitWidth: 80

                        phText: "0"

                        onEditingFinished: {
                            if (idInVarE.text.length) {
                                modelFeatureVar.set(
                                    index,
                                    {"varE": idInVarE.text}
                                )
                                return
                            }
                        }

                        validator: DoubleValidator {}
                    }

                    CustormTextField {
                        id: idInVarG
                        Layout.fillWidth: true
                        implicitWidth: 80

                        phText: "0"

                        onEditingFinished: {
                            if (idInVarG.text.length) {
                                modelFeatureVar.set(
                                    index,
                                    {"varG": idInVarG.text}
                                )
                                return
                            }
                        }

                        validator: DoubleValidator {}
                    }
                }

                Component.onCompleted: {
                    // Сюда с бэкенда отправляется список признаков
                    var featureNames = ["tip", "kt", "rost", "gt", "pz", "conform",
                                        "1tip", "1kt", "1rost", "1gt", "1pz", "1conform",
                                        "2tip", "2kt", "2rost", "2gt", "2pz", "2conform"];

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
}
