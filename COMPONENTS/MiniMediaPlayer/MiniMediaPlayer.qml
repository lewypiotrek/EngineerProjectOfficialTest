import QtQuick 2.0
import QtQuick.Controls 2.5


Item {
    width: 300
    height: 200
    objectName:"MiniMediaPlayer"

    Rectangle{
        width: parent.width
        height: parent.height
        color: "transparent"
        border.color: "black"
        border.width: 2

        Button {
            id: playButton
            x: 14
            y: 22
            text: qsTr("PLAY")
//            background: BorderImage {
//                id: play
//                source: "qrc:/COMPONENTS/MiniMediaPlayer/play.png"
//                width: parent.width
//                height: parent.height
//                border.left: 5; border.top: 5
//                border.right: 5; border.bottom: 5
//            }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.659999966621399}
}
##^##*/
