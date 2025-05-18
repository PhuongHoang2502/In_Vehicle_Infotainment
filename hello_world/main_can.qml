import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 480
    title: "Infotainment System"
    property bool isDarkTheme: false

    color: isDarkTheme ? "#1c2526" : "#f5f6f5"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        ColumnLayout {
            Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
            spacing: 10

            GridLayout {
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                Label {
                    text: "Gear:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: {
                        switch (canController.gear) {
                            case 0: return "P";
                            case 1: return "R";
                            case 2: return "N";
                            case 3: return "D";
                            default: return "Unknown";
                        }
                    }
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Speed:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.speed >= 0 ? canController.speed + " km/h" : "0 km/h"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                    Component.onCompleted: console.log("Speed initial:", canController.speed)
                    onTextChanged: console.log("Speed changed to:", canController.speed)
                }

                Label {
                    text: "Light Intensity:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.light + " %"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Temperature:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.temperature.toFixed(1) + " °C"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Humidity:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.humidity + " %"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Distance:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.distance + " cm"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Buzzer:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.buzzerEnabled ? "Enabled" : "Disabled"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Left Turn:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.leftTurn ? "On" : "Off"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Right Turn:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: canController.rightTurn ? "On" : "Off"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }

                Label {
                    text: "Headlight:"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
                Label {
                    text: {
                        if (canController.autoMode) return "Auto";
                        switch (canController.headlight) {
                            case 0: return "Off";
                            case 1: return "Low Beam";
                            case 2: return "High Beam";
                            default: return "Unknown";
                        }
                    }
                    color: isDarkTheme ? "#ffffff" : "#000000"
                }
            }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: canController.buzzerEnabled ? "Disable Buzzer" : "Enable Buzzer"
                    onClicked: canController.toggleBuzzer()
                }

                Button {
                    text: canController.leftTurn ? "Turn Left Off" : "Turn Left On"
                    onClicked: canController.toggleLeftTurn()
                }

                Button {
                    text: canController.rightTurn ? "Turn Right Off" : "Turn Right On"
                    onClicked: canController.toggleRightTurn()
                }

                Button {
                    text: canController.headlight == 1 ? "Low Beam Off" : "Low Beam On"
                    onClicked: canController.toggleLowBeam()
                }

                Button {
                    text: canController.headlight == 2 ? "High Beam Off" : "High Beam On"
                    onClicked: canController.toggleHighBeam()
                }

                Button {
                    text: canController.autoMode ? "Disable Auto" : "Enable Auto"
                    onClicked: canController.toggleAutoMode()
                }

                Button {
                    text: isDarkTheme ? "Switch to Light Theme" : "Switch to Dark Theme"
                    onClicked: root.isDarkTheme = !root.isDarkTheme
                }
            }

            Item { Layout.fillHeight: true }
        }

        Rectangle {
            id: rightArea
            Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
            color: isDarkTheme ? "#2e2e2e" : "#e0e0e0"

            Rectangle {
                anchors.fill: parent
                color: isDarkTheme ? "#3a3a3a" : "#d0d0d0"
                Text {
                    anchors.centerIn: parent
                    text: "Map Placeholder"
                    color: isDarkTheme ? "#ffffff" : "#000000"
                    font.pixelSize: 24
                }
            }
        }
    }
}