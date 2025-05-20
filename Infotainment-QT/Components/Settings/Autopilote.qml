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

            Label {
                text: "Cruise Follow Distance"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Montserrat"
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colors.text
            }

            RowLayout{
                spacing: 10
                IconButton{
                    id:minus
                    setIcon:Theme.isDarkMode ? "qrc:/Icons/Light/minus.svg" : "qrc:/Icons/Dark/minus.svg"
                    Layout.alignment: Qt.AlignVCenter
                    onClicked: {
                        var number = parseInt(cruise_Control.text)
                        number = number - 1
                        cruise_Control.text = number
                    }
                }

                Rectangle{
                    border.width: 4
                    border.color: "grey"
                    color: "transparent"
                    width: minus.width
                    height: minus.height
                    radius: height/2
                    Layout.alignment: Qt.AlignVCenter
                    Label{
                        id:cruise_Control
                        text: "5"
                        opacity: 0.4
                        font.pixelSize: 24
                        font.family: "Montserrat"
                        font.bold: Font.DemiBold
                        color: Theme.colors.text
                        anchors.centerIn: parent
                    }
                }

                IconButton{
                    id:plus
                    setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/plus.svg" : "qrc:/Icons/Dark/plus.svg"
                    Layout.alignment: Qt.AlignVCenter
                    onClicked: {
                        var number = parseInt(cruise_Control.text)
                        number = number + 1
                        cruise_Control.text = number
                    }
                }
            }
        }
        RowLayout{
            spacing: 10
            TSwitch{
                checkedColor: "#228BE6"
                checked: true
            }

            Label {
                text: "Autosteer"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Montserrat"
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colors.text
            }
        }

        RowLayout{
            spacing: 10
            TSwitch{
                checkedColor: "#228BE6"
                checked: false
            }

            Label {
                text: "Auto Lane Change"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Montserrat"
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colors.text
            }
        }
    }
}
