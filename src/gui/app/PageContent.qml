import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "pages"

Control {
    id: idContent

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 763  // 916 / coefScale

    contentItem: StackView {
        initialItem: HomePage {

        }

        // initialItem: ProcessingPage {

        // }

        // initialItem: ProcPhenoPage {

        // }

        // initialItem: ProcSnpPage {

        // }

        // initialItem: EstimationPage {

        // }

        // initialItem: IndexingPage {

        // }

    }
}
