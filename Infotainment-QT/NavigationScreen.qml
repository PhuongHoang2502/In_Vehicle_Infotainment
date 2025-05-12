import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtLocation 5.15
import QtPositioning 5.15
import "./Components"

Rectangle {
    id: navigationScreen
    color: "transparent"

    // Define signals for navigation
    signal navigateToHome()
    signal navigateToCluster()

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
                id: clusterBtn
                roundIcon: true
                iconHeight: navigationButtons.iconSize + 15
                iconWidth: navigationButtons.iconSize + 15
                setIcon: "qrc:/Icons/Cluster.png"
                onClicked: navigateToCluster()

                ToolTip.visible: hovered
                ToolTip.text: qsTr("Cluster")
                ToolTip.delay: 500
            }

            IconButton {
                id: naviBtn
                roundIcon: true
                iconHeight: navigationButtons.iconSize
                iconWidth: navigationButtons.iconSize
                setIcon: "qrc:/Icons/Navigation.png"
                setIconColor: Theme.colors.text
                onClicked: Theme.setManualTheme(Theme.currentTheme === "dark")

                ToolTip.visible: hovered
                ToolTip.text: Theme.currentTheme === "dark" ? qsTr("Switch to Light Mode") : qsTr("Switch to Dark Mode")
                ToolTip.delay: 500
            }

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
                    setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/Light/Bluetooth.svg" : "qrc:/Icons/Dark/Bluetooth.svg"
                }

                IconButton {
                    iconHeight: 42
                    iconWidth: 42
                    roundIcon: true
                    setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/Light/Cell_Signal.svg" : "qrc:/Icons/Dark/Cell_Signal.svg"
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

    // Main content area (constrained to avoid footer overlap)
    Item {
        anchors.top: parent.top
        anchors.bottom: footer.top
        anchors.left: parent.left
        anchors.right: parent.right
        z: 1

        RowLayout {
            anchors.fill: parent
            spacing: 0

            // Left Area (Single Page)
            Page {
                id: leftArea
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.3
                background: Rectangle {
                    anchors.fill: parent
                    color: Theme.currentTheme === "dark" ? "#0E0E0E" : "#F1F1F1"
                }

                contentItem: ColumnLayout {
                    anchors.fill: parent
                    anchors.topMargin: 60 // Offset content below header
                    spacing: 0

                    // Top bar (Auto_Light buttons)
                    Rectangle {
                        Layout.fillWidth: true
                        height: 60
                        color: "transparent"

                        IconButton {
                            iconHeight: 40
                            iconWidth: 40
                            roundIcon: true
                            setIcon: "qrc:/Icons/Auto_Light.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                        }
                        IconButton {
                            iconHeight: 40
                            iconWidth: 40
                            roundIcon: true
                            setIcon: "qrc:/Icons/Auto_Light2.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                        }
                    }

                    // Gear and speed display
                    Rectangle {
                        Layout.fillWidth: true
                        height: 149
                        color: "transparent"

                        RowLayout {
                            spacing: 27
                            anchors {
                                bottom: parent.bottom
                                bottomMargin: 10
                                left: parent.left
                                leftMargin: 20
                            }

                            Label {
                                text: "R"
                                opacity: 0.4
                                font.pixelSize: 20
                                font.family: "Montserrat"
                                font.bold: Font.Normal
                                color: Theme.fontColor
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Label {
                                text: "P"
                                opacity: 0.4
                                font.pixelSize: 20
                                font.family: "Montserrat"
                                font.bold: Font.Normal
                                color: Theme.fontColor
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Label {
                                text: "N"
                                opacity: 0.4
                                font.pixelSize: 20
                                font.family: "Montserrat"
                                font.bold: Font.Normal
                                color: Theme.fontColor
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Label {
                                text: "D"
                                font.pixelSize: 20
                                font.family: "Montserrat"
                                font.bold: Font.Normal
                                color: Theme.fontColor
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }

                        Label {
                            text: "160"
                            font.pixelSize: 45
                            font.family: "Montserrat"
                            font.bold: Font.Normal
                            color: Theme.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: mphLabel.top
                            anchors.bottomMargin: 5
                        }

                        Label {
                            id: mphLabel
                            text: "MPH"
                            opacity: 0.4
                            font.pixelSize: 20
                            font.family: "Montserrat"
                            font.bold: Font.Normal
                            color: Theme.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                        }

                        RowLayout {
                            spacing: 10
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            Label {
                                text: "90 %"
                                opacity: 0.4
                                font.pixelSize: 20
                                font.family: "Montserrat"
                                font.bold: Font.Normal
                                color: Theme.fontColor
                                Layout.alignment: Qt.AlignVCenter
                            }

                            IconButton {
                                Layout.alignment: Qt.AlignVCenter
                                iconHeight: 40
                                iconWidth: 40
                                roundIcon: true
                                setIcon: "qrc:/Icons/High_Beam.png"
                            }
                        }

                        Rectangle {
                            color: "grey"
                            height: 2
                            width: parent.width - 20
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                        }
                    }

                    // Cruise control section
                    Rectangle {
                        Layout.fillWidth: true
                        height: 80
                        color: "transparent"

                        IconButton {
                            iconHeight: 40
                            iconWidth: 40
                            roundIcon: true
                            setIcon: "qrc:/Icons/Low_Beam.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                        }

                        RowLayout {
                            spacing: 10
                            anchors.centerIn: parent
                            IconButton {
                                id: minus
                                setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/unknown/dark/minus.svg" : "qrc:/Icons/unknown/light/minus.svg"
                                Layout.alignment: Qt.AlignVCenter
                                onClicked: {
                                    var number = parseInt(cruise_Control.text)
                                    number = number - 1
                                    cruise_Control.text = number
                                }
                            }
                            Rectangle {
                                border.width: 4
                                border.color: "grey"
                                color: "transparent"
                                width: minus.width
                                height: minus.height
                                radius: height/2
                                Layout.alignment: Qt.AlignVCenter
                                Label {
                                    id: cruise_Control
                                    text: "30"
                                    opacity: 0.4
                                    font.pixelSize: 24
                                    font.family: "Montserrat"
                                    font.bold: Font.DemiBold
                                    color: Theme.fontColor
                                    anchors.centerIn: parent
                                }
                            }

                            IconButton {
                                id: plus
                                setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/unknown/dark/plus.svg" : "qrc:/Icons/unknown/light/plus.svg"
                                Layout.alignment: Qt.AlignVCenter
                                onClicked: {
                                    var number = parseInt(cruise_Control.text)
                                    number = number + 1
                                    cruise_Control.text = number
                                }
                            }
                        }

                        IconButton {
                            iconHeight: 40
                            iconWidth: 40
                            roundIcon: true
                            setIcon: "qrc:/Icons/Low_Beam.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                        }
                    }

                    // SwipeView for main content
                    SwipeView {
                        id: view
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        currentIndex: 1
                        clip: true

                        Item {
                            id: firstPage
                            Image {
                                source: Theme.currentTheme === "dark" ? "qrc:/Image/Dark/Sidebar.png" : "qrc:/Image/Light/Sidebar.png"
                                fillMode: Image.PreserveAspectFit
                                anchors.centerIn: parent
                                width: Math.min(parent.width, sourceSize.width)
                                height: Math.min(parent.height, sourceSize.height)
                            }
                        }

                        Item {
                            id: secondPage
                            Image {
                                source: Theme.currentTheme === "dark" ? "qrc:/Image/Dark/Sidebar2.png" : "qrc:/Image/Light/Sidebar2.png"
                                fillMode: Image.PreserveAspectFit
                                anchors.centerIn: parent
                                width: Math.min(parent.width, sourceSize.width)
                                height: Math.min(parent.height, sourceSize.height)
                            }
                        }

                        Item {
                            id: thirdPage
                            Image {
                                id: glow
                                smooth: true
                                visible: Theme.currentTheme === "dark"
                                source: "qrc:/Image/headlights.png"
                                anchors.bottom: model3.top
                                anchors.horizontalCenter: model3.horizontalCenter
                                anchors.bottomMargin: -60
                            }

                            Image {
                                id: model3
                                source: Theme.currentTheme === "dark" ? "qrc:/Image/model 3_new.svg" : "qrc:/Image/model 3-1_new.svg"
                                fillMode: Image.PreserveAspectFit
                                anchors.centerIn: parent
                                width: Math.min(parent.width, sourceSize.width)
                                height: Math.min(parent.height, sourceSize.height)
                            }
                        }
                    }

                    // Button footer (camera, power, microphone)
                    Rectangle {
                        Layout.fillWidth: true
                        height: 120
                        color: "transparent"

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 100
                            IconButton {
                                setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/camera.svg" : "qrc:/Icons/dark/camera.svg"
                            }
                            IconButton {
                                setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/power.svg" : "qrc:/Icons/dark/power.svg"
                            }
                            IconButton {
                                setIcon: Theme.currentTheme === "dark" ? "qrc:/Icons/microphone.svg" : "qrc:/Icons/dark/microphone.svg"
                            }
                        }
                    }

                    // Page Indicator
                    Item {
                        Layout.fillWidth: true
                        height: 40
                        z: 3

                        PageIndicator {
                            id: pageIndicator
                            count: view.count
                            currentIndex: view.currentIndex
                            interactive: true
                            anchors.centerIn: parent
                        }
                    }
                }
            }

            // Right Area (Map)
            Item {
                id: rightArea
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    z: 2
                    spacing: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 60 // Offset below header
                    anchors.bottom: parent.bottom

                    Rectangle {
                        id: zoomInOut
                        implicitHeight: 160
                        implicitWidth: 75
                        radius: 20
                        color: Theme.isDarkMode ? "#1c1d21" : "#FFFFFF"
                        Rectangle {
                            z: 2
                            width: zoomInOut.width - 15
                            color: "grey"
                            height: 1
                            anchors.centerIn: parent
                        }

                        ColumnLayout {
                            z: 1
                            anchors.centerIn: parent
                            spacing: 20
                            IconButton {
                                implicitWidth: 60
                                implicitHeight: 60
                                setIcon: Theme.isDarkMode ? "qrc:/Icons/unknown/dark/plus.svg" : "qrc:/Icons/unknown/light/plus.svg"
                                onClicked: mapView.zoomIn()
                            }

                            IconButton {
                                implicitWidth: 60
                                implicitHeight: 60
                                setIcon: Theme.isDarkMode ? "qrc:/Icons/unknown/dark/minus.svg" : "qrc:/Icons/unknown/light/minus.svg"
                                onClicked: mapView.zoomOut()
                            }
                        }
                    }

                    Rectangle {
                        implicitHeight: 75
                        implicitWidth: 75
                        radius: 20
                        color: Theme.isDarkMode ? "#1c1d21" : "#FFFFFF"
                        IconButton {
                            iconWidth: 28
                            iconHeight: 28
                            roundIcon: true
                            anchors.centerIn: parent
                            setIcon: Theme.isDarkMode ? "qrc:/Icons/dark/gear.svg" : "qrc:/Icons/gear.svg"
                            onClicked: createSettingsDialog()
                        }
                    }

                    Rectangle {
                        implicitHeight: 75
                        implicitWidth: 75
                        radius: 20
                        color: Theme.isDarkMode ? "#1c1d21" : "#FFFFFF"
                        IconButton {
                            rotation: -90
                            iconWidth: 42
                            iconHeight: 42
                            roundIcon: true
                            anchors.centerIn: parent
                            setIcon: Theme.isDarkMode ? "qrc:/Icons/navigation_light.svg" : "qrc:/Icons/navigation_dark.svg"
                            onClicked: {
                                routingService.update()
                            }
                        }
                    }

                    Rectangle {
                        implicitHeight: 75
                        implicitWidth: 75
                        radius: 20
                        color: Theme.isDarkMode ? "#1c1d21" : "#FFFFFF"
                        IconButton {
                            iconWidth: 24
                            iconHeight: 24
                            rotation: -90
                            anchors.centerIn: parent
                            setIcon: Theme.isDarkMode ? "qrc:/Icons/current_location_dark.svg" : "qrc:/Icons/current_location_light.svg"
                            onClicked: {
                                navigation.active = !navigation.active
                            }
                        }
                    }
                }

                Map {
                    id: mapView
                    z: 1
                    clip: true
                    width: parent.width - 5
                    height: parent.height - 5
                    anchors.centerIn: parent

                    plugin: Plugin {
                        name: "osm"
                    }

                    center: QtPositioning.coordinate(28.7041, 77.1025)
                    zoomLevel: 14

                    MapItemView {
                        model: routeModel
                        delegate: MapRoute {
                            route: routeData
                            line.color: "#95c1e6"
                            line.width: 4
                            smooth: true
                            opacity: 0.8
                        }
                    }
                }

                RouteQuery {
                    id: routeQuery
                }

                RouteModel {
                    id: routeModel
                    plugin: mapView.plugin
                    query: routeQuery
                    autoUpdate: false
                }
            }
        }
    }

    LaunchPad {
        id: launchPad
        x: (parent.width - width) / 2
        y: parent.height - footer.height - height
        z: 3 // Above content and footer
    }

    Footer {
        id: footer
        width: parent.width
        height: 120
        anchors.bottom: parent.bottom
        z: 2 // Same as header, above content
        onOpenLaunchpad: launchPad.open()

        root: homeScreen.root
        leftArea: homeScreen.leftArea
        rightArea: homeScreen.rightArea
    }
}
