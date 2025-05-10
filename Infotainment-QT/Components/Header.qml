import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Theme 1.0

Rectangle {
    id: header
    color: "transparent"
    width: parent.width
    height: 60

    // Centralized time formatting
    property string timeFormat: "hh:mm a"
    property string dateFormat: "dddd | MMM dd, yyyy"

    // Font property to replace root.fontAwesomeFontLoader reference
    property string defaultFontFamily: "Montserrat"

    // Central timer for both time displays
    Timer {
        id: clockTimer
        interval: 1000 // Update every second
        running: true
        repeat: true
        onTriggered: {
            currentTime.text = Qt.formatDateTime(new Date(), header.timeFormat)
            currentDate.text = Qt.formatDateTime(new Date(), header.dateFormat)
        }
    }

    // Left section with time and date
    ColumnLayout {
        id: timeDisplay
        spacing: 2
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: parent.verticalCenter
        }

        Label {
            id: currentTime
            text: Qt.formatDateTime(new Date(), header.timeFormat)
            font {
                pixelSize: 22
                family: header.defaultFontFamily
                bold: Font.Normal
            }
            color: Theme.colors.text
        }

        Label {
            id: currentDate
            text: Qt.formatDateTime(new Date(), header.dateFormat)
            font {
                pixelSize: 14
                family: header.defaultFontFamily
                bold: Font.Normal
            }
            color: Theme.colors.text
        }
    }
}
