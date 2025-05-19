import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtLocation 5.15
import QtPositioning 5.15
import "./Components"

Rectangle {
    id: navigationScreen
    color: Theme.currentTheme === "dark" ? "#0E0E0E" : "#F1F1F1"

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
        anchors.bottom: parent.bottom
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
                header: Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.topMargin: 60
                    width: parent.width
                    height: 100
                    color: "transparent"

                    RowLayout {
                        spacing: 2
                        anchors {
                            bottom: parent.bottom
                            bottomMargin: 5
                            left: parent.left
                            right: parent.right
                        }
                        IconButton {
                            id: lowBeam
                            iconHeight: 40
                            iconWidth: 40
                            roundIcon: true
                            setIcon: "qrc:/Icons/Low_Beam.svg"
                            opacity: canController.headlight === 1 ? 1 : 0.3
                            anchors.leftMargin: 20
                            anchors.left: parent.left
                            onClicked: (canController.autoMode && canController.headlight === 1) ? canController.toggleAutoMode() : canController.toggleLowBeam()
                        }
                        IconButton {
                            anchors.left: lowBeam.right
                            anchors.leftMargin: 2
                            iconHeight: 40
                            iconWidth: 40
                            roundIcon: true
                            setIcon: "qrc:/Icons/High_Beam.png"
                            opacity: canController.headlight === 2 ? 1 : 0.3
                            onClicked: (canController.autoMode && canController.headlight === 2) ? canController.toggleAutoMode() : canController.toggleHighBeam()
                        }
                        IconButton {
                            iconHeight: 40
                            iconWidth: 40
                            roundIcon: true
                            setIcon: "qrc:/Icons/Auto_Light.svg"
                            opacity: canController.autoMode ? 1 : 0.3
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                            onClicked: canController.toggleAutoMode()
                        }
                        Label {
                            text: canController.speed
                            font.pixelSize: 45
                            font.family: "Montserrat"
                            font.bold: Font.Normal
                            color: Theme.currentTheme === "dark" ? "#FFFFFF" : "#0E0E0E"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Rectangle {
                        id: line
                        color: "grey"
                        height: 2
                        width: parent.width - 20
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                    }
                    IconButton {
                        id: leftTurnButton
                        anchors.top: line.bottom
                        anchors.topMargin: 10
                        iconHeight: 40
                        iconWidth: 40
                        roundIcon: true
                        setIcon: "qrc:/Icons/Left.svg"
                        opacity: 0.3
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        onClicked: canController.toggleLeftTurn()
                        // Blinking animation when left turn is on
                        SequentialAnimation {
                            id: leftTurnAnimation
                            running: canController.leftTurn
                            loops: Animation.Infinite
                            NumberAnimation {
                                target: leftTurnButton
                                property: "opacity"
                                to: 1
                                duration: 300 // 0.25s
                            }
                            NumberAnimation {
                                target: leftTurnButton
                                property: "opacity"
                                to: 0.3
                                duration: 300 // 0.25s
                            }
                            onStopped: {
                                leftTurnButton.opacity = 0.3
                            }
                        }
                    }
                    IconButton {
                        id: rightTurnButton
                        anchors.top: line.bottom
                        anchors.topMargin: 10
                        iconHeight: 40
                        iconWidth: 40
                        roundIcon: true
                        setIcon: "qrc:/Icons/Right.svg"
                        opacity: 0.3
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        onClicked: canController.toggleRightTurn()
                        // Blinking animation when right turn is on
                        SequentialAnimation {
                            id: rightTurnAnimation
                            running: canController.rightTurn
                            loops: Animation.Infinite
                            NumberAnimation {
                                target: rightTurnButton
                                property: "opacity"
                                to: 1
                                duration: 300 // 0.25s
                            }
                            NumberAnimation {
                                target: rightTurnButton
                                property: "opacity"
                                to: 0.3
                                duration: 300 // 0.25s
                            }
                            onStopped: {
                                rightTurnButton.opacity = 0.3
                            }
                        }
                    }
                }
                contentItem: Item {
                    anchors.fill: parent

                    SwipeView {
                        id: view
                        anchors.fill: parent
                        currentIndex: 1
                        clip: true
                        spacing: 0

                        Item {
                            id: firstPage
                            Image {
                                source: Theme.currentTheme === "dark" ? "qrc:/Image/Dark/Sidebar.png" : "qrc:/Image/Light/Sidebar.png"
                                fillMode: Image.PreserveAspectCrop
                                width: parent.width
                                anchors.centerIn: parent
                            }
                        }

                        Item {
                            id: secondPage
                            Image {
                                source: Theme.currentTheme === "dark" ? "qrc:/Image/Dark/Sidebar2.png" : "qrc:/Image/Light/Sidebar2.png"
                                fillMode: Image.PreserveAspectFit
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 235
                                width: Math.min(parent.width, sourceSize.width)
                                height: Math.min(parent.height, sourceSize.height)
                            }
                        }

                        Item {
                            id: thirdPage
                            Image {
                                id: glow
                                smooth: true
                                visible: canController.headlight
                                source: "qrc:/Image/headlights.png"
                                anchors.bottom: model3.top
                                anchors.horizontalCenter: model3.horizontalCenter
                                anchors.bottomMargin: -60
                            }

                            Image {
                                id: model3
                                source: "qrc:/Image/model 3-1_new.svg"
                                // source: Theme.currentTheme === "dark" ? "qrc:/Image/model 3_new.svg" : "qrc:/Image/model 3-1_new.svg"
                                fillMode: Image.PreserveAspectFit
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 235
                                width: Math.min(parent.width, sourceSize.width)
                                height: Math.min(parent.height, sourceSize.height)
                            }
                        }
                    }

                    GearSelector {
                        id: gearSelector
                        radius: 16
                        setColors: "#439df3"
                        selectedIndex: canController.gear
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 170
                        labelList: ["P", "R", "N", "D"]
                        z: 3
                    }

                    PageIndicator {
                        id: pageIndicator
                        z: 2
                        count: view.count
                        currentIndex: view.currentIndex
                        interactive: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: gearSelector.bottom
                        anchors.topMargin: 20
                        delegate: Rectangle {
                            width: 8
                            height: 8
                            radius: 4
                            color: index === pageIndicator.currentIndex
                                    ? (Theme.currentTheme === "dark" ? "#FFFFFF" : "#0E0E0E")
                                    : (Theme.currentTheme === "dark" ? "#666666" : "#999999")
                            opacity: index === pageIndicator.currentIndex ? 1.0 : 0.5
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
                    spacing: 2
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
                        color: Theme.currentTheme === "dark" ? "#3f3f3f" : "#F1F1F1"
                        visible: canController.gear !== 1
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
                                implicitWidth: 45
                                implicitHeight: 45
                                setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/plus.svg" : "qrc:/Icons/Dark/plus.svg"
                                onClicked: {
                                if (rightAreaContent.item && canController.gear !== 1) {
                                    rightAreaContent.item.zoomIn()
                                }
                            }
                            }

                            IconButton {
                                implicitWidth: 45
                                implicitHeight: 45
                                setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/minus.svg" : "qrc:/Icons/Dark/minus.svg"
                                onClicked: {
                                if (rightAreaContent.item && canController.gear !== 1) {
                                    rightAreaContent.item.zoomOut()
                                }
                            }
                            }
                        }
                    }

                    Rectangle {
                        id: settingsButton
                        anchors.top: zoomInOut.bottom
                        anchors.topMargin: 20
                        implicitHeight: 75
                        implicitWidth: 75
                        radius: 20
                        color: Theme.currentTheme === "dark" ? "#3f3f3f" : "#F1F1F1"
                        visible: canController.gear !== 1
                        IconButton {
                            iconWidth: 28
                            iconHeight: 28
                            roundIcon: true
                            anchors.centerIn: parent
                            setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/gear.svg" : "qrc:/Icons/Dark/gear.svg"
                            onClicked: footer.createSettingDialog()
                        }
                    }

                    Rectangle {
                        id: navigationButton
                        anchors.top: settingsButton.bottom
                        anchors.topMargin: 20
                        implicitHeight: 75
                        implicitWidth: 75
                        radius: 20
                        color: Theme.currentTheme === "dark" ? "#3f3f3f" : "#F1F1F1"
                        visible: canController.gear !== 1
                        IconButton {
                            rotation: -90
                            iconWidth: 42
                            iconHeight: 42
                            roundIcon: true
                            anchors.centerIn: parent
                            setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/navigation.svg" : "qrc:/Icons/Dark/navigation.svg"
                            onClicked: {
                                if (rightAreaContent.item && canController.gear !== 1) {
                                    rightAreaContent.item.startSimulation()
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: currentLocationButton
                        anchors.top: navigationButton.bottom
                        anchors.topMargin: 20
                        implicitHeight: 75
                        implicitWidth: 75
                        radius: 20
                        color: Theme.currentTheme === "dark" ? "#3f3f3f" : "#F1F1F1"
                        visible: canController.gear !== 1
                        IconButton {
                            iconWidth: 24
                            iconHeight: 24
                            rotation: -90
                            anchors.centerIn: parent
                            setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/current_location.svg" : "qrc:/Icons/Dark/current_location.svg"
                            onClicked: {
                                if (rightAreaContent.item && canController.gear !== 1) {
                                    rightAreaContent.item.showFullRoute()
                                }
                            }
                        }
                    }
                }

                Loader {
                    id: rightAreaContent
                    anchors.fill: parent
                    sourceComponent: canController.gear === 1 ? reverseImageComponent : mapComponent
                    clip: true
                }

                Component {
                    id: mapComponent
                    NavigationMap {
                        id: mapView
                        z: 1
                        anchors.fill: parent
                    }
                }

                Component {
                    id: reverseImageComponent
                    Rectangle {
                        anchors.fill: parent
                        anchors.bottomMargin: Theme.currentTheme === "dark" ? 120 : 0
                        color: Theme.currentTheme === "dark" ? "#121212" : "#F1F1F1"

                        Image {
                            id: reverseImage
                            source: Theme.currentTheme === "dark" ? "qrc:/Image/Guide_line.png" : "qrc:/Image/rvc_example.jpg"
                            fillMode: Image.PreserveAspectFit
                            height: parent.height
                            width: sourceSize.width * (parent.height / sourceSize.height)
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
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
    }
}
