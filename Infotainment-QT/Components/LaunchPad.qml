import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import App.Theme 1.0

Popup {
    id: launchPad
    width: 1104
    height: 445
    
    background: Rectangle {
        anchors.fill: parent
        radius: 9
        color: Qt.rgba(0, 0, 0, 0.8)
    }

    contentItem: ColumnLayout {
        spacing: 8
        anchors.fill: parent

        // Quick controls section
        RowLayout {
            Layout.leftMargin: 24
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            spacing: 24

            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/front-defrost.svg"
                text: "Front Defrost"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/rear-defrost.svg"
                text: "Rear Defrost"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/seat-warmer.svg"
                text: "Seat Warmer"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/steering-wheel-warmer.svg"
                text: "Steering Warmer"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/wiper.svg"
                text: "Wipers"
            }
        }

        // Divider
        Rectangle {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            width: parent.width - 48
            height: 1
            color: "white"
        }

        // Apps section
        RowLayout {
            Layout.leftMargin: 24
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            spacing: 24

            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/Gmail.jpg"
                text: "Gmail"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/Notion.png"
                text: "Notion"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/Messenger.png"
                text: "Messenger"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/Zalo.svg"
                text: "Zalo"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/GGMeet.png"
                text: "Meet"
                iconWidth: 58
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/zoom.svg"
                text: "Zoom"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/spotify.svg"
                text: "Spotify"
            }
        }

        // Media section
        RowLayout {
            Layout.leftMargin: 24
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            spacing: 24

            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/FaceBook.png"
                text: "Facebook"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/Insta.jpg"
                text: "Instagram"
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/YouTube.png"
                text: "YouTube"
                iconWidth: 70
            }
            LaunchPadButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/Icons/Apps/AOV.png"
                text: "Arena of Valor"
            }
        }
    }
}
