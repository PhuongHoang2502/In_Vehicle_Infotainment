import QtQuick 2.0
import QtLocation 5.12
import QtPositioning 5.12

Rectangle{
    id: rightScreen

    anchors{
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
    }
    Plugin{
        id: mapPlugin
        name: "osm"
    }

    Map{
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(10.772134791108712, 106.6579854688229)
        zoomLevel: 14
    }

    Image{
        id: lockIcon
        anchors{
            left: parent.left
            top: parent.top
            margins: 20
        }

        width: parent.width / 40
        fillMode: Image.PreserveAspectFit
        source: (systemHander.carLocked ? "qrc:/ui/assets/lock.png" : "qrc:/ui/assets/unlock.png")
        MouseArea{
            anchors.fill: parent
            onClicked: systemHander.setcarLocked(!systemHander.carLocked)
        }
    }

    Text{
        id: dateTimeDisplay
        anchors{
            left: lockIcon.right
            leftMargin: 30
            bottom: lockIcon.bottom
        }

        font.pixelSize: 12
        font.bold: true
        color: "black"

        text: systemHander.currentTime
    }

    Text{
        id: outdoorTemperatureDisplay
        anchors{
            left: dateTimeDisplay.right
            leftMargin: 30
            bottom: lockIcon.bottom
        }

        font.pixelSize: 12
        font.bold: true
        color: "black"

        text: systemHander.outdoorTemp + "°C"
    }

    Text{
        id: userNameDisplay
        anchors{
            left: outdoorTemperatureDisplay.right
            leftMargin: 30
            bottom: lockIcon.bottom
        }

        font.pixelSize: 12
        font.bold: true
        color: "black"

        text: systemHander.userName
    }

    width: parent.width * 2/3
}
