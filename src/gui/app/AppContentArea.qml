import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "sidebar"
import "pages"

Control {
    id: idAppContentArea
    anchors.fill: parent

    padding: spacingPanel

    contentItem: RowLayout {
        id: contentLayout
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
