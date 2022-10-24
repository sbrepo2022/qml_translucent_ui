#ifndef EVENTCATCHER_H
#define EVENTCATCHER_H

#include <QObject>
#include <QEvent>
#include <QMouseEvent>
#include <QTimer>
#include <QCursor>
#include <QWindow>

class EventCatcher : public QObject
{
    Q_OBJECT
private:
    QWindow *window;
    QTimer *check_cursor_timer;
    bool in_window;

public:
    explicit EventCatcher(QObject *parent = nullptr);
    void setWindow(QWindow *window) {this->window = window;}

protected:
    bool eventFilter(QObject* watched, QEvent* event);

signals:
    void mouseMove(QPoint mouse);
    void globalGeometryChanged(QSize size);

public slots:
    void timerAction();
};

#endif // EVENTCATCHER_H
