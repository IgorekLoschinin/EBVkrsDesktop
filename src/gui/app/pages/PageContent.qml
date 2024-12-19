import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

StackLayout {
    id: idStackPagesCont

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 763

    currentIndex: 0

    Repeater {
        model: [
            compHomePage,
            compProcPage,
            compProcPhenPage,
            compProcSnpPage,
            compEstPage,
            compIndPage,
            compPlPage,
            compModlPage
        ]

        delegate: Loader {
            sourceComponent: modelData
        }
    }

    Component {
        id: compHomePage

        HomePage {}
    }

    Component {
        id: compProcPage

        ProcessingPage {}
    }

    Component {
        id: compProcPhenPage

        ProcPhenoPage {}
    }

    Component {
        id: compProcSnpPage

        ProcSnpPage {}
    }

    Component {
        id: compEstPage

        EstimationPage {}
    }

    Component {
        id: compIndPage

        IndexingPage {}
    }

    Component {
        id: compPlPage

        PipelinePage {}
    }

    Component {
        id: compModlPage

        ModelingPage {}
    }

    Connections {
        target: backend

        function onRunSig(data) {
            console.log(data)
        }

        function onStopSig(data) {
            console.log(data)
        }
    }

}
