import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    // changing properties
    id: bluredButton
    state: "state1"
    property Item backgroundItem: parent
    property int animationDuration: 200
    property alias borderWidth: button_border.border_width
    property alias borderAlign: button_border.border_align
    property bool lockState: false
    //-------
    function setAlwaysBlured(is_blured) {
        lockState = is_blured;
        if (is_blured)
            bluredButton.state = "state2";
        //else
            //bluredButton.state = "state1";
    }

    function updateRendering() {
        source_effect.sourceRect = Qt.rect(bluredButton.mapToItem(backgroundItem, bluredButton.x, bluredButton.y).x, bluredButton.mapToItem(backgroundItem, bluredButton.x, bluredButton.y).y, bluredButton.width, bluredButton.height);
    }

    layer.enabled: true
    layer.effect: DropShadow {
        id: d_shadow
        anchors.fill: bluredButton
        source: bluredButton
        radius: 16
        samples: 32
        color: "#80000000"
    }

    EventCatcher {
        id: mouseArea
        anchors.fill: parent
        onEntered: {
            if (! lockState)
                bluredButton.state = "state2";
        }

        onExited: {
            if (! lockState)
                bluredButton.state = "state1";
        }
    }

    onWidthChanged: {
        updateRendering();
    }

    onHeightChanged: {
        updateRendering();
    }

    /*Connections {
        property bool is_entered: false
        target: eventCatcher
        onMouseMove: {
            var gp = bluredButton.mapToGlobal(x, y);
            if ((gp.x < mouse.x) && ((gp.x + width) > mouse.x) && (gp.y < mouse.y) && ((gp.y + height) > mouse.y)) {
                if (! is_entered) {
                    is_entered = true;
                    // write code inside block

                    if (! lockState)
                        state = "state2";

                    //---
                }
            }
            else {
                if (is_entered) {
                    is_entered = false;
                    // write code inside block

                    if (! lockState)
                        state = "state1";

                    //---
                }
            }
        }
    }*/

    ShaderEffectSource {
        id: source_effect
        anchors.fill: parent
        sourceItem: backgroundItem // changing property
        sourceRect: Qt.rect(bluredButton.mapToItem(backgroundItem, bluredButton.x, bluredButton.y).x, bluredButton.mapToItem(backgroundItem, bluredButton.x, bluredButton.y).y, bluredButton.width, bluredButton.height)
    }

    FastBlur {
        id: bg_blur
        anchors.fill: source_effect
        source: source_effect
        radius: 0
    }

    Rectangle {
        id: button_foreground
        anchors.fill: parent
        color: "#20ffffff"

        Rectangle {
            property int border_width: 5
            property string border_align: "right"

            id: button_border
            y: 0
            height: border_align == "right" || border_align == "left" ? parent.height : border_width
            width: border_align == "right" || border_align == "left" ? border_width : parent.width
            anchors.right: border_align == "right" ? parent.right : undefined
            anchors.left: border_align == "left" ? parent.left : undefined
            anchors.top: border_align == "top" ? parent.top : undefined
            anchors.bottom: border_align == "bottom" ? parent.bottom : undefined
            color: "#29ffffff"
        }
    }

    states: [
        State {
            name: "state1"
            PropertyChanges {
                target: bg_blur
                radius: 0
            }
            PropertyChanges {
                target: button_border
                height: border_align == "right" || border_align == "left" ? parent.height : border_width
                width: border_align == "right" || border_align == "left" ? border_width : parent.width
            }
        },
        State {
            name: "state2"
            PropertyChanges {
                target: bg_blur
                radius: 50
            }
            PropertyChanges {
                target: button_border
                height: border_align == "right" || border_align == "left" ? parent.height : 0
                width: border_align == "right" || border_align == "left" ? 0 : parent.width
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation {
                target: bg_blur
                properties: "radius"
                easing.type: Easing.Linear
                duration: bluredButton.animationDuration
            }
            PropertyAnimation {
                target: button_border
                properties: "width, height"
                easing.type: Easing.Linear
                duration: bluredButton.animationDuration
            }
        }
    ]
}
