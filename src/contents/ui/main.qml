import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.private.sessions as Sessions
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    width: 200
    height: 220
    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    // ── Compact icon in the panel ───────────────────────────────────────────
    compactRepresentation: Item {
        Kirigami.Icon {
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height) * 0.8
            height: width
            source: "system-shutdown"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: root.expanded = !root.expanded
        }
    }

    // ── Full popup ──────────────────────────────────────────────────────────
    fullRepresentation: Item {
        id: fullRoot
        implicitWidth: 220
        implicitHeight: 240
        Layout.minimumWidth: 180
        Layout.minimumHeight: 120
        clip: true

        property bool compactMode: height < 160
        readonly property bool lightMode: Plasmoid.configuration.backgroundStyle === "light"
        readonly property real bgOpacity: Plasmoid.configuration.backgroundOpacity

        ColorPalette {
            id: palette
            lightMode: fullRoot.lightMode
            bgOpacity: fullRoot.bgOpacity
        }

        // Background
        Rectangle {
            anchors.fill: parent
            radius: Math.min(16, parent.width * 0.075, parent.height * 0.075)
            color: palette.widgetBackground
            border.color: palette.widgetBorder
            border.width: 1

            Behavior on color        { ColorAnimation { duration: 200 } }
            Behavior on border.color { ColorAnimation { duration: 200 } }
        }

        // Subtle top accent line
        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 80
            height: 2
            radius: 1
            color: palette.accentBlue
            opacity: 0.7
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: fullRoot.compactMode ? 12 : 20
            spacing: fullRoot.compactMode ? 8 : 16


            // ── Header ──────────────────────────────────────────────────
            Column {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                spacing: 2

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Power Control"
                    font.pixelSize: fullRoot.compactMode ? 13 : 17
                    font.weight: Font.Light
                    font.letterSpacing: fullRoot.compactMode ? 1.5 : 2.5
                    color: palette.headerText
                    Behavior on color { ColorAnimation { duration: 200 } }
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 40
                    height: 1
                    color: palette.divider
                    visible: !fullRoot.compactMode
                    Behavior on color { ColorAnimation { duration: 200 } }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Doppelklick zum Ausführen"
                    font.pixelSize: 9
                    font.letterSpacing: 0.8
                    color: palette.subtitleText
                    visible: !fullRoot.compactMode
                    Behavior on color { ColorAnimation { duration: 200 } }
                }
            }

            // ── Buttons ─────────────────────────────────────────────────
            ColumnLayout {
                Layout.fillWidth: true
                spacing: fullRoot.compactMode ? 6 : 10

                // Restart Button
                PowerButton {
                    Layout.fillWidth: true
                    buttonLabel: "Neu starten"
                    iconName: "system-reboot"
                    accentColor: palette.accentBlue
                    compact: fullRoot.compactMode
                    lightMode: fullRoot.lightMode
                    onDoubleClicked: session.requestReboot()
                }

                // Shutdown Button
                PowerButton {
                    Layout.fillWidth: true
                    buttonLabel: "Herunterfahren"
                    iconName: "system-shutdown"
                    accentColor: palette.accentRed
                    compact: fullRoot.compactMode
                    lightMode: fullRoot.lightMode
                    onDoubleClicked: session.requestShutdown()
                }
            }

            Item { Layout.fillHeight: true }
        }

        Sessions.SessionManagement {
            id: session
        }
    }
}
