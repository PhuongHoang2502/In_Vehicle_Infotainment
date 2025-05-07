import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: clusterScreen
    color: "#e0e0e0"

    // Define signals for navigation
    signal navigateToHome()
    signal navigateToNavigation()

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Cluster Screen"
            font.pixelSize: 32
            font.bold: true
        }

        // Sample instrument cluster elements
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 40

            Rectangle {
                width: 150
                height: 150
                radius: 75
                color: "#303030"
                border.width: 2
                border.color: "#606060"

                Text {
                    anchors.centerIn: parent
                    text: "120"
                    color: "white"
                    font.pixelSize: 36
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.verticalCenter
                    anchors.topMargin: 20
                    text: "km/h"
                    color: "white"
                    font.pixelSize: 14
                }
            }

            Rectangle {
                width: 150
                height: 150
                radius: 75
                color: "#303030"
                border.width: 2
                border.color: "#606060"

                Text {
                    anchors.centerIn: parent
                    text: "3.5"
                    color: "white"
                    font.pixelSize: 36
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.verticalCenter
                    anchors.topMargin: 20
                    text: "x1000 rpm"
                    color: "white"
                    font.pixelSize: 14
                }
            }
        }

        Item { Layout.fillHeight: true }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Button {
                text: "Go to Home"
                Layout.preferredWidth: 180
                Layout.preferredHeight: 60
                font.pixelSize: 16

                onClicked: {
                    navigateToHome()
                }
            }

            Button {
                text: "Go to Navigation"
                Layout.preferredWidth: 180
                Layout.preferredHeight: 60
                font.pixelSize: 16

                onClicked: {
                    navigateToNavigation()
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
