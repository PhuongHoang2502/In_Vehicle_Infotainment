import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Theme 1.0
import "./Settings"

ApplicationWindow {
    id: root
    width: 1300
    height: 750
    minimumHeight: 750
    maximumHeight: 750
    minimumWidth: 1300
    maximumWidth: 1300
    flags: Qt.Dialog
    color: Theme.colors.background // Set window background to theme color

    Component {
        id: quickControl
        QuickControl {}
    }

    Component {
        id: autopilote
        Autopilote {}
    }

    Component {
        id: display
        Display {}
    }

    Component {
        id: driving
        Driving {}
    }

    Component {
        id: light
        Lights {}
    }

    Component {
        id: lock
        Lock {}
    }

    Component {
        id: safety
        SafetyAndSecurity {}
    }

    Component {
        id: service
        Service {}
    }

    Component {
        id: mapSettings
        MapThemes {}
    }

    function switchPage(index) {
        switch (index) {
        case 0:
            mainStack.replace(null, quickControl)
            break;
        case 1:
            mainStack.replace(null, light)
            break;
        case 2:
            mainStack.replace(null, lock)
            break;
        case 3:
            mainStack.replace(null, display)
            break;
        case 4:
            mainStack.replace(null, driving)
            break;
        case 5:
            mainStack.replace(null, autopilote)
            break;
        case 6:
            mainStack.replace(null, safety)
            break;
        case 7:
            mainStack.replace(null, service)
            break;
        case 8:
            mainStack.replace(null, mapSettings)
            break;
        }
    }

    Component.onCompleted: {
        Theme.updateTheme() // Force theme update on startup
        console.log("Initial theme:", Theme.currentTheme, "canController.light:", canController.light)
    }

    SplitView {
        id: splitView
        anchors.fill: parent
        orientation: Qt.Horizontal

        handle: Item {
            visible: false
        }

        Rectangle {
            id: mainRect
            color: Theme.colors.background
            SplitView.preferredWidth: 400
            SplitView.maximumWidth: 400
            SplitView.minimumWidth: 400

            ListView {
                id: listItemView
                anchors.fill: parent
                anchors.margins: 10
                focus: true
                spacing: 25
                highlightFollowsCurrentItem: true
                onCurrentIndexChanged: {
                    root.switchPage(currentIndex)
                }

                highlight: Item {
                    visible: false
                }

                model: SideListModel {}
                delegate: SideListDelegate {
                    width: listItemView.width
                    lightIconRectIcon: iconName
                    darkIconRectIcon: iconName.replace(Qt.resolvedUrl("qrc:/Icons/Settings/"), Qt.resolvedUrl("qrc:/Icons/Settings/light/"))
                    iconRectColor: iconColor
                    spacing: 50
                    onClicked: {
                        ListView.view.currentIndex = index
                        root.switchPage(index)
                    }
                }
            }
        }

        Rectangle {
            id: collapsibleRect
            SplitView.fillWidth: true
            color: Theme.colors.surface
            clip: true
            Loader {
                id: mainLoader
                anchors.fill: parent
                StackView {
                    id: mainStack
                    anchors.fill: parent
                    initialItem: QuickControl {}
                }
            }
        }
    }
}