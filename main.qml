import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.VirtualKeyboard 2.15
import "COMPONENTS/Separators" as Separators

ApplicationWindow {
    id: window
    //visibility: "FullScreen"
    width: 1024
    height: 600
    visible: true
    title: qsTr("Car Dashboard")


    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            anchors.left: parent
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 3.5
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            id: titleLabel
            text:stackView.currentItem.title
            anchors.left:toolbarSeparator.right
            anchors.top: toolbarSeparator.top
            topPadding: 5
            font.pointSize: 20
            font.weight: Font.Light
            font.family: "Helvetica"
        }

        ToolSeparator{
            id:toolbarSeparator
            x:44
            y:4
            contentItem: Rectangle {
                implicitWidth: 2
                implicitHeight: 40
                color: "#c3c3c3"
            }
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.45
        height: window.height
        font.pointSize: 27

        Column {
            anchors.fill: parent
            Separators.ManuSeparatorVertical{}

            ItemDelegate {
                Image {
                    id: mediaIcon
                    source: "qrc:/IMG/music-and-multimedia.png"
                    width: 60
                    height: 60
                }
                text: qsTr("Media Player")
                leftPadding: parent.width * 0.2
                width: parent.width
                onClicked: {
                    stackView.push("qrc:/PAGES/PlayerPage.qml")
                    drawer.close()
                }
            }

            Separators.ManuSeparatorVertical{}

            ItemDelegate {
                Image {
                    id: radioIcon
                    source: "qrc:/IMG/radio.png"
                    width: 60
                    height: 60
                }
                text: qsTr("Radio")
                leftPadding: parent.width * 0.2
                width: parent.width
                onClicked: {
                    stackView.push("qrc:/PAGES/RadioPage.qml")
                    drawer.close()
                }
            }

           Separators.ManuSeparatorVertical{}

           ItemDelegate {
               Image {
                   id: browserIcon
                   source: "qrc:/IMG/web-search-engine.png"
                   width: 60
                   height: 60
               }
               text: qsTr("Web browser")
               leftPadding: parent.width * 0.2
               width: parent.width
               onClicked: {
                   stackView.push("qrc:/PAGES/BrowserPage.qml")
                   drawer.close()
               }
           }

           Separators.ManuSeparatorVertical{}

           ItemDelegate {
               text: qsTr("Settings")
               Image {
                   id: settingIcon
                   source: "qrc:/IMG/settings.png"
                   width: 60
                   height: 60
               }
               leftPadding: parent.width * 0.2
               width: parent.width               
               onClicked: {
                   stackView.push("qrc:/PAGES/SettingsPage.qml")
                   drawer.close()
               }
           }

        }
    }

    StackView {
        id: stackView
        initialItem: "qrc:/PAGES/HomePage.qml"
        anchors.fill: parent
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

}
