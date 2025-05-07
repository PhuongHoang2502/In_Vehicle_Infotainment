import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: navigationScreen
    color: "#e8e8f0"

    // Define signals for navigation
    signal navigateToHome()
    signal navigateToCluster()

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Navigation Screen"
            font.pixelSize: 32
            font.bold: true
        }

        // Mock map
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 600
            height: 250
            color: "#c0c0c0"

            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: parent.height * 0.8
                color: "#a0a0a0"

                Rectangle {
                    width: 10
                    height: parent.height * 0.6
                    color: "#ffffff"
                    anchors.centerIn: parent

                    Rectangle {
                        width: parent.width * 2.5
                        height: parent.width * 2.5
                        radius: width/2
                        color: "red"
                        anchors.centerIn: parent
                    }
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
                text: "Go to Cluster"
                Layout.preferredWidth: 180
                Layout.preferredHeight: 60
                font.pixelSize: 16

                onClicked: {
                    navigateToCluster()
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
