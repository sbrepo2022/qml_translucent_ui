import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property int buttonRadius: 0
    property string imageSource: ""
    signal clicked

    id: menu_button
    color: "#00000000"
    state: "unchecked"

    Rectangle {
        id: circle1
        color: "#f5f5dc"
        anchors.centerIn: parent

        layer.enabled: true
        layer.effect: DropShadow {
            id: d_shadow
            anchors.fill: circle1
            source: circle1
            radius: 16
            samples: 32
            //verticalOffset: 4
            color: "#a0000000"
        }
    }

    Rectangle {
        id: circle2
        color: "#e0c677"
        anchors.centerIn: parent
    }

    Rectangle {
        property int animationDuration: 300

        id: inner_element
        color: "#00000000"
        anchors.centerIn: parent
        width: parent.buttonRadius
        height: width

        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: menu_button.imageSource
            smooth: true
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                //menu_button.state = (menu_button.state === "unchecked" ? "checked" : "unchecked");
                //menu_button.state === "unchecked" ? menu_button.unchecked() : menu_button.checked();
                menu_button.clicked()
            }
        }
    }

    states: [
        State {
            name: "unchecked"
            PropertyChanges {
                target: circle1
                width: inner_element.width - 2
                height: inner_element.height - 2
                radius: (inner_element.width - 2) / 2
            }
            PropertyChanges {
                target: circle2
                width: inner_element.width - 2
                height: inner_element.height - 2
                radius: (inner_element.width - 2) / 2
            }
        },
        State {
            name: "checked"
            PropertyChanges {
                target: circle1
                width: inner_element.width * 1.4
                height: inner_element.height * 1.4
                radius: inner_element.width * 1.4 / 2
            }
            PropertyChanges {
                target: circle2
                width: inner_element.width * 1.2
                height: inner_element.height * 1.2
                radius: inner_element.width * 1.2 / 2
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation {
                target: circle1
                properties: "width, height, radius"
                easing.type: Easing.InOutExpo
                duration: inner_element.animationDuration
            }
            PropertyAnimation {
                target: circle2
                properties: "width, height, radius"
                easing.type: Easing.InOutExpo
                duration: inner_element.animationDuration
            }
        }
    ]
}

