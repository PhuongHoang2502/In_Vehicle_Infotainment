import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Theme 1.0

Rectangle {
    id: footer
    color: "#0E0E0E"
    width: parent.width
    height: 60

    // Add properties needed for dialog positioning
    property Item root: parent  // Default to parent, can be overridden
    property Item leftArea
    property Item rightArea
    property var settingDialog: null

    signal openLaunchpad()

    // Dialog creation functions defined directly in the Footer
    function createSettingDialog() {
        // If dialog exists and is visible, bring to focus
        if (settingDialog !== null && settingDialog.visible) {
            settingDialog.requestActivate()
            console.log("Settings dialog already open, focusing")
            return
        }

        var component = Qt.createComponent("qrc:/Components/SettingDialog.qml")
        if (component.status !== Component.Ready) {
            if (component.status === Component.Error)
                console.debug("Error loading SettingDialog.qml:", component.errorString())
            return
        }

        settingDialog = component.createObject(root)
        if (settingDialog !== null) {
            settingDialog.x = parent.width * 0.3 + 20
            settingDialog.y = parent.height - settingDialog.height + 10
            settingDialog.show()
            console.log("Settings dialog created and shown")
        } else {
            console.debug("Failed to create SettingDialog.qml")
        }
    }

    function createMusicDialog() {
        var component = Qt.createComponent("qrc:/Music/qml/Music.qml");
        if (component.status !== Component.Ready) {
            if (component.status === Component.Error)
                console.debug("Error:" + component.errorString());
            return;
        }
        var win = component.createObject(root);
        if (win !== null) {
            win.x = leftArea.width + 20;
            win.y = rightArea.height - win.height + 10;
            win.onHeightChanged.connect(function() {
                win.x = leftArea.width + 20;
                win.y = rightArea.height - win.height + 10;
            });
            win.show();
        }
    }

    // Main layout for the footer buttons
    RowLayout {
        id: buttonLayout
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 60
            rightMargin: 110
        }
        spacing: 110

        // Settings button
        IconButton {
            setIcon: "qrc:/Icons/model3-icon.svg"
            onClicked: footer.createSettingDialog()
        }

        // Defrost button
        IconButton {
            setIcon: "qrc:/Icons/defrost.svg"
        }

        // Heater button
        IconButton {
            setIcon: "qrc:/Icons/heater.svg"
        }

        IconButton {
            roundIcon: true
            iconHeight: 50
            iconWidth: 50
            setIcon: "qrc:/Icons/Apps.png"
            onClicked: footer.openLaunchpad()
        }

        // Driver seat button
        IconButton {
            setIcon: "qrc:/Icons/seat.svg"
        }

        // Driver temperature button
        IconButton {
            setIcon: "qrc:/Icons/Driver Temp.svg"
        }

        // Fan button
        IconButton {
            setIcon: "qrc:/Icons/fan.svg"
        }

        // Passenger temperature button
        IconButton {
            setIcon: "qrc:/Icons/Driver Temp.svg"
        }

        // Passenger seat button
        IconButton {
            isMirror: true
            setIcon: "qrc:/Icons/seat.svg"
        }

        // Music button
        IconButton {
            setIcon: "qrc:/Icons/music.svg"
            onClicked: footer.createMusicDialog()
        }

        // Volume button
        IconButton {
            setIcon: "qrc:/Icons/volume.svg"
        }
    }
}
