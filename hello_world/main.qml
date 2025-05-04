import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 800
    height: 480
    title: "Infotainment System"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        GridLayout {
            columns: 2
            rowSpacing: 10
            columnSpacing: 10

            Label { text: "Gear:" }
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
            }

            Label { text: "Speed:" }
            Label { text: canController.speed + " km/h" }

            Label { text: "Light Intensity:" }
            Label { text: canController.light + " %" }

            Label { text: "Temperature:" }
            Label { text: canController.temperature.toFixed(1) + " °C" }

            Label { text: "Humidity:" }
            Label { text: canController.humidity + " %" }

            Label { text: "Distance:" }
            Label { text: canController.distance + " cm" }

            Label { text: "Buzzer:" }
            Label { text: canController.buzzerEnabled ? "Enabled" : "Disabled" }

            Label { text: "LED:" }
            Label { text: canController.ledOn ? "On" : "Off" }
        }

        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter

            Button {
                text: canController.buzzerEnabled ? "Disable Buzzer" : "Enable Buzzer"
                onClicked: canController.toggleBuzzer()
            }

            Button {
                text: canController.ledOn ? "Turn LED Off" : "Turn LED On"
                onClicked: canController.toggleLed()
            }
        }

        Item { Layout.fillHeight: true }
    }
}
