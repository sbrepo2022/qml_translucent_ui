import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600

    Rectangle {
        id: background
        x: 0
        y: 0
        width: parent.width
        height: parent.height

        Image {
            id: image
            source: "qrc:/background.jpg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }
    }

    BluredSurface {
        id: tools_surface1
        x: 0
        y: 0
        width: 100
        height: parent.height

        backgroundItem: background
        borderWidth: 5
        borderAlign: "right"
    }

    Rectangle {
        id: under_tools_surface2
        anchors.right: parent.right
        width: 100
        height: parent.height
        color: "#00000000"

        state: "closed"

        BluredSurface {
            id: tools_surface2
            anchors.fill: parent

            backgroundItem: background
            borderWidth: 5
            borderAlign: "left"

            ToolsButton {
                id: tools_button
                anchors.top: parent.top
                anchors.right: parent.right
                width: 100
                height: 100
                buttonRadius: 50
                buttonColor: "#222"
                alternateColor: "#222"

                onChecked: {
                    under_tools_surface2.state = "opened";
                    tools_surface2.setAlwaysBlured(true);
                }
                onUnchecked: {
                    small_workspace.state = "invisible";
                    tools_surface2.setAlwaysBlured(false);
                }
            }

            ListModel {
                id: right_menu_list_model
                ListElement {
                    icon: "qrc:/textures/pencil.png"
                    status: "checked"
                }
                ListElement {
                    icon: "qrc:/textures/picture.png"
                    status: "unchecked"
                }
            }

            RightMenuList {
                anchors.top: tools_button.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: 100
                list_model: right_menu_list_model
            }

            SmallWorkspace {
                id: small_workspace
                anchors.fill: parent
                anchors.rightMargin: 100

                state: "invisible"

                states: [
                    State {
                        name: "visible"
                        PropertyChanges {
                            target: small_workspace
                            opacity: 1.0
                        }
                    },
                    State {
                        name: "invisible"
                        PropertyChanges {
                            target: small_workspace
                            opacity: 0.0
                        }
                    }
                ]

                transitions: [
                    Transition {
                        from: "visible"
                        to: "invisible"
                        PropertyAnimation {
                            target: small_workspace
                            properties: "opacity"
                            easing.type: Easing.Linear
                            duration: 200
                        }
                        onRunningChanged: {
                            if (running === false) under_tools_surface2.state = "closed";
                        }
                    },
                    Transition {
                        from: "invisible"
                        to: "visible"
                        PropertyAnimation {
                            target: small_workspace
                            properties: "opacity"
                            easing.type: Easing.Linear
                            duration: 200
                        }
                    }
                ]
            }
        }

        states: [
            State {
                name: "closed"
                PropertyChanges {
                    target: under_tools_surface2
                    width: 100
                }
            },
            State {
                name: "opened"
                PropertyChanges {
                    target: under_tools_surface2
                    width: window.width / 3 > 100 ? window.width / 3 : 100
                }
            }
        ]

        transitions: [
            Transition {
                from: "opened"
                to: "closed"
                PropertyAnimation {
                    target: under_tools_surface2
                    properties: "width"
                    easing.type: Easing.Linear
                    duration: 200
                }
            },
            Transition {
                from: "closed"
                to: "opened"
                PropertyAnimation {
                    target: under_tools_surface2
                    properties: "width"
                    easing.type: Easing.Linear
                    duration: 200
                }
                onRunningChanged: {
                    if (running === false) small_workspace.state = "visible";
                }
            }
        ]
    }

    onWidthChanged: {
        tools_surface1.updateRendering()
        tools_surface2.updateRendering()
    }
    onHeightChanged: {
        tools_surface1.updateRendering()
        tools_surface2.updateRendering()
    }
}
