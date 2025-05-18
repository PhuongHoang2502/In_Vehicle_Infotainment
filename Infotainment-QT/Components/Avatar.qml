import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import App.Theme 1.0
Window {
    id: fullScreenImageWindow
    width: 800
    height: 600
    flags: Qt.Window //| Qt.FramelessWindowHint
    color: "transparent"
    // Background to dim the screen
    Rectangle {
        anchors.fill: parent
        color: "black"
    }
    // Enlarged Image
    Image {
        id: fullScreenImage
        anchors.centerIn: parent
//        width: 800
//        height: 600
        anchors.fill: parent
        source: "qrc:/Icons/mhx.png" // Fixed image source
        fillMode: Image.PreserveAspectFit
        // Click to close
        MouseArea {
            anchors.fill: parent
            onClicked: {
                fullScreenImageWindow.close()
            }
        }
    }
}
