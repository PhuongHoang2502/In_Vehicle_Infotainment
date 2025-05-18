import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15

Map {
    id: map
    copyrightsVisible: false
    center: QtPositioning.coordinate(10.773108, 106.658892)
    zoomLevel: 13.3
    bearing: -80

    property string styleUrl
    property alias currentLocationMarker: currentLocationMarker
    property alias destinationMarker: destinationMarker
    property alias startMarker: startMarker

    plugin: Plugin {
        name: "mapboxgl"
        PluginParameter {
            name: "mapboxgl.access_token"
            value: "pk.eyJ1IjoiaGFzZWVidGFyaXExOTk4IiwiYSI6ImNsbGw4cXQ3YTFsdXkzanBxaG1rZDZrYTgifQ.8M9sbj-GM8oDrhAfCMUasw"
        }
        PluginParameter {
            name: "mapboxgl.mapping.additional_style_urls"
            value: styleUrl
        }
        PluginParameter {
            name: "mapboxgl.threaded_rendering"
            value: "true" // Enable to test performance
        }
    }

    // Smooth map centering
    Behavior on center {
        CoordinateAnimation {
            duration: 200 // Sync with simulateDrive interval
            easing.type: Easing.InOutQuad
        }
    }

    Component.onCompleted: {
        console.log("DynamicMap initialized with style:", styleUrl)
    }

    MapItemView {
        id: mapRouteLine
        model: routeModel
        delegate: MapRoute {
            route: routeData
            line.color: styleUrl.includes("dark") ? "#005eff" : "#0077fe"
            line.width: 7
        }
    }

    MapQuickItem {
        id: currentLocationMarker
        objectName: "currentLocationMarker"
        coordinate: QtPositioning.coordinate(10.775702458108402, 106.66015796004943)
        visible: false
        z: 3
        anchorPoint: Qt.point(sourceItem.width / 2, sourceItem.height / 2)
        onCoordinateChanged: {
            if (navigationMap.isRoutingStart) {
                map.center = coordinate
            }
        }
        sourceItem: Rectangle {
            width: 100 * (map.zoomLevel / 17)
            height: 100 * (map.zoomLevel / 17)
            color: "transparent"
            radius: 180
            Image {
                width: parent.width
                height: parent.height
                source: "qrc:/Icons/CarMarker.png"
                anchors.centerIn: parent
            }
        }
    }

    MapQuickItem {
        id: destinationMarker
        objectName: "destinationMarker"
        coordinate: QtPositioning.coordinate(10.880106, 106.804759)
        visible: false
        z: 2
        anchorPoint: Qt.point(sourceItem.width / 2, sourceItem.height / 2)
        sourceItem: Rectangle {
            width: 50 * (map.zoomLevel / 17)
            height: 50 * (map.zoomLevel / 17)
            color: "transparent"
            radius: 180
            AnimatedImage {
                width: parent.width
                height: parent.height
                source: "qrc:/Icons/icons8-destination.gif"
                anchors.centerIn: parent
            }
        }
    }

    MapQuickItem {
        id: startMarker
        objectName: "startMarker"
        coordinate: QtPositioning.coordinate(10.775702458108402, 106.66015796004943)
        visible: false
        z: 2
        anchorPoint: Qt.point(sourceItem.width / 2, sourceItem.height / 2)
        sourceItem: Rectangle {
            width: 50 * (map.zoomLevel / 17)
            height: 50 * (map.zoomLevel / 17)
            color: "transparent"
            radius: 180
            Image {
                width: parent.width
                height: parent.height
                source: "qrc:/Icons/LocationMarker.png"
                anchors.centerIn: parent
            }
        }
    }
}