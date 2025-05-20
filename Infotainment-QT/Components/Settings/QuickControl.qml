import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "../"
import App.Theme 1.0
Item {

    ColumnLayout{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 40
        anchors.topMargin: 40
        spacing: 50

        ColumnLayout{
            spacing: 10

            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                IconButton{
                    setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/display.svg" : "qrc:/Icons/Dark/display.svg"
                }

                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Display Brightness"
                    Layout.fillWidth: true
                    font.pixelSize: 20
                    font.family: "Montserrat"
                    color: Theme.colors.text
                }
            }

            TSlider{
                width: 680
                height: 60
                checkedColor: Theme.isDarkMode ? "grey" : "#FFFFFF"
                from:0
                to:100
                stepSize: 1
                value: 10
            }
        }

        ColumnLayout{
            spacing: 10
            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                IconButton{
                    setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/headlights-small.svg" : "qrc:/Icons/Dark/headlights-small.svg"
                }

                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Exterior Lights"
                    Layout.fillWidth: true
                    font.pixelSize: 20
                    font.family: "Montserrat"
                    color: Theme.colors.text
                }
            }

            LabelSelector{
                lableList:  ["On" ,"Off","Parking","Auto"]
            }
            TButton{
               implicitWidth: 220
               implicitHeight: 60
               text: qsTr("Front fog")
            }
        }

        ColumnLayout{
            spacing: 10
            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                IconButton{
                    setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/adjustments.svg" : "qrc:/Icons/Dark/adjustments.svg"
                }

                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Adjustments"
                    Layout.fillWidth: true
                    font.pixelSize: 20
                    font.family: "Montserrat"
                    color: Theme.colors.text
                }
            }

            RowLayout{
                spacing: 30
                Rectangle{
                    height: 117
                    width: 330
                    radius: 50
                    color: Theme.isDarkMode ? "grey" : "#FFFFFF"
                    ColumnLayout{
                        spacing: 10
                        anchors.centerIn: parent
                        RowLayout{
                            Layout.alignment: Qt.AlignHCenter
                            IconButton{
                                setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/mirror.svg" : "qrc:/Icons/Dark/mirror.svg"
                            }

                            IconButton{
                                isMirror: true
                                setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/mirror.svg" : "qrc:/Icons/Dark/mirror.svg"
                            }
                        }

                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Mirrors"
                            font.pixelSize: 20
                            font.family: "Montserrat"
                            color: Theme.colors.text
                        }
                    }
                }

                Rectangle{
                    height: 117
                    width: 330
                    radius: 50
                    color: Theme.isDarkMode ? "grey" : "#FFFFFF"

                    ColumnLayout{
                        anchors.centerIn: parent
                        spacing: 10
                        IconButton{
                            Layout.alignment: Qt.AlignHCenter
                            setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/steering wheel-small.svg" : "qrc:/Icons/Dark/steering wheel-small.svg"
                        }

                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Steering Wheel"
                            font.pixelSize: 20
                            font.family: "Montserrat"
                            color: Theme.colors.text
                        }
                    }
                }
            }

            TButton{
               implicitWidth: 220
               implicitHeight: 60
               text: qsTr("Fold Mirrors")
            }
        }

    }
}
