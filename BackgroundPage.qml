import QtQuick 2.0

Item {
    id: mainElement
    property ListModel list_model
    signal setBackgroundImage(string name)

    function setActiveElement(elem) {
        for (var i = 0; i < list_model.count; i++) {
            if (i !== elem) list_model.get(i).status = "unchecked";
        }
        list_model.get(elem).status = "checked";
    }

    Component {
        id: image_delegate

        ImageChooseElement {
            id: img_choose_element

            width: parent.width
            height: width / 16 * 9 + imgStatusHeight * 2 + imgTitleHeight
            imgWidth: parent.width / 4 * 3
            imgHeight: imgWidth / 16 * 9
            imgStatusHeight: 20
            imgTitleHeight: 20
            imgRadiusHeight: 10
            imageSource: imgSource
            animState: status

            onClicked: {
                setActiveElement(index);
                mainElement.setBackgroundImage(imgSource)
            }
        }
    }

    ListView {
        id: list_view
        anchors.fill: parent
        model: list_model
        delegate: image_delegate
    }
}
