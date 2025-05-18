import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./Components"

Rectangle {
    id: homeScreen
    color: "transparent"

    // Properties for dialog positioning
    property Item root: parent
    property Item leftArea
    property Item rightArea

    signal navigateToCluster()
    signal navigateToNavigation()

    // Background image that extends behind the header
    Image {
        id: background
        anchors.fill: parent
        source: Theme.currentTheme === "dark" 
            ? "qrc:/Image/Dark/Background.png" 
            : "qrc:/Image/Light/Background.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
        z: -1 // Place behind other components
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0  // Remove spacing between components

        // Header (transparent)
        Header {
            id: header
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: "transparent" // Ensure header is transparent

            RowLayout {
                id: navigationButtons
                spacing: 32
                anchors.centerIn: parent

                // Define common button properties to reduce repetition
                property real iconSize: 40

                // Cluster button
                IconButton {
                    id: clusterBtn
                    roundIcon: true
                    iconHeight: navigationButtons.iconSize + 15
                    iconWidth: navigationButtons.iconSize + 15
                    setIcon: "qrc:/Icons/Cluster.png"
                    onClicked: navigateToCluster()

                    // Optional tooltip
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Cluster")
                    ToolTip.delay: 500
                }

                // Home/Theme toggle button
                IconButton {
                    id: homeBtn
                    roundIcon: true
                    iconHeight: navigationButtons.iconSize
                    iconWidth: navigationButtons.iconSize
                    setIcon: "qrc:/Icons/01_logobachkhoatoi.png"
                    onClicked: Theme.setManualTheme(Theme.currentTheme === "dark")

                    // Optional tooltip
                    ToolTip.visible: hovered
                    ToolTip.text: Theme.currentTheme === "dark" ? qsTr("Switch to Light Mode") : qsTr("Switch to Dark Mode")
                    ToolTip.delay: 500
                }

                // Navigation button
                IconButton {
                    id: naviBtn
                    roundIcon: true
                    iconHeight: navigationButtons.iconSize
                    iconWidth: navigationButtons.iconSize
                    setIcon: "qrc:/Icons/Navigation.png"
                    setIconColor: Theme.colors.text
                    onClicked: navigateToNavigation()

                    // Optional tooltip
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Navigation")
                    ToolTip.delay: 500
                }
            }

            // Right section with icons and user profile
            Row {
                id: rightControls
                spacing: 10
                anchors {
                    right: parent.right
                    rightMargin: 40
                    verticalCenter: parent.verticalCenter
                }

                // Connection icons
                Row {
                    spacing: 2
                    IconButton {
                        iconHeight: 40
                        iconWidth: 40
                        roundIcon: true
                        setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/Light/Bluetooth.svg" : "qrc:/Icons/Dark/Bluetooth.svg"
                    }

                    IconButton {
                        iconHeight: 42
                        iconWidth: 42
                        roundIcon: true
                        setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/Light/Cell_Signal.svg" : "qrc:/Icons/Dark/Cell_Signal.svg"
                    }
                }

                // User profile
                Row {
                    spacing: 10

                    IconButton {
                        id: avatarButton
                        roundIcon: true
                        implicitHeight: 55
                        implicitWidth: 55
                        iconHeight: 42
                        iconWidth: 42
                        radius: 16
                        setIcon: "qrc:/Icons/mhx.png"
//                        enabled: false

                        // Full-screen window component
                        property var fullScreenImageWindow: null

                        // Add click handler to show full-screen image
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // Create full-screen window if it doesn't exist
                                if (!avatarButton.fullScreenImageWindow) {
                                    var component = Qt.createComponent("qrc:/Components/Avatar.qml");

                                    // Check if component is ready
                                    if (component.status === Component.Ready) {
                                        avatarButton.fullScreenImageWindow = component.createObject(null);

                                        // Check if object creation was successful
                                        if (avatarButton.fullScreenImageWindow) {
                                            avatarButton.fullScreenImageWindow.show();
                                        } else {
                                            console.error("Failed to create full-screen window object");
                                        }
                                    } else if (component.status === Component.Error) {
                                        console.error("Error creating component:", component.errorString());
                                    }
                                } else {
                                    // If window already exists, just show it
                                    avatarButton.fullScreenImageWindow.show();
                                }
                            }
                        }
                    }

                    Label {
                        text: qsTr("Hoang")
                        font {
                            pixelSize: 16
                            family: "Montserrat"
                            bold: Font.Normal
                        }
                        color: Theme.colors.text
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        // Main content area (transparent to show background)
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            // Your content here will appear over the background image
            // Make sure content has appropriate transparency or styling
            // to work well with the background image
        }

        LaunchPad {
            id: launchPad
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2 + footer.height - 20
        }
        // Footer
        Footer {
            id: footer
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            
            onOpenLaunchpad: launchPad.open()
            
            // Pass necessary properties for dialog positioning
            root: homeScreen.root
            leftArea: homeScreen.leftArea
            rightArea: homeScreen.rightArea
        }
    }
}
