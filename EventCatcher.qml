import QtQuick 2.0

Item {
    signal entered
    signal exited
    signal globalGeometryChanged
    id: eventCatcherID
    Connections {
        property bool is_entered: false
        target: eventCatcher
        onMouseMove: {
            var gp = eventCatcherID.mapToGlobal(x, y);
            if ((gp.x < mouse.x) && ((gp.x + width) > mouse.x) && (gp.y < mouse.y) && ((gp.y + height) > mouse.y)) {
                if (! is_entered) {
                    is_entered = true;
                    eventCatcherID.entered()
                }
            }
            else {
                if (is_entered) {
                    is_entered = false;
                    eventCatcherID.exited()
                }
            }
        }
        onGlobalGeometryChanged: {
            eventCatcherID.globalGeometryChanged(size);
        }
    }
}
