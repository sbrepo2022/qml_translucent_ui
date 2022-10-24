import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: list_item
    signal setBackgroundImage(string name)
    color: "#00000000"

    ListModel {
        id: images_list
        ListElement {
            status: "checked"
            imgSource: "background.jpg"
        }
        ListElement {
            status: "unchecked"
            imgSource: "background2.jpg"
        }
        ListElement {
            status: "unchecked"
            imgSource: "background3.jpg"
        }
        ListElement {
            status: "unchecked"
            imgSource: "background4.jpg"
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: backgroundChoosePage

        Component {
            id: notesPage
            Item {
                anchors.fill: parent
            }
        }

        Component {
            id: backgroundChoosePage
            BackgroundPage {
                anchors.fill: parent
                list_model: images_list

                onSetBackgroundImage: {
                    list_item.setBackgroundImage(name)
                }
            }
        }
    }
}
