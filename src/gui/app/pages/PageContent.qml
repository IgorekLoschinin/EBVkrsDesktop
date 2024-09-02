import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

StackView {
    id: idStackPagesCont

    property bool activStartPageBtn: true

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 763

    initialItem: compHomePage

    function newActivity(viewFile, activityModel = null) {

        if (!viewFile || !viewFile.length) {
            console.error("Failed to create activity. view object is invalid");
            return;
        }

        var component = Qt.createComponent(viewFile);

        if (component.status === Component.Ready) {
            var activity = component.createObject(idStackPagesCont);
            if (activity === null) {
                // Error Handling
                console.error("Error creating Activity object");
                return;
            }

            // if (activityModel) {
            //     activity.model = activityModel;
            // }

            push(activity);

            return activity;

        } else if (component.status === Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }

    }

}
