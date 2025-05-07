import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: homeScreen
    color: "#f0f0f0"

    signal navigateToCluster()
    signal navigateToNavigation()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 30

        // Title
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Home Screen"
            font.pixelSize: 32
            font.bold: true
        }

        // Subtitle
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Welcome to your vehicle's infotainment system"
            font.pixelSize: 18
        }

        // Spacer to push buttons to the middle
        Item { Layout.fillHeight: true }

        // Navigation Buttons
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 40

            Button {
                text: "Go to Cluster"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 60
                font.pixelSize: 18
                onClicked: navigateToCluster()
            }

            Button {
                text: "Go to Navigation"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 60
                font.pixelSize: 18
                onClicked: navigateToNavigation()
            }
        }

        // Spacer to push theme controls to the bottom
        Item { Layout.fillHeight: true }

        // Theme Controls at bottom center
        Column {
            id: themeControls
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Row{
                spacing: 10
                Button {
                    text: Theme.currentMode === Theme.Mode.Auto ? "Auto Theme ☀️" : "Manual Theme"
                    onClicked: Theme.toggleAuto()
                    font.pixelSize: 16
                    background: Rectangle {
                        color: "transparent"
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "black" // or "black" based on your default theme, or bind to Theme.colors.onSurface
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                // Theme color indicator
                Rectangle {
                    width: 30
                    height: 30
                    radius: 5
                    color: Theme.colors.background
                    border.color: Theme.colors.primary
                }
            }

            Row {
                visible: true
                spacing: 10

                Button {
                    text: "☀️ Light"
                    onClicked: Theme.setManualTheme(true)
                    enabled: Theme.currentTheme !== "light"
                    background: Rectangle { color: "transparent" }
                    contentItem: Text {
                        text: parent.text
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    text: "🌙 Dark"
                    onClicked: Theme.setManualTheme(false)
                    enabled: Theme.currentTheme !== "dark"
                    background: Rectangle { color: "transparent" }
                    contentItem: Text {
                        text: parent.text
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

        }
    }
}
