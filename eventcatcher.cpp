#include "eventcatcher.h"

EventCatcher::EventCatcher(QObject *parent) : QObject(parent)
{
    in_window = true;

    check_cursor_timer = new QTimer();
    connect(check_cursor_timer, SIGNAL(timeout()), this, SLOT(timerAction()));
    check_cursor_timer->start(100);
}

bool EventCatcher::eventFilter(QObject* watched, QEvent* event)
{
    QMouseEvent *mouseEvent;
    QResizeEvent *resizeEvent;
    QEvent::Type t = event->type();
    if ((t == QEvent::MouseMove) && event->spontaneous()) {
        mouseEvent = static_cast<QMouseEvent *>(event);
        in_window = true;
        emit mouseMove(mouseEvent->pos() + window->position());
    }
    if ((t == QEvent::Resize) && event->spontaneous()) {
        resizeEvent = static_cast<QResizeEvent *>(event);
        emit globalGeometryChanged(resizeEvent->size());
    }
    return QObject::eventFilter(watched, event);
}

void EventCatcher::timerAction() {
    QPoint wp = window->position(), cp = QCursor::pos();
    QSize ws = window->size();
    if ( (!(wp.x() < cp.x() && wp.x() + ws.width() > cp.x() && wp.y() < cp.y() && wp.y() + ws.height() > cp.y())) && in_window ) {
        in_window = false;
        emit mouseMove(QCursor::pos());
    }
}
