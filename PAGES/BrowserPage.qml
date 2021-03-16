import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    id: page
    title: "WEB BROWSER"
    anchors.fill: parent
    width: 1024
    height: 600


    Rectangle
    {
        x: 78
        y: 62
        width: 208
        height: 199
        radius: 10
        border.color: "gray"
        border.width: 4

        Image {
            id: youtube
            x: 8
            y: 8
            width: 192
            height: 183
            source: "qrc:/IMG/youtube.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                browser.openBrowser(0)
            }
        }
    }

    Rectangle {
        x: 387
        y: 62
        width: 208
        height: 199
        radius: 10
        border.color: "gray"
        border.width: 4

        Image {
            id: google
            x: 8
            y: 8
            width: 192
            height: 183
            source: "qrc:/IMG/google.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                browser.openBrowser(1)
            }
        }
    }

    Rectangle {
        x: 680
        y: 62
        width: 208
        height: 199
        radius: 10
        border.color: "gray"
        border.width: 4

        Image {
            id: googlemaps
            x: 8
            y: 8
            width: 192
            height: 183
            source: "qrc:/IMG/googlemaps.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                browser.openBrowser(2)
            }
        }
    }

    Rectangle {
        x: 78
        y: 317
        width: 208
        height: 199
        radius: 10
        border.color: "gray"
        border.width: 4

        Image {
            id: netflix
            x: 8
            y: 8
            width: 192
            height: 183
            source: "qrc:/IMG/Netflix.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                browser.openBrowser(3)
            }
        }
    }

    Rectangle {
        x: 387
        y: 317
        width: 208
        height: 199
        radius: 10
        border.color: "gray"
        border.width: 4

        Image {
            id: facebook
            x: 8
            y: 8
            width: 192
            height: 183
            source: "qrc:/IMG/facebook.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                browser.openBrowser(4)
            }
        }
    }

    Rectangle {
        x: 680
        y: 317
        width: 208
        height: 199
        radius: 10
        border.color: "gray"
        border.width: 4

        Image {
            id: instagram
            x: 8
            y: 8
            width: 192
            height: 183
            source: "qrc:/IMG/instagram.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                browser.openBrowser(5)
            }
        }
    }
}
