import QtQuick 2.12
import QtQuick.Controls 2.5
import "../COMPONENTS/AnalogClock"


Page {
    title: "HOME"
    width: 1024
    height: 600

    Image{
        id: carLogoIcon
        anchors.top: parent.top
        anchors.left: parent.left
        width: 1024
        height: 450
        opacity: 0.3
        source: "qrc:/IMG/KIA_CAR.png"
        fillMode: Image.PreserveAspectFit
    }

    Image{
        id: modelLogoIcon
        anchors.top: carLogoIcon.bottom
        anchors.left: carLogoIcon.left
        width: 1024
        height: 101
        source: "qrc:/IMG/Sprtage_logo.png"
        fillMode: Image.Pad
    }

    Rectangle{
        anchors.right: parent.right
        width:250
        height: 250
        color: "#303030"
        y:10
        AnalogClock{
        }
    }





}
