import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Control {
    id: idAppContentArea
    anchors.fill: parent

    padding: spacingPanel

    contentItem: RowLayout {
        id: contentLayout
        spacing: spacingPanel        

        Sidebar { id: idSideBar }

        ColumnLayout {
            spacing: spacingPanel

            TopBar { id: idTopBar }
            PageContent { id: idContent }
            BottomBar { id: idBottomBar }
        }
    }
}
