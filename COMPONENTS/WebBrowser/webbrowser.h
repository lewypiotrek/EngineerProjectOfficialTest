#ifndef WEBBROWSER_H
#define WEBBROWSER_H

#include <QObject>
#include <cstdlib>

class WebBrowser : public QObject
{
    Q_OBJECT
public:
    explicit WebBrowser(QObject *parent = nullptr);

public slots:
    void openBrowser(int website);

private:
    enum website
    {
        youtube = 0,
        google = 1,
        googlemaps = 2,
        netflix = 3,
        facebook = 4,
        instagram = 5
    };

};

#endif // WEBBROWSER_H
