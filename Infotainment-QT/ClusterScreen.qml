import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./Components"

Rectangle {
    id: clusterScreen
    color: Theme.currentTheme === "dark" ? "#0E0E0E" : "#F1F1F1"

    // Define signals for navigation
    signal navigateToHome()
    signal navigateToNavigation()

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
                onClicked: Theme.setManualTheme(Theme.currentTheme === "dark")

                ToolTip.visible: hovered
                ToolTip.text: Theme.currentTheme === "dark" ? qsTr("Switch to Light Mode") : qsTr("Switch to Dark Mode")
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
    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        z: 1

        Gauge {
            id:leftGauge
            speedColor: currentTheme === "dark" ? "#e60101" : "#0114e6"
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width / 11
            }
            property bool accelerating
            width: 400
            height: 400
            value: accelerating ? maximumValue : 0
            maximumValue: 250
            Component.onCompleted: forceActiveFocus()
            Behavior on value { NumberAnimation { duration: 1000 }}

            Keys.onSpacePressed: accelerating = true
            Keys.onReturnPressed: rightGauge.accelerating = true
            Keys.onReleased: {
                if (event.key === Qt.Key_Space) {
                    accelerating = false;
                    event.accepted = true;
                }else if(event.key === Qt.Key_Return){
                    rightGauge.accelerating = false;
                    event.accepted = true;
                }
            }
        }

        Gauge {
            id:rightGauge
            speedColor: currentTheme === "dark" ? "#01a1e6" : "#e60101" //"#01E6DC" : "#01E6DC"
            speedUnit: "RPM"
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: parent.width /11
            }
            property bool accelerating
            width: 400
            height: 400
            value: accelerating ? maximumValue : 0
            maximumValue: 250
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
