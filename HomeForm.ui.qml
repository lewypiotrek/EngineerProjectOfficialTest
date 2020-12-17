import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    width: 600
    height: 400

    title: qsTr("Home")

    DelayButton {
        id: delayButton
        x: 231
        y: 225
        text: qsTr("Delay Button")
    }

    Button {
        id: button
        x: 193
        y: 125
        text: qsTr("Button")
    }

    CheckBox {
        id: checkBox
        x: 60
        y: 195
        text: qsTr("Check Box")
    }

    SwitchDelegate {
        id: switchDelegate
        x: 84
        y: 293
        text: qsTr("Switch Delegate")
    }

    Switch {
        id: switch1
        x: 359
        y: 303
        text: qsTr("Switch")
    }

    TextEdit {
        id: textEdit
        x: 128
        y: 70
        width: 197
        height: 49
        text: qsTr("Text Edit")
        font.pixelSize: 12
    }

    Dial {
        id: dial
        x: 441
        y: 73
    }

    ProgressBar {
        id: progressBar
        x: 13
        y: 103
        width: 200
        height: 21
        value: 0.5
    }

    Slider {
        id: slider
        x: 128
        y: 352
        value: 0.5
    }
}
