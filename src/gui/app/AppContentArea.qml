import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "loginform"
import "sidebar"
import "pages"

Control {
    id: idAppContentArea
    anchors.fill: parent

    padding: spacingPanel

    contentItem: Item {

        LoginForm {
            id: idLoginForm
        }

        RowLayout {
            anchors.fill: parent
            visible: false

            id: idMainContent
            spacing: spacingPanel - 2

            Sidebar { id: idSideBar }

            ColumnLayout {
                spacing: spacingPanel - 2
                clip: true

                TopBar { id: idTopBar }
                PageContent { id: idContent }
                BottomBar { id: idBottomBar }
            }
        }
    }
}
