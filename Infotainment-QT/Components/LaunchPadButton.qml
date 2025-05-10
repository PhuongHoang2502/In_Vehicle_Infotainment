import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Theme 1.0
import QtGraphicalEffects 1.15

Button {
    id: control

    // Custom properties
    property bool isGlow: false
    property color textColor: "white"
    property real iconWidth: 50
    property real iconHeight: 50
    property real buttonRadius: 8
    property real iconRadius: 8  // New property for icon corner radius
    
    // Button dimensions
    implicitHeight: 128
    implicitWidth: 128

    // Content layout
    contentItem: ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        // Top spacer
        Item { Layout.fillHeight: true }

        // Icon wrapper with mask for rounded corners
        Item {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            width: control.iconWidth
            height: control.iconHeight
            
            // Actual icon image
            Image {
                id: iconImage
                anchors.fill: parent
                source: control.icon.source
                visible: false // Hide original image, will be shown through mask
                
                // Set explicit size
                sourceSize.width: control.iconWidth
                sourceSize.height: control.iconHeight
                
                // Animation properties
                scale: control.pressed ? 0.9 : 1.0
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }
            }
            
            // Mask for rounded corners
            Rectangle {
                id: iconMask
                anchors.fill: parent
                radius: control.iconRadius
                visible: false
            }
            
            // Apply the mask to the image
            OpacityMask {
                anchors.fill: iconImage
                source: iconImage
                maskSource: iconMask
                
                // Pass through scale animation from source image
                scale: iconImage.scale
            }
        }

        // Text label
        Text {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            text: control.text
            font: control.font
            color: control.textColor
            horizontalAlignment: Text.AlignHCenter
        }

        // Bottom spacer
        Item { Layout.fillHeight: true }
    }

    // Button background with ripple effect
    background: Item {
        // Transparent background
        Rectangle {
            id: backgroundRect
            anchors.fill: parent
            radius: control.buttonRadius  // Use the button radius property
            color: "transparent"
        }

        // Ripple indicator
        Rectangle {
            id: rippleIndicator
            property point mousePos: Qt.point(0, 0)
            
            width: 0
            height: width
            radius: width / 2
            x: mousePos.x - width / 2
            y: mousePos.y - height / 2
            
            color: control.isGlow ? 
                Qt.lighter("#29BEB6") : 
                Qt.lighter("#B8FF01")
            
            opacity: 0
        }

        // Mask for button rounded corners
        Rectangle {
            id: mask
            anchors.fill: parent
            radius: control.buttonRadius  // Use the button radius property
            visible: false
        }

        // Apply mask
        OpacityMask {
            anchors.fill: backgroundRect
            source: backgroundRect
            maskSource: mask
        }
    }

    // Mouse handling (no need for separate MouseArea since Button has its own)
    hoverEnabled: true

    // Ripple animation
    ParallelAnimation {
        id: rippleAnimation
        
        // Size animation
        NumberAnimation {
            target: rippleIndicator
            property: "width"
            from: 0
            to: control.width
            duration: 200
            easing.type: Easing.OutQuad
        }
        
        // Opacity animation
        NumberAnimation {
            target: rippleIndicator
            property: "opacity"
            from: 0.9
            to: 0
            duration: 200
        }
    }

    // Handle press event - use Button's own pressed signal
    onPressed: {
        var center = Qt.point(width/2, height/2)
        rippleIndicator.mousePos = center
        rippleAnimation.restart()
    }
}
