import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Item{
    id: root
    anchors.fill: parent
    width: 1024
    height: 535

    Text {
        id: songTitle
        x: 487
        y: 286
        width: 51
        height: 59
        text: qsTr("...")
        font{
            pixelSize: 25
        }
    }

    Rectangle{
        id: buttonsPanel
        color: "transparent"
        border.color: "white"
        border.width: 1
        radius: 10
        width: 600
        height: 138
        x: 213
        y: 400


        RowLayout{
            width: 594
            height: 128
            x:13
            y:5

            MediaButton{
                onButtonClicked: {
                    musicPlayer.previouseSong()
                }

                Image {
                    id: previousIcon
                    source: "next.png"
                    height: parent.height
                    width: parent.width
                    rotation: 180
                }

            }

            MediaButton{
                id: playButton
                property bool isPlaying: true
                onButtonClicked: {
                   musicPlayer.playMusic()
                   if(isPlaying == false)
                   {
                       playIcon.source="play.png"
                       isPlaying = true
                   }
                   else
                   {
                       playIcon.source="pause.png"
                       isPlaying = false
                   }
                }

                Image {
                    id: playIcon
                    source: "play.png"
                    height: parent.height
                    width: parent.width
                }
            }

            MediaButton{                
                onButtonClicked: {
                    musicPlayer.stopMusic()
                    playIcon.source="play.png"
                    playButton.isPlaying = true
                }

                Image {
                    id: pauseIcon
                    source: "stop.png"
                    height: parent.height
                    width: parent.width
                }
            }

            MediaButton{
                onButtonClicked: {
                    musicPlayer.nextSong()
                }

                Image {
                    id: nextIcon
                    source: "next.png"
                    height: parent.height
                    width: parent.width
                }
            }
        }
    }

    Slider {
        id: slider
        x: 213
        y: 332
        width: 600
        height: 62
        stepSize: 1000
        font.pointSize: 17
        value: musicPlayer.getDuration()
    }

    Rectangle {
        id: songCover
        x: 18
        y: 20
        width: 260
        height: 260
        border.color: "white"
        radius: 10
        border.width: 1
        color: "transparent"
        Image {
            source:"qrc:/IMG/Music.png"
            anchors.fill: parent
            anchors.margins: 2
            opacity: 0.7

        }
    }

    Dial {
        id: volumeDial
        x: 845
        y: 378
        width: 164
        height: 149
        wheelEnabled: false
        stepSize: 1
        from: 0
        to: 100
        value: musicPlayer.getVolume()
        onValueChanged: {
            musicPlayer.setVolume(value)
        }

        Text {
            id: volumeValue
            x: 52
            y: 53
            width: 56
            height: 38
            text: volumeDial.value.toFixed(0)
            font.pixelSize: 36
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }

    Playlist {
        x:347
        y:20
        width: 615
        height: 260
    }

    Switch {
        property bool isMuted: false
        id: muteSwitch
        x: 18
        y: 400
        width: 167
        height: 59
        text: qsTr("MUTED")
        font.pointSize: 22

        onClicked: {
            musicPlayer.muteSong()
            if(isMuted == false)
            {
                font.underline=true
            }
            else
            {
                font.underline=false
            }
            isMuted = !isMuted
        }
    }

    Switch {
        property bool isLooped: false
        id: repeatSwitch
        x: 18
        y: 465
        width: 167
        height: 62
        text: qsTr("LOOP")
        font.pointSize: 22

        onClicked: {
            musicPlayer.repeatSong()
            if(isLooped == false)
            {
                font.underline=true
            }
            else
            {
                font.underline=false
            }
            isLooped = !isLooped
        }
    }

    Text {
        id: songTime
        x: 143
        y: 346
        width: 64
        height: 35
        text: qsTr("0:00")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        minimumPixelSize: 18
    }

    Button {
        id: button
        x: 40
        y: 339
        text: qsTr("Button")
        onClicked: {

        }
    }
}


