import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Item{
    id: root
    anchors.fill: parent
    width: 1024
    height: 535
    Text {
        id: test
        x: 487
        y: 260
        text: qsTr("...")
        font{
            pixelSize: 55
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
                    musicPlayer.switchPreviouseSong()
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
                onButtonClicked: {
                    musicPlayer.playMusic()
                    test.text(qsTr("KLIK KLIK"))
                }

                Image {
                    id: playIcon
                    source: "play.png"
                    height: parent.height
                    width: parent.width
                }
            }

            MediaButton{
                Image {
                    id: pauseIcon
                    source: "pause.png"
                    height: parent.height
                    width: parent.width
                }
            }

            MediaButton{
                onButtonClicked: {
                    musicPlayer.switchNextSong()
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
        font.pointSize: 17
        value: 0.5
    }

    Rectangle {
        id: songCover
        x: 18
        y: 20
        width: 260
        height: 260
        border.color: "white"
        border.width: 1
        color: "transparent"
    }

    Dial {
        id: dial
        x: 845
        y: 400
        width: 140
        height: 127
    }

    CheckBox {
        id: checkBox
        x: 8
        y: 445
        width: 175
        height: 48
        text: qsTr("MUTE")
        font.pointSize: 17
    }

    CheckBox {
        id: checkBox1
        x: 8
        y: 391
        width: 175
        height: 48
        text: qsTr("REPEAT ONE")
        font.pointSize: 17
    }
}


