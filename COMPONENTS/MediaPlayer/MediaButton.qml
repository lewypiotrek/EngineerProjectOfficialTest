import QtQuick 2.0

Rectangle {
    id: root
    width: 125
    height: 125
    color: "transparent"


    // PRESS ANIMATIONS
    states: [
       State {
         name: "pressed"
         when: mouseArea.pressed

         PropertyChanges {
           target: root
           scale: 0.9
           opacity:0.6
         }
       },
       State{
            name: "normal"
            when: mouseArea.released()

            PropertyChanges {
              target: root
              scale: 1.0
            }
        }
    ]

    // Action area
    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onClicked: {
           root.buttonClicked()
        }
    }

    signal buttonClicked()

}

