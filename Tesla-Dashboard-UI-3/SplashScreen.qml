import QtQuick 2.0
import QtQuick.Window 2.12
import QtMultimedia 5.12

Window {
    id: splash
    visible: true
    width: 1920
    height: 1080
    color: "black"
    flags: Qt.FramelessWindowHint | Qt.Window

    // Add a close button
    Rectangle {
        id: closeButton
        width: 30
        height: 30
        color: "transparent"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10
        
        Text {
            anchors.centerIn: parent
            text: "✕"
            color: "white"
            font.pixelSize: 20
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                splash.close()
                Qt.quit()
            }
        }
    }

    Video {
        id: splashVideo
        anchors.fill: parent
        source: "qrc:/startup.mp4"
        autoPlay: true
        onStopped: {
            if (mainAppLoader.status === Loader.Ready) {
                mainAppLoader.item.visible = true
                splash.close()
            }
        }
    }

    // Remove duplicate Loader and add status handling
    Loader {
        id: mainAppLoader
        asynchronous: true
        source: "qrc:/main.qml"
        onStatusChanged: {
            if (status === Loader.Error) {
                console.error("Error loading main.qml")
            }
        }
    }
}