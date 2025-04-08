import QtQuick 2.12  // Adjusted from 2.15
import QtQuick.Controls 2.12  // Adjusted from 2.15
import QtQuick.Layouts 1.12  // Adjusted from 1.15
import QtGraphicalEffects 1.12  // Adjusted from 1.15
import "../"

Popup {
    width: 600
    height: 280
    background: Rectangle {
        anchors.fill: parent
        radius: 9
        color: Theme.alphaColor(Theme.black,0.8)
    }

    contentItem:ColumnLayout {
        spacing: 8
        anchors.fill: parent

        Rectangle {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            width: parent.width - 48
            height: 1
        }

        RowLayout {
            Layout.leftMargin: 14
            Layout.alignment: Qt.AlignTop| Qt.AlignLeft
            spacing: 14

            LaunchButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/HeadUnit/Infotainment/assets/camera.png"
                text:  "Camera"
            }

            LaunchButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/HeadUnit/Infotainment/assets/calendar.png"
                text:  "Calender"
            }

            LaunchButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/HeadUnit/Infotainment/assets/icons/message.png"
                text:  "Messages"
            }

            LaunchButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/HeadUnit/Infotainment/assets/icons/zoom.png"
                text:  "Zoom"
            }



        }
        RowLayout {
            Layout.leftMargin: 14
            Layout.alignment: Qt.AlignTop| Qt.AlignLeft
            spacing: 14

            LaunchButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/HeadUnit/Infotainment/assets/icons/clapperboard.png"
                text:  "Theater"
            }

            LaunchButton {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                icon.source: "qrc:/HeadUnit/Infotainment/assets/spotify.png"
                text:  "Spotify"
            }

        }
    }
}
