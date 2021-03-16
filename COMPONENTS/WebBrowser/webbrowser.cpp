#include "webbrowser.h"

WebBrowser::WebBrowser(QObject *parent) : QObject(parent)
{

}

void WebBrowser::openBrowser(int f_website)
{
    switch(f_website)
    {
        case youtube:
            system("URL=\"https://youtube.com\"; x-www-browser $URL");
        break;

        case google:
            system("URL=\"https://google.com\"; x-www-browser $URL");
        break;

        case googlemaps:
            system("URL=\"https://www.google.com/maps/@51.7967528,19.4613972,14z\"; x-www-browser $URL");
        break;

        case netflix:
            system("URL=\"https://www.netflix.com\"; x-www-browser $URL");
        break;

        case facebook:
            system("URL=\"https://www.facebook.com\"; x-www-browser $URL");
        break;

        case instagram:
            system("URL=\"https://www.instagram.com\"; x-www-browser $URL");
        break;
    }
}
