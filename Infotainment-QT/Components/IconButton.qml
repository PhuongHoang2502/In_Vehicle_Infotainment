import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import App.Theme 1.0

/**
 * IconButton - A customizable button component with various icon display options
 * and ripple effect on press
 */
Button {
    id: control

    // Visual properties
    implicitHeight: 55
    implicitWidth: 55

    // Icon properties
    property bool isMirror: false
    property string setIcon: ""
    property string setIconText: ""
    property string setIconColor: Theme.colors.text
    property real setIconSize: 25
    property real iconWidth: 28
    property real iconHeight: 28
    property bool roundIcon: false
    property string iconBackground: "transparent"
    property bool isGlow: false
    property real radius: height / 2

    // Icon image for standard icons
    Image {
        id: standardIcon
        z: 2
        visible: !roundIcon && !setIconText && setIcon !== ""
        mirror: control.isMirror
        anchors.centerIn: parent
        source: control.setIcon
        scale: control.pressed ? 0.9 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }

    // Icon image for round icons
    Image {
        id: roundedIcon
        z: 2
        visible: roundIcon && !setIconText && setIcon !== ""
        mirror: control.isMirror
        sourceSize: Qt.size(control.iconWidth, control.iconHeight)
        anchors.centerIn: parent
        source: control.setIcon
        scale: control.pressed ? 0.9 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }

    // Text icon (font awesome)
    Text {
        id: textIcon
        z: 2
        visible: setIconText !== ""
        anchors.centerIn: parent
        text: control.setIconText
        color: control.setIconColor
        font.pixelSize: control.setIconSize
        font.family: "Font Awesome 5 Pro"
    }

    // Background with ripple effect
    background: Rectangle {
        id: backgroundRect
        z: 1
        anchors.fill: parent
        radius: control.radius
        color: control.iconBackground

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.Linear
            }
        }

        // Ripple effect indicator
        Rectangle {
            id: rippleIndicator
            property int mx: 0
            property int my: 0

            x: mx - width / 2
            y: my - height / 2
            height: width
            width: 0
            radius: width / 2
            opacity: 0
            color: control.isGlow ? Qt.lighter(Theme.colors.primary) : Qt.lighter("#B8FF01")
        }
    }

    // Mask for rounded corners
    Rectangle {
        id: mask
        radius: control.radius
        anchors.fill: parent
        visible: false
    }

    // Apply mask to background
    OpacityMask {
        anchors.fill: backgroundRect
        source: backgroundRect
        maskSource: mask
    }

    // Cursor handling
    MouseArea {
        id: mouseArea
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
    }

    // Ripple animation
    ParallelAnimation {
        id: rippleAnimation

        NumberAnimation {
            target: rippleIndicator
            property: 'width'
            from: 0
            to: control.width * 1.5
            duration: 200
            easing.type: Easing.OutQuad
        }

        NumberAnimation {
            target: rippleIndicator
            property: 'opacity'
            from: 0.9
            to: 0
            duration: 200
        }
    }

    // Handle press event
    onPressed: {
        rippleIndicator.mx = mouseArea.mouseX
        rippleIndicator.my = mouseArea.mouseY
        rippleAnimation.restart()
    }
}
