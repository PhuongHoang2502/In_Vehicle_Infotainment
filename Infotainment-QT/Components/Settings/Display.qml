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
        spacing: 30

        Label {
            text: "Visibility"
            Layout.fillWidth: true
            font.pixelSize: 24
            font.bold: Font.Bold
            font.family: "Montserrat"
            verticalAlignment: Image.AlignVCenter
            Layout.alignment: Qt.AlignVCenter
            color: Theme.colors.text
        }

        // ColumnLayout{
        //     spacing: 10
        //     Label {
        //         text: "Display Mode"
        //         Layout.fillWidth: true
        //         font.pixelSize: 20
        //         font.family: "Montserrat"
        //         verticalAlignment: Image.AlignVCenter
        //         Layout.alignment: Qt.AlignVCenter
        //         color: Theme.colors.text
        //     }

        //     LabelSelector{
        //         lableList:  ["Day" ,"Night","Auto"]
        //     }
        // }
        ColumnLayout {
            spacing: 10
            Label {
                text: "Display Mode"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Montserrat"
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colors.text
            }

            LabelSelector {
                id: themeSelector
                lableList: ["Day", "Night", "Auto"]
                
                // Set initial selected item based on current theme mode
                Component.onCompleted: {
                    // Find the Repeater inside LabelSelector
                    const repeater = findRepeaterChild(themeSelector)
                    if (repeater) {
                        // Set initial selection based on current theme mode
                        const index = getThemeModeIndex()
                        const item = repeater.itemAt(index)
                        if (item) {
                            item.checked = true
                        }
                    }
                }
                
                // Custom function to find child Repeater component
                function findRepeaterChild(parent) {
                    for (let i = 0; i < parent.children.length; i++) {
                        const child = parent.children[i]
                        if (child.hasOwnProperty('model') && child.hasOwnProperty('count')) {
                            return child
                        } else if (child.children && child.children.length > 0) {
                            const found = findRepeaterChild(child)
                            if (found) return found
                        }
                    }
                    return null
                }
                
                // Get theme mode index
                function getThemeModeIndex() {
                    if (Theme.currentMode === Theme.Mode.Light) return 0
                    if (Theme.currentMode === Theme.Mode.Dark) return 1
                    return 2 // Auto mode
                }
                
                // Watch for changes in RadioButton children and update theme
                Connections {
                    target: themeSelector
                    
                    // Special function that will be called when children complete
                    function onChildrenChanged() {
                        // Wait for Repeater to populate items
                        Qt.callLater(setupButtonConnections)
                    }
                    
                    // Setup connections to RadioButtons created by Repeater
                    function setupButtonConnections() {
                        const repeater = themeSelector.findRepeaterChild(themeSelector)
                        if (!repeater) return

                        // Connect to each RadioButton
                        for (let i = 0; i < repeater.count; i++) {
                            const radioButton = repeater.itemAt(i)
                            if (radioButton) {
                                // Connect to clicked signal
                                radioButton.clicked.connect(function() {
                                    updateThemeFromSelection(i)
                                })
                            }
                        }
                    }
                    
                    // Update theme based on selection index
                    function updateThemeFromSelection(index) {
                        if (index === 0) {
                            // Day mode
                            Theme.currentMode = Theme.Mode.Light
                        } else if (index === 1) {
                            // Night mode
                            Theme.currentMode = Theme.Mode.Dark
                        } else if (index === 2) {
                            // Auto mode
                            Theme.currentMode = Theme.Mode.Auto
                        }
                    }
                }
            }
            
            // Listen for changes in Theme and update selector
            Connections {
                target: Theme
                function onCurrentModeChanged() {
                    // Find repeater and update selection
                    const repeater = themeSelector.findRepeaterChild(themeSelector)
                    if (repeater) {
                        const newIndex = themeSelector.getThemeModeIndex()
                        
                        // Update all radio buttons
                        for (let i = 0; i < repeater.count; i++) {
                            const item = repeater.itemAt(i)
                            if (item) {
                                item.checked = (i === newIndex)
                            }
                        }
                    }
                }
            }
        }

        ColumnLayout{
            spacing: 10
            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                IconButton{
                    setIcon: Theme.isDarkMode ? "qrc:/Icons/Light/display.svg" : "qrc:/Icons/Dark/display.svg"
                }

                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Display Brightness"
                    Layout.fillWidth: true
                    font.pixelSize: 20
                    font.family: "Montserrat"
                    color: Theme.colors.text
                }
            }

            TSlider{
                width: 680
                height: 60
                checkedColor: Theme.isDarkMode ? "grey" : "#FFFFFF"
                from:0
                to:100
                stepSize: 1
                value: 10
            }
            Label {
                Layout.alignment: Qt.AlignHCenter
                text: "Reduce brightness to conserve energy"
                Layout.fillWidth: true
                opacity: 0.8
                font.pixelSize: 16
                font.family: "Montserrat"
                color: Theme.colors.text
            }
        }

        Label {
            text: "Units & Format"
            Layout.fillWidth: true
            font.pixelSize: 24
            font.bold: Font.Bold
            font.family: "Montserrat"
            verticalAlignment: Image.AlignVCenter
            Layout.alignment: Qt.AlignVCenter
            color: Theme.colors.text
        }

        ColumnLayout{
            spacing: 10
            Label {
                text: "Distance"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Montserrat"
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colors.text
            }

            LabelSelector{
                lableList:  ["Kilometers" ,"Miles"]
            }
        }
        ColumnLayout{
            spacing: 10
            Label {
                text: "Temperature"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Montserrat"
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colors.text
            }

            LabelSelector{
                lableList:  ["°C","°F"]
            }
        }

    }
}
