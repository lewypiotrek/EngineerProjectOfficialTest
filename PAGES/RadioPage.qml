import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    title: {
        Text: "RADIO FM"
    }
    width: 1024
    height: 550
    x: parent.x
    y: parent.y
    background:BorderImage {
        source: "qrc:/IMG/backgroundWave.jpg"
        opacity: 0.3
    }

    Dial {
        id: frequencyDial
        x: 310
        y: 24
        width: 405
        height: 357
        stepSize: 0.1

        Text {
            id: currentFrequency
            x: 133
            y: 112
            width: 144
            height: 133
            color: "#f7f6f6"
            text: frequencyDial.value.toFixed(2)
            font.pixelSize: 69
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            Text {
                id: text1
                x: 42
                y: 109
                color: "#f7f6f6"
                text: qsTr("MHz")
                font.pixelSize: 32
            }
        }
        to: 108
        from: 87.5
    }

    RoundButton {
        id: savedStation1
        x: 38
        y: 24
        width: 193
        height: 100
        text: "92.4MHz"
        font.pointSize: 19
    }

    RoundButton {
        id: savedStation2
        x: 38
        y: 136
        width: 193
        height: 100
        text: "96.4MHz"
        font.pointSize: 19
    }

    RoundButton {
        id: savedStation3
        x: 38
        y: 256
        width: 193
        height: 100
        text: "88.4MHz"
        font.pointSize: 19
    }

    RoundButton {
        id: savedStation4
        x: 788
        y: 24
        width: 193
        height: 100
        text: "99.9MHz"
        font.pointSize: 19
    }

    RoundButton {
        id: savedStation5
        x: 788
        y: 136
        width: 193
        height: 100
        text: "92.4MHz"
        font.pointSize: 19
    }

    RoundButton {
        id: savedStation6
        x: 788
        y: 256
        width: 193
        height: 100
        text: "92.4MHz"
        font.pointSize: 19
    }

    Rectangle {
        id: rectangle
        x: 218
        y: 394
        width: 589
        height: 142
        color: "#00000000"
        radius: 10
        border.color: "#f7f6f6"

        Image {
            id: play
            x: 152
            y: 0
            width: 133
            height: 142
            source: "../COMPONENTS/MediaPlayer/play.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: up
            x: 8
            y: 0
            width: 133
            height: 142
            source: "../COMPONENTS/MediaPlayer/next.png"
            rotation: 90
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: down
            x: 296
            y: 1
            width: 133
            height: 142
            source: "../COMPONENTS/MediaPlayer/next.png"
            fillMode: Image.PreserveAspectFit
            rotation: 270
        }

        Switch {
            id: mute
            x: 440
            y: 8
            width: 141
            height: 64
            text: qsTr("MUTE")
            font.pointSize: 19
        }
    }

}
