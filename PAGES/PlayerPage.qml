import QtQuick 2.12
import QtQuick.Controls 2.5
import "../COMPONENTS/MediaPlayer"

Page {
    title: "MEDIA PLAYER"
    anchors.fill: parent
    width: parent.width
    height: 550
    background:BorderImage {
        source: "qrc:/IMG/backgroundWave.jpg"
        opacity: 0.3
    }

    MediaPlayer{}

}
