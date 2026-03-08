import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.private.sessions as Sessions
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.ksvg as KSvg
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    width: 200
    height: 220
    preferredRepresentation: fullRepresentation

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
        Layout.minimumWidth: 200
        Layout.minimumHeight: 220

        // Background
        Rectangle {
            anchors.fill: parent
            radius: 16
            color: Qt.rgba(0.07, 0.07, 0.10, 0.97)
            border.color: Qt.rgba(1, 1, 1, 0.07)
            border.width: 1

            layer.enabled: true
            layer.effect: null
        }

        // Subtle top accent line
        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 0
            width: 80
            height: 2
            radius: 1
            color: "#5e9eff"
            opacity: 0.7
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 16

            // ── Header ──────────────────────────────────────────────────
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Power Control"
                    font.pixelSize: 17
                    font.weight: Font.Light
                    font.letterSpacing: 2.5
                    color: "#e8eaf0"
                }

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 40
                    height: 1
                    color: Qt.rgba(1, 1, 1, 0.12)
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Doppelklick zum Ausführen"
                    font.pixelSize: 9
                    font.letterSpacing: 0.8
                    color: Qt.rgba(1, 1, 1, 0.3)
                }
            }

            // ── Buttons ─────────────────────────────────────────────────
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                // Restart Button
                PowerButton {
                    Layout.fillWidth: true
                    buttonLabel: "Neu starten"
                    iconName: "system-reboot"
                    accentColor: "#5e9eff"
                    onDoubleClicked: session.requestReboot()
                }

                // Shutdown Button
                PowerButton {
                    Layout.fillWidth: true
                    buttonLabel: "Herunterfahren"
                    iconName: "system-shutdown"
                    accentColor: "#ff6b6b"
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
