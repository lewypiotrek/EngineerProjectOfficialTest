import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Item{
    id: root
    anchors.fill: parent
    width: 1024
    height: 535

    function parseSecToTime(duration)
    {
        var seconds = Math.floor((duration / 1000) % 60),
            minutes = Math.floor((duration / (60 * 1000)) % 60);

        minutes = (minutes < 10) ? "0" + minutes : minutes;
        seconds = (seconds < 10) ? "0" + seconds : seconds;
        return minutes + ":" + seconds;
    }


    // Timer to handle duration and title with a short delay(To make sure that is already loaded)
    Timer{
        id: delayGetMetadata
        repeat: false
        interval: 100
        onTriggered: {
            durationSlider.to = musicPlayer.getDuration()/1000
            songTotalTimestamp.text = parseSecToTime(musicPlayer.getDuration())
            songTitle.text = musicPlayer.getSongTitle()
        }
    }

    // Field for song title
    Text {
        id: songTitle
        x: 214
        y: 291
        width: 51
        height: 59
        color: "#f7f6f6"
        text: musicPlayer.songTitle
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        maximumLineCount: 500
        font{
            pixelSize: 21
        }
    }


////////////  BUTTONS PANEL  ////////////
    Rectangle{
        id: buttonsPanel
        color: "transparent"
        border.color: "white"
        border.width: 1
        radius: 10
        width: 600
        height: 138
        x: 213
        y: 398

        RowLayout{
            width: 594
            height: 128
            x:13
            y:5

            // PREVIOUS
            MediaButton{
                onButtonClicked: {                    
                    musicPlayer.previouseSong()
                    delayGetMetadata.start()
                }
                Image {
                    id: previousIcon
                    source: "next.png"
                    height: parent.height
                    width: parent.width
                    rotation: 180
                }
            }

            // PLAY
            MediaButton{
                id: playButton
                property bool isPlaying: true
                onButtonClicked: {
                   musicPlayer.playMusic()
                   delayGetMetadata.start()

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

            // STOP
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

            // NEXT
            MediaButton{
                onButtonClicked: {
                    musicPlayer.nextSong()
                    delayGetMetadata.start()
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

//////////////////////////////////////////////

    // Duration slider
    Slider {
        id: durationSlider
        x: 213
        y: 335
        width: 600
        height: 62
        stepSize: 1000
        font.pointSize: 17
        value: musicPlayer.currectSongPosition
        onValueChanged: {
            songCurrentTimestamp.text = parseSecToTime(musicPlayer.currectSongPosition * 1000)
        }
    }

    // Place for song cover
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
            anchors.margins: 3
            opacity: 0.7
        }
    }

    // Volume setting  - volume dial
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

////////////  PLAYLIST WIDGET  ////////////

    // Preaparing area for playlist
    Rectangle {
        id: playlistArea
        border.color: "white"
        radius: 10
        color: "transparent"
        x:304
        y:20
        width: 698
        height: 260

        // Declare listView
        ListView{
            id: songsPlaylist
            width: parent.width - 5
            height: parent.height - 80
            model: musicPlayer.model
            anchors.centerIn: parent
            anchors.leftMargin: 5            

            // Declare single item on list
            delegate: Rectangle{
                id: singleSongPosition
                height: 45
                width:parent.width
                color: "transparent"
                border.color: "#3f3f3f"
                border.width: 1
                radius: 10
                anchors.topMargin: 1
                anchors.leftMargin: 5                

                // press animation
                states: [
                   State {
                     name: "pressed"
                     when: mouseareaDelegate.pressed

                     PropertyChanges {
                       target: singleSongPosition
                       border.color: "#660000"
                       scale:0.98
                       border.width: 2
                     }
                   },
                   State{
                        name: "normal"
                        when: mouseareaDelegate.released()

                        PropertyChanges {
                          target: singleSongPosition
                          border.color: "#3f3f3f"
                          scale: 1.0
                          border.width: 1
                        }
                    }
                ]   // animation end

                MouseArea{
                    id: mouseareaDelegate
                    width: parent.width
                    height: parent.height
                    onClicked: {
                        parent.buttonClicked()
                        songsPlaylist.currentIndex = index
                        musicPlayer.playIndex(songsPlaylist.currentIndex)
                    }
                }

                Text {
                    id: listItemTitle
                    text: modelData
                    font.pixelSize: 20
                    color: "white"
                    anchors.fill: parent
                    wrapMode: Text.WordWrap
                }

                signal buttonClicked()
            }

        }
    }
//////////////////////////////////////////////

    // Mute Switch
    Switch {
        property bool isMuted: false
        id: muteSwitch
        x: 6
        y: 400
        width: 201
        height: 59
        text: qsTr("MUTED")
        font.pointSize: 18

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

    // Repeat Switch
    Switch {
        property bool isLooped: false
        id: repeatSwitch
        x: 8
        y: 465
        width: 199
        height: 62
        text: qsTr("LOOP")
        font.pointSize: 18

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

    // Song Duration - current time and total duration
    Text {
        id: songTotalTimestamp
        x: 809
        y: 348
        width: 64
        height: 35
        color: "#f7f6f6"
        text: qsTr("00:00")
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        minimumPixelSize: 12
    }

    Text {
        id: songCurrentTimestamp
        x: 151
        y: 348
        width: 64
        height: 35
        color: "#f7f6f6"
        text: "00:00"
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        minimumPixelSize: 10
    }


}

