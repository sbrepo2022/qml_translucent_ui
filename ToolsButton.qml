import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property int buttonRadius: 0
    property color buttonColor: "#000"
    property color alternateColor: "#000"
    signal checked
    signal unchecked

    id: tools_button
    color: "#00000000"

    Rectangle {
        property int animationDuration: 200

        id: inner_element
        color: buttonColor
        state: "unchecked"

        anchors.centerIn: parent
        width: parent.buttonRadius
        height: width
        radius: width / 2

        layer.enabled: true
        layer.effect: DropShadow {
            id: d_shadow
            anchors.fill: inner_element
            source: inner_element
            radius: 16
            samples: 32
            //verticalOffset: 4
            color: "#a0000000"
        }

        Rectangle {
            id: line1
            color: "#fff"
            radius: parent.height / 30
        }

        Rectangle {
            id: line2
            color: "#fff"
            radius: parent.height / 30
        }

        Rectangle {
            id: line3
            color: "#fff"
            radius: parent.height / 30
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                inner_element.color = alternateColor;
            }
            onExited: {
                inner_element.color = buttonColor;
            }
            onClicked: {
                inner_element.state = (inner_element.state === "unchecked" ? "checked" : "unchecked");
                inner_element.state === "unchecked" ? tools_button.unchecked() : tools_button.checked();
            }
        }

        states: [
            State {
                name: "unchecked"
                PropertyChanges {
                    target: inner_element
                    rotation: 0
                }
                PropertyChanges {
                    target: line1
                    x: parent.width / 4
                    y: parent.height / 3
                    width: parent.width / 2
                    height: parent.height / 15
                    rotation: 0
                }
                PropertyChanges {
                    target: line2
                    x: parent.width / 4
                    y: parent.height / 2 - parent.height / 30
                    width: parent.width / 2
                    height: parent.height / 15
                }
                PropertyChanges {
                    target: line3
                    x: parent.width / 4
                    y: parent.height / 3 * 2 - parent.height / 15
                    width: parent.width / 2
                    height: parent.height / 15
                    rotation: 0
                }
            },
            State {
                name: "checked"
                PropertyChanges {
                    target: inner_element
                    rotation: 180
                }
                PropertyChanges {
                    target: line1
                    x: parent.width / 4 - parent.width / 50
                    y: parent.height / 3 + parent.height / 20
                    width: parent.width / 4
                    height: parent.height / 15
                    rotation: -45
                }
                PropertyChanges {
                    target: line2
                    x: parent.width / 4
                    y: parent.height / 2 - parent.height / 30
                    width: parent.width / 2
                    height: parent.height / 15
                }
                PropertyChanges {
                    target: line3
                    x: parent.width / 4 - parent.width / 50
                    y: parent.height / 3 * 2 - parent.height / 15 - parent.height / 20
                    width: parent.width / 4
                    height: parent.height / 15
                    rotation: 45
                }
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                PropertyAnimation {
                    target: inner_element
                    properties: "rotation"
                    easing.type: Easing.Linear
                    duration: inner_element.animationDuration
                }
                PropertyAnimation {
                    target: line1
                    properties: "x, y, width, height, rotation"
                    easing.type: Easing.Linear
                    duration: inner_element.animationDuration
                }
                PropertyAnimation {
                    target: line2
                    properties: "x, y, width, height, rotation"
                    easing.type: Easing.Linear
                    duration: inner_element.animationDuration
                }
                PropertyAnimation {
                    target: line3
                    properties: "x, y, width, height, rotation"
                    easing.type: Easing.Linear
                    duration: inner_element.animationDuration
                }
            }
        ]
    }
}
