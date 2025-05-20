import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true // Make the window visible from the start
    width: 1850 //800
    height: 900 //480
    title: "Vehicle Infotainment System"

    StackView {
        id: stackView
        anchors.fill: parent
        visible: true // Initially hide the StackView
        initialItem: homeScreen

        // Use fade transitions instead of slide
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }

//        VideoSplash {
//            id: splash
//            anchors.fill: parent
//            z: 1 // Ensure the splash is on top
//            onFinished: {
//                splash.visible = false // Hide the splash when done
//                stackView.visible = true // Show the main content
//                // Or transition to your main content if you prefer a smoother visual
//                // stackView.push(homeScreen)
//            }
//        }

    // Load screens as components
    Component {
        id: homeScreen
        HomeScreen {
            onNavigateToCluster: stackView.push(clusterScreen)
            onNavigateToNavigation: stackView.push(navigationScreen)
        }
    }

    Component {
        id: clusterScreen
        ClusterScreen {
            onNavigateToHome: stackView.replace(homeScreen)
            onNavigateToNavigation: stackView.replace(navigationScreen)
        }
    }

    Component {
        id: navigationScreen
        NavigationScreen {
            onNavigateToHome: stackView.replace(homeScreen)
            onNavigateToCluster: stackView.replace(clusterScreen)
        }
    }
    //quick open
    Component.onCompleted: {
        stackView.push(clusterScreen)
    }
}
