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
        spacing: spacingPanel

        Sidebar { id: idSideBar }

        ColumnLayout {
            spacing: spacingPanel
            clip: true

            TopBar { id: idTopBar }
            PageContent { id: idContent }
            BottomBar { id: idBottomBar }
        }
    }

    Component {
        id: compHomePage

        HomePage {}
    }

    // Component {
    //     id: compProcPage

    //     ProcessingPage {}
    // }

    // Component {
    //     id: compProcPhenPage

    //     ProcPhenoPage {}
    // }

    // Component {
    //     id: compProcSnpPage

    //     ProcSnpPage {}
    // }

    // Component {
    //     id: compEstPage

    //     EstimationPage {}
    // }

    // Component {
    //     id: compIndPage

    //     IndexingPage {}
    // }

    // Component {
    //     id: compPlPage

    //     PipelinePage {}
    // }

    // Component {
    //     id: compModlPage

    //     ModelingPage {}
    // }
}
