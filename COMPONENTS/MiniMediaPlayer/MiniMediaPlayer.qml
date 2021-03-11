import QtQuick 2.0
import QtQuick.Controls 2.5


Item {
    width: 300
    height: 180
    objectName:"MiniMediaPlayer"

    Rectangle{
        width: parent.width
        height: parent.height
        color: "transparent"
        border.color: "white"
        border.width: 1
        opacity: 0.9

        RoundButton {
            id: roundPlayButton
            property bool isPlaying: false
            x: 93
            y: 75
            width: 114
            height: 105
            text: "PLAY"
            font.pointSize: 16
            onClicked: {
                musicPlayer.playMusic()
                songTitle.text = musicPlayer.getSongTitle()
                 if(isPlaying == false)
                {
                    text ="PLAY"
                    isPlaying = true
                }
                else
                 {
                     text = "PAUSE"
                     isPlaying = false
                 }
            }
        }

        Text {
            id: songTitle
            x: 8
            y: 8
            width: 284
            height: 49
            color: "#f7f6f6"
            text: musicPlayer.getSongTitle()
            font.pixelSize: 17
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            maximumLineCount: 100
        }

        RoundButton {
            id: previouseButton
            x: 0
            y: 75
            width: 90
            height: 105
            text: "<"
            font.pointSize: 25
            onClicked: {
                musicPlayer.previouseSong()
                songTitle.text = musicPlayer.getSongTitle()
            }
        }

        RoundButton {
            id: nextButton
            x: 209
            y: 75
            width: 90
            height: 105
            text: ">"
            font.pointSize: 25
            onClicked: {
                musicPlayer.nextSong()
                songTitle.text = musicPlayer.getSongTitle()
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.659999966621399}
}
##^##*/
