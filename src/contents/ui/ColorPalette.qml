import QtQuick

QtObject {
    property bool lightMode: false
    property real bgOpacity: 0.88

    // Widget background
    readonly property color widgetBackground: lightMode
        ? Qt.rgba(0.96, 0.96, 0.98, bgOpacity)
        : Qt.rgba(0.07, 0.07, 0.10, bgOpacity)
    readonly property color widgetBorder: lightMode
        ? Qt.rgba(0, 0, 0, 0.25)
        : Qt.rgba(1, 1, 1, 0.07)

    // Accent colors — darkened for light backgrounds
    readonly property color accentBlue: lightMode ? "#1a5fd4" : "#5e9eff"
    readonly property color accentRed:  lightMode ? "#b02020" : "#ff6b6b"

    // Header text
    readonly property color headerText:   lightMode ? "#1a1a2e"               : "#e8eaf0"
    readonly property color subtitleText: lightMode ? Qt.rgba(0, 0, 0, 0.40) : Qt.rgba(1, 1, 1, 0.30)
    readonly property color divider:      lightMode ? Qt.rgba(0, 0, 0, 0.12) : Qt.rgba(1, 1, 1, 0.12)

    // Button internals
    readonly property color buttonBody:       lightMode ? Qt.rgba(0, 0, 0, 0.06) : Qt.rgba(1, 1, 1, 0.04)
    readonly property color buttonBorderIdle: lightMode ? Qt.rgba(0, 0, 0, 0.15) : Qt.rgba(1, 1, 1, 0.08)
    readonly property color buttonIconIdle:   lightMode ? Qt.rgba(0, 0, 0, 0.65) : Qt.rgba(1, 1, 1, 0.70)
    readonly property color buttonTextIdle:   lightMode ? Qt.rgba(0, 0, 0, 0.75) : Qt.rgba(1, 1, 1, 0.75)
    readonly property color buttonTextHover:  lightMode ? "#000000"               : "#ffffff"
}
