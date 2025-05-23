import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./Components"

Rectangle {
    id: clusterScreen
    // Always use dark theme colors for this screen
    color: "#0a0909"
    // Store the previous theme to restore when leaving this screen
    property string previousTheme: Theme.currentTheme
    // Force dark theme on component completion
    Component.onCompleted: {
        previousTheme = Theme.currentTheme
        if (Theme.currentTheme !== "dark") {
            Theme.setManualTheme(false) // Set to dark mode
        }
    }
    // Restore previous theme when component is destroyed
    Component.onDestruction: {
        if (previousTheme !== "dark") {
            Theme.setManualTheme(true) // Restore to light mode if it was previously light
        }
    }
    
    // Define signals for navigation
    signal navigateToHome()
    signal navigateToNavigation()

    Image{
        anchors.fill: parent
        source: "qrc:/Image/Background.png"
    }

    Header {
        id: header
        width: parent.width
        height: 60
        color: "transparent"
        z: 2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            id: navigationButtons
            spacing: 32
            anchors.centerIn: parent

            property real iconSize: 40

            IconButton {
                id: homeBtn
                roundIcon: true
                iconHeight: navigationButtons.iconSize
                iconWidth: navigationButtons.iconSize
                setIcon: "qrc:/Icons/01_logobachkhoatoi.png"
                onClicked: navigateToHome()

                ToolTip.visible: hovered
                ToolTip.text: qsTr("Home")
                ToolTip.delay: 500
            }

            IconButton {
                id: clusterBtn
                roundIcon: true
                iconHeight: navigationButtons.iconSize + 15
                iconWidth: navigationButtons.iconSize + 15
                setIcon: "qrc:/Icons/Cluster.png"
                // Modified to toggle a local property instead of the global theme
                onClicked: {
                    // On cluster screen, toggle gauge colors
                    leftGauge.alternateMode = !leftGauge.alternateMode
                    rightGauge.alternateMode = !rightGauge.alternateMode
                    console.log("Toggled gauge mode: " + leftGauge.alternateMode)
                }

                ToolTip.visible: hovered
                ToolTip.text: qsTr("Toggle Gauge Colors")
                ToolTip.delay: 500
            }

            IconButton {
                id: naviBtn
                roundIcon: true
                iconHeight: navigationButtons.iconSize
                iconWidth: navigationButtons.iconSize
                setIcon: "qrc:/Icons/Navigation.png"
                setIconColor: Theme.colors.text
                onClicked: navigateToNavigation()

                ToolTip.visible: hovered
                ToolTip.text: qsTr("Navigation")
                ToolTip.delay: 500
            }
        }

        Row {
            id: rightControls
            spacing: 10
            anchors {
                right: parent.right
                rightMargin: 40
                verticalCenter: parent.verticalCenter
            }

            Row {
                spacing: 2
                IconButton {
                    iconHeight: 40
                    iconWidth: 40
                    roundIcon: true
                    setIcon: "qrc:/Icons/Light/Bluetooth.svg" // Always use light icons in dark mode
                }

                IconButton {
                    iconHeight: 42
                    iconWidth: 42
                    roundIcon: true
                    setIcon: "qrc:/Icons/Light/Cell_Signal.svg" // Always use light icons in dark mode
                }
            }

            Row {
                spacing: 10
                IconButton {
                    roundIcon: true
                    implicitHeight: 55
                    implicitWidth: 55
                    iconHeight: 42
                    iconWidth: 42
                    radius: 16
                    setIcon: "qrc:/Icons/mhx.png"
                    enabled: false
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
    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        z: 1

        Gauge {
            id: leftGauge
            value: canController.speed / 60
            property bool alternateMode: false
            speedColor: alternateMode ? "#01a1e6" : "#e60101"
            speedUnit: "x1000r/min"
            textSize: 65
            gradientColors: alternateMode ? 
                ["#01a1e6", "#01dcf0", "#01f0dc", "#01e680"] : 
                ["#e60101", "#e65c01", "#e69c01", "#e6bb01"]
                
            // Observe alternateMode changes and force redraw
            onAlternateModeChanged: {
                // Force repaint of Canvas
                console.log("Left gauge mode changed: " + alternateMode)
            }
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width / 11
            }
            width: 400
            height: 400
            maximumValue: 10
            Component.onCompleted: forceActiveFocus()
            Behavior on value { NumberAnimation { duration: 1000 }}
        }

        Gauge {
            id: rightGauge
            value: canController.speed
            property bool alternateMode: false
            speedColor: alternateMode ? "#e60101" : "#01a1e6"
            speedUnit: "km/h"
            displayText: value.toFixed(0)
            textSize: 65
            gradientColors: alternateMode ? 
                ["#e60101", "#e65c01", "#e69c01", "#e6bb01"] : 
                ["#01a1e6", "#01dcf0", "#01f0dc", "#01e680"]
                
            // Observe alternateMode changes and force redraw
            onAlternateModeChanged: {
                // Force repaint of Canvas
                console.log("Right gauge mode changed: " + alternateMode)
            }
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: parent.width /11
            }
            width: 400
            height: 400
            maximumValue: 400
            Behavior on value { NumberAnimation { duration: 1000 }}
        }
    }

    // LaunchPad {
    //     id: launchPad
    //     x: (parent.width - width) / 2
    //     y: parent.height - footer.height - height
    //     z: 3 // Above content and footer
    // }

    // Footer {
    //     id: footer
    //     width: parent.width
    //     height: 120
    //     anchors.bottom: parent.bottom
    //     z: 2 // Same as header, above content
    //     onOpenLaunchpad: launchPad.open()
    // }
}
