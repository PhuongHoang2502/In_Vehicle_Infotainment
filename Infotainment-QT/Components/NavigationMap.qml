import QtQuick 2.15
import QtLocation 5.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import QtPositioning 5.15
import App.Theme 1.0

Rectangle {
    id: navigationMap
    color: Theme.currentTheme === "dark" ? "#121212" : "#F1F1F1"
    visible: true
    clip: true

    property var currentLoc: QtPositioning.coordinate(10.773108, 106.658892)
    property var destinationLoc: QtPositioning.coordinate(10.880106, 106.804759)
    property bool isRoutingStart: false
    property bool isShowingFullRoute: false
    property bool enableGradient: true
    property real defaultZoomLevel: 13.3
    property var activeMap: null
    property bool mapsInitialized: false
    property var currentLocationMarker: null
    property var destinationMarker: null
    property var startMarker: null

    // Dark map instance
    DynamicMap {
        id: darkMap
        // styleUrl: "mapbox://styles/mapbox/outdoors-v12"
        styleUrl: "mapbox://styles/mapbox/navigation-night-v1"
        // styleUrl: "mapbox://styles/mapbox/dark-v10"
        anchors.fill: parent
        visible: Theme.currentTheme === "dark"
        gesture.enabled: !isRoutingStart
        onVisibleChanged: {
            if (visible && !mapsInitialized) {
                navigationMap.initializeMap()
            }
        }
        Component.onCompleted: console.log("DarkMap initialized")
    }

    // Light map instance
    DynamicMap {
        id: lightMap
        // styleUrl: "mapbox://styles/mapbox/outdoors-v12"
        styleUrl: "mapbox://styles/mapbox/streets-v11"
        anchors.fill: parent
        visible: Theme.currentTheme === "light"
        gesture.enabled: !isRoutingStart
        onVisibleChanged: {
            if (visible && !mapsInitialized) {
                navigationMap.initializeMap()
            }
        }
        Component.onCompleted: console.log("LightMap initialized")
    }

    // Initialize map after a short delay to ensure components are ready
    Timer {
        id: initTimer
        interval: 1000
        running: true
        repeat: false
        onTriggered: {
            console.log("InitTimer triggered")
            navigationMap.initializeMap()
        }
    }

    // Theme change handler
    Connections {
        target: Theme
        function onCurrentThemeChanged() {
            console.log("Theme changed to:", Theme.currentTheme)
            activeMap = Theme.currentTheme === "dark" ? darkMap : lightMap
            console.log("activeMap set to:", activeMap ? (Theme.currentTheme === "dark" ? "darkMap" : "lightMap") : "null")
            if (activeMap) {
                showCurrentLocation()
                if (isShowingFullRoute || isRoutingStart) {
                    console.log("Restoring route after theme change")
                    geoModel.update()
                }
            } else {
                console.log("Theme change: No active map available")
            }
        }
    }

    // Functions
    function initializeMap() {
        console.log("initializeMap called")
        activeMap = Theme.currentTheme === "dark" ? darkMap : lightMap
        console.log("activeMap set to:", activeMap ? (Theme.currentTheme === "dark" ? "darkMap" : "lightMap") : "null")
        if (activeMap) {
            mapsInitialized = true
            showCurrentLocation()
        } else {
            console.log("InitializeMap: No active map available")
        }
    }

    function zoomIn() {
        console.log("Zoom In Called")
        if (activeMap) {
            activeMap.zoomLevel = Math.min(activeMap.zoomLevel + 1, 18)
        } else {
            console.log("Zoom In: No active map")
        }
    }

    function zoomOut() {
        console.log("Zoom Out Called")
        if (activeMap) {
            activeMap.zoomLevel = Math.max(activeMap.zoomLevel - 1, 10)
        } else {
            console.log("Zoom Out: No active map")
        }
    }

    function showCurrentLocation() {
        console.log("Showing Current Location:", currentLoc)
        if (activeMap) {
            activeMap.center = currentLoc
            activeMap.zoomLevel = defaultZoomLevel
            activeMap.bearing = -80
            activeMap.tilt = 0
            isShowingFullRoute = false
            routeModel.reset()
            if (currentLocationMarker) currentLocationMarker.visible = false
            if (destinationMarker) destinationMarker.visible = false
            if (startMarker) startMarker.visible = false
            isRoutingStart = false
            simulateDrive.stop()
            routeStartAnimation.stop()
            // Initialize marker references
            currentLocationMarker = activeMap.currentLocationMarker
            destinationMarker = activeMap.destinationMarker
            startMarker = activeMap.startMarker
        } else {
            console.log("Show Current Location: No active map")
        }
    }

    function showFullRoute() {
        console.log("Show Full Route, Current State:", isShowingFullRoute)
        if (!isShowingFullRoute && activeMap) {
            geoModel.update()
            isShowingFullRoute = true
        } else if (isShowingFullRoute) {
            showCurrentLocation()
        } else {
            console.log("Show Full Route: No active map")
        }
    }

    function startSimulation() {
        console.log("Start Simulation, Routing Start:", isRoutingStart, "Route Count:", routeModel.count)
        if (activeMap) {
            if (!isRoutingStart) {
                if (routeModel.count > 0) {
                    animationTimer.restart()
                } else {
                    showFullRoute()
                }
            } else {
                console.log("Restarting Simulation")
                simulateDrive.stop()
                routeStartAnimation.stop()
                if (currentLocationMarker) currentLocationMarker.visible = false
                if (startMarker) startMarker.visible = true
                if (destinationMarker) destinationMarker.visible = true
                isRoutingStart = false
                animationTimer.restart()
            }
        } else {
            console.log("Start Simulation: No active map")
        }
    }

    function fitRouteToView() {
        console.log("Fitting Route to View, Route Count:", routeModel.count)
        if (activeMap && routeModel.count > 0) {
            var route = routeModel.get(0)
            var path = route.path
            if (path.length > 0) {
                var minLat = path[0].latitude
                var maxLat = path[0].latitude
                var minLon = path[0].longitude
                var maxLon = path[0].longitude
                for (var i = 1; i < path.length; i++) {
                    minLat = Math.min(minLat, path[i].latitude)
                    maxLat = Math.max(maxLat, path[i].latitude)
                    minLon = Math.min(minLon, path[i].longitude)
                    maxLon = Math.max(maxLon, path[i].longitude)
                }
                var centerLat = (minLat + maxLat) / 2
                var centerLon = (minLon + maxLon) / 2
                activeMap.center = QtPositioning.coordinate(centerLat, centerLon)
                var latSpan = maxLat - minLat
                var lonSpan = maxLon - minLon
                var maxSpan = Math.max(latSpan, lonSpan)
                var zoom = Math.log2(360 * (activeMap.width / 256) / maxSpan)
                activeMap.zoomLevel = Math.max(10, Math.min(18, zoom - 1))
                activeMap.bearing = 0
                activeMap.tilt = 0
            }
        } else {
            console.log("Fit Route to View: No active map or no route")
        }
    }

    // Gradient overlay
    // RadialGradient {
    //     z: 1
    //     visible: enableGradient
    //     anchors.fill: parent
    //     gradient: Gradient {
    //         GradientStop { position: 0.0; color: "transparent" }
    //         GradientStop {
    //             position: 0.72
    //             color: Theme.currentTheme === "dark" ? "#121212" : "#c5c5c5"
    //         }
    //     }
    // }
    // Rectangle {
    //     z: 1
    //     anchors.fill: parent
    //     color: Theme.currentTheme === "dark" ? "#121212" : "transparent"
    //     opacity: Theme.currentTheme === "dark" ? 1 : 0.0
    //     visible: enableGradient
    // }

    RouteModel {
        id: routeModel
        plugin: Plugin {
            name: "osm"
        }
        query: RouteQuery { id: routeQuery }
        onRoutesChanged: {
            console.log("Routes Changed, Count:", count, "Showing Full Route:", isShowingFullRoute)
            if (count > 0 && activeMap) {
                if (destinationMarker) {
                    destinationMarker.coordinate = destinationLoc
                    destinationMarker.visible = true
                } else {
                    console.log("Routes Changed: destinationMarker is undefined")
                }
                if (startMarker) {
                    startMarker.coordinate = currentLoc
                    startMarker.visible = true
                } else {
                    console.log("Routes Changed: startMarker is undefined")
                }
                if (isShowingFullRoute) {
                    fitRouteToView()
                }
                if (!isRoutingStart && animationTimer.running) {
                    animationTimer.triggered()
                }
            } else {
                console.log("Routes Changed: No active map or no route")
            }
        }
    }

    GeocodeModel {
        id: geoModel
        plugin: Plugin {
            name: "osm"
        }
        query: "Ho Chi Minh City, Vietnam"
        onLocationsChanged: {
            console.log("Geocode Locations Changed, Count:", count)
            if (count && activeMap) {
                routeQuery.clearWaypoints()
                routeQuery.addWaypoint(currentLoc)
                routeQuery.addWaypoint(destinationLoc)
                routeModel.update()
            }
        }
        onErrorStringChanged: {
            console.log("Geocode Error:", errorString)
        }
    }

    Timer {
        id: animationTimer
        interval: 1000
        running: false
        onTriggered: {
            console.log("Animation Timer Triggered")
            if (activeMap) {
                if (startMarker) startMarker.visible = false
                if (currentLocationMarker) {
                    currentLocationMarker.visible = true
                    currentLocationMarker.coordinate = currentLoc
                }
                routeStartAnimation.running = true
            } else {
                console.log("Animation Timer: No active map")
            }
        }
    }

    Timer {
        id: simulateDrive
        property var path: []
        property int index: 0
        interval: 200 // Optimized for smoothness
        repeat: true
        running: false
        onTriggered: {
            if (path && index < path.length) {
                if (currentLocationMarker) {
                    currentLocationMarker.coordinate = path[index]
                    console.log("Moving car to:", path[index])
                }
                index++
            } else {
                console.log("Simulation Complete")
                simulateDrive.stop()
                isRoutingStart = false
                if (currentLocationMarker) currentLocationMarker.visible = false
            }
        }
    }

    SequentialAnimation {
        id: routeStartAnimation
        running: false
        onFinished: {
            console.log("Route Start Animation Finished, Starting Simulation")
            if (activeMap && routeModel.count > 0) {
                isRoutingStart = true
                simulateDrive.path = routeModel.get(0).path
                simulateDrive.index = 0
                simulateDrive.running = true
                bearingAnimation.running = true
            } else {
                console.log("Route Start Animation Finished: No route or active map")
            }
        }

        PropertyAnimation {
            duration: 1000
            target: activeMap
            property: "center"
            to: navigationMap.currentLoc
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            duration: 6000
            target: activeMap
            properties: "zoomLevel"
            from: activeMap ? activeMap.zoomLevel : defaultZoomLevel
            to: 18
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            duration: 1000
            target: activeMap
            properties: "tilt"
            from: 0
            to: activeMap ? activeMap.maximumTilt : 60
            easing.type: Easing.InOutQuad
        }
    }

    NumberAnimation {
        id: bearingAnimation
        target: activeMap
        duration: 5000
        properties: "bearing"
        from: -80
        to: 0
        running: false
        easing.type: Easing.InOutQuad
    }

    function findMarkerByName(name) {
        if (!activeMap) {
            console.log("findMarkerByName: No active map")
            return null
        }
        for (var i = 0; i < activeMap.mapItems.length; i++) {
            if (activeMap.mapItems[i].objectName === name) {
                return activeMap.mapItems[i]
            }
        }
        console.log("Marker not found:", name)
        return null
    }

    Component.onCompleted: {
        console.log("NavigationMap Initialized with Theme:", Theme.currentTheme)
    }
}