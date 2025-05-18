pragma Singleton
import QtQuick 2.15
import QtQuick.Controls 2.15

QtObject {
    id: theme

    // Theme modes
    enum Mode { Auto, Light, Dark }
    property int currentMode: Theme.Mode.Auto
    property string currentTheme: "dark"

    // Light sensor value (0-1 where 1 is brightest)
    property real lightSensorValue: canController.light
    property real lightSensorThreshold: 50 // Above this = light mode

    // Theme colors
    readonly property var dark: {
        "background": "#121212",
        "surface": "#1E1E1E",
        "primary": "#BB86FC",
        "text": "#FFFFFF"
    }

    readonly property var light: {
        "background": "#FFFFFF",
        "surface": "#F5F5F5",
        "primary": "#6200EE",
        "text": "#000000"
    }

    property var colors: currentTheme === "dark" ? dark : light

    // Update theme based on mode and sensor
    function updateTheme() {
        if (currentMode === Theme.Mode.Auto) {
            currentTheme = canController.light > lightSensorThreshold ? "light" : "dark"
        } else {
            currentTheme = currentMode === Theme.Mode.Light ? "light" : "dark"
        }
    }

    // Toggle between modes
    function toggleAuto() {
        currentMode = currentMode === Theme.Mode.Auto ? Theme.Mode.Dark : Theme.Mode.Auto
        updateTheme()
    }

    // Manual theme switch
    function setManualTheme(isLight) {
        currentMode = isLight ? Theme.Mode.Light : Theme.Mode.Dark
        updateTheme()
    }

    // Watch for changes
    onCurrentModeChanged: updateTheme()
    onLightSensorValueChanged: {
        if (currentMode === Theme.Mode.Auto) updateTheme()
    }
}
