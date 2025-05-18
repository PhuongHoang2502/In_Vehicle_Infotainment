import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import App.Theme 1.0

Pane {
    id: control
    padding: 0
    leftInset: 0
    rightInset: 0
    property string setColors: Theme.currentTheme === "dark" ? "grey" : "#FFFFFF"
    property real radius: implicitHeight / 2
    property int allowMaxTags: 5
    property var labelList: ["P", "R", "N", "D"]
    property int selectedIndex: 0
    implicitWidth: layout.implicitWidth
    implicitHeight: 60

    background: Rectangle {
        implicitHeight: control.implicitHeight
        implicitWidth: control.implicitWidth
        color: Theme.colors.background
        radius: control.radius
    }

    RowLayout {
        id: layout
        spacing: 0
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: rep
            Layout.alignment: Qt.AlignHCenter
            model: Math.min(control.labelList.length, control.allowMaxTags)

            delegate: Item {
                id: labelIndicator
                implicitWidth: contentRect.implicitWidth
                implicitHeight: contentRect.implicitHeight

                Rectangle {
                    id: contentRect
                    implicitHeight: control.implicitHeight - 1
                    implicitWidth: tags.implicitWidth + 100
                    radius: control.radius
                    color: index === control.selectedIndex ? control.setColors : "transparent"

                    Label {
                        id: tags
                        text: control.labelList[index]
                        font.pixelSize: 20
                        font.family: "Montserrat"
                        color: Theme.colors.text
                        anchors.centerIn: parent
                        font.bold: true
                    }
                }
            }
        }
    }
}