import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15 // For MouseArea

Item {
    id: root
    signal finished()

    property alias source: player.source
    property alias volume: player.volume

    Rectangle {
        anchors.fill: parent
        color: "black"
        z: -1  // Place behind VideoOutput
    }

    MediaPlayer {
        id: player
        source: "qrc:/Intro.mp4"
        autoLoad: true // Pre-buffer the video
        autoPlay: false // Don't start playing immediately
        volume: 1.0

        onStatusChanged: {
            if (status === MediaPlayer.Loaded) {
                play();
            }
        }

        onStopped: {
            root.finished();
            player.source = ""; // Unload the video source after it finishes
        }

        onError: {
            console.error("Error playing video:", errorString);
            root.finished(); // Still signal finished even if there's an error
        }
    }

    VideoOutput {
        anchors.fill: parent
        source: player
    }

    Image {
        id: fallbackImage
        anchors.fill: parent
        source: "qrc:/Icons/LogoBK.png" // Make sure this path is correct
        visible: player.hasError || player.status === MediaPlayer.NoMedia
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            player.stop();
            root.finished(); // Emit the finished signal on a click
        }
    }
}
