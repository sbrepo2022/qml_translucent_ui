import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property int imgStatusHeight
    property int imgTitleHeight
    property int imgRadiusHeight
    property int imgWidth: width
    property int imgHeight: height
    property string imageSource: ""
    property string animState
    signal clicked

    id: outer_element
    color: "#00000000"

    Component.onCompleted: {
        img_rect.state = animState;
        checked_img.state = animState;
    }

    onAnimStateChanged: {
        animState === "checked" ? anim_timer.start() : checked_img.state = "unchecked";
    }

    Rectangle {
        property int statusHeight
        property int titleHeight: imgTitleHeight
        id: img_rect
        anchors.centerIn: parent
        width: outer_element.imgWidth
        height: outer_element.imgHeight + statusHeight + titleHeight
        radius: imgRadiusHeight
        color: "#222"

        layer.enabled: true
        layer.effect: DropShadow {
            id: d_shadow
            anchors.fill: img_rect
            source: img_rect
            radius: 16
            samples: 32
            //verticalOffset: 4
            color: "#a0000000"
        }

        Image {
            id: image
            source: outer_element.imageSource
            y: img_rect.titleHeight
            anchors.horizontalCenter: parent.horizontalCenter
            width: outer_element.imgWidth
            height: outer_element.imgHeight
            fillMode: Image.PreserveAspectCrop
            smooth: true;
        }

        Image {
            id: checked_img
            source: "qrc:/textures/done.svg"
            y: img_rect.titleHeight + image.height + img_rect.statusHeight * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            width: height
            height: img_rect.statusHeight * 0.8
            fillMode: Image.PreserveAspectCrop
            smooth: true
            sourceSize: Qt.size(width, height)

            states: [
                State {
                    name: "unchecked"
                    PropertyChanges {
                        target: checked_img
                        opacity: 0.0
                    }
                },
                State {
                    name: "checked"
                    PropertyChanges {
                        target: checked_img
                        opacity: 1.0
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "unchecked"
                    to: "checked"
                    PropertyAnimation {
                        target: checked_img
                        properties: "opacity"
                        easing.type: Easing.Linear
                        duration: 100
                    }
                },
                Transition {
                    from: "checked"
                    to: "unchecked"
                    PropertyAnimation {
                        target: checked_img
                        properties: "opacity"
                        easing.type: Easing.Linear
                        duration: 100
                    }
                    onRunningChanged: {
                        if (! running) img_rect.state = "unchecked";
                    }
                }
            ]
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                outer_element.clicked()
            }
        }

        Timer {
            id: anim_timer
            interval: 100
            running: false
            repeat: false
            onTriggered: {
                img_rect.state = "checked";
            }
        }

        states: [
            State {
                name: "unchecked"
                PropertyChanges {
                    target: img_rect
                    statusHeight: outer_element.imgStatusHeight
                    height: width / 16 * 9 + outer_element.imgStatusHeight + outer_element.imgTitleHeight
                }
            },
            State {
                name: "checked"
                PropertyChanges {
                    target: img_rect
                    statusHeight: outer_element.imgStatusHeight * 2
                    height: width / 16 * 9 + outer_element.imgStatusHeight * 2 + outer_element.imgTitleHeight
                }
            }
        ]

        transitions: [
            Transition {
                from: "unchecked"
                to: "checked"
                PropertyAnimation {
                    target: img_rect
                    properties: "statusHeight, height"
                    easing.type: Easing.Linear
                    duration: 100
                }
                onRunningChanged: {
                    if (! running) checked_img.state = "checked";
                }
            },
            Transition {
                from: "checked"
                to: "unchecked"
                PropertyAnimation {
                    target: img_rect
                    properties: "statusHeight, height"
                    easing.type: Easing.Linear
                    duration: 100
                }
            }
        ]
    }
}
