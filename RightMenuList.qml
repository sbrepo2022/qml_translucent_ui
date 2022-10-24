import QtQuick 2.0

Item {
    id: mainModelElement
    property ListModel list_model
    signal currentIndexChanged(int elem_index)

    function setActiveElement(elem) {
        for (var i = 0; i < list_model.count; i++) {
            if (i !== elem) list_model.get(i).status = "unchecked";
        }
        list_model.get(elem).status = "checked";
    }

    Component {
        id: menu_delegate
        MenuButton {
            width: parent.width
            height: width
            buttonRadius: 50

            imageSource: icon
            state: status

            onClicked: {
                setActiveElement(index);
                mainModelElement.currentIndexChanged(index);
            }
        }
    }

    ListView {
        id: list_view
        anchors.fill: parent
        model: list_model
        delegate: menu_delegate
    }
}

