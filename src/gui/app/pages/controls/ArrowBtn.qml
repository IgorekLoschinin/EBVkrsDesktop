import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: idBtnArrow

    property string arrSourceImg: ""

    contentItem: ColorImage {
        source: arrSourceImg
        color: commonSettingPage.arrColorImg

        fillMode: Image.PreserveAspectFit
        sourceSize.height: 20
        sourceSize.width: 20
    }

    background: Rectangle {
        color: commonSettingPage.dynamicColor(
                   idBtnArrow,
                   commonSettingPage.arrColorDef,
                   commonSettingPage.arrColorMouseOver,
                   commonSettingPage.arrColorPressed
        )

        implicitHeight: 20
        implicitWidth: 20
        radius: 10
    }
}
