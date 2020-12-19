import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    width: 1024
    height: 550
    title: qsTr("Home")

    Image {
        id: carLogo
        x: 6
        y: 442
        width: 1018
        height: 108
        opacity: 0.6
        source: "qrc:/IMG/Sprtage_logo.png"
        sourceSize.height: 438
        fillMode: Image.Pad
    }

    Image {
        id: carFigure
        x: 233
        y: 56
        width: 564
        height: 461
        opacity: 0.3
        source: "qrc:/IMG/KIA_CAR.png"
        fillMode: Image.PreserveAspectFit
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/

