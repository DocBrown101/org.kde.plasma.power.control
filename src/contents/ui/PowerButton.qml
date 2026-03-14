import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Item {
    id: btn
    implicitHeight: compact ? 32 : 58
    Layout.minimumHeight: compact ? 28 : 40

    property string buttonLabel: "Button"
    property string iconName: "system-shutdown"
    property color accentColor: "#5e9eff"
    property bool compact: false
    property bool lightMode: false

    signal doubleClicked()

    ColorPalette {
        id: palette
        lightMode: btn.lightMode
    }

    // Glow layer (behind everything)
    Rectangle {
        id: glowRect
        anchors.fill: bgRect
        anchors.margins: -4
        radius: bgRect.radius + 4
        color: "transparent"
        border.color: btn.accentColor
        border.width: 1
        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    // Main button body
    Rectangle {
        id: bgRect
        anchors.fill: parent
        radius: btn.compact ? 8 : 12
        color: palette.buttonBody
        border.color: mouseArea.containsMouse
                      ? Qt.rgba(btn.accentColor.r, btn.accentColor.g, btn.accentColor.b, 0.45)
                      : palette.buttonBorderIdle
        border.width: 1

        Behavior on color  { ColorAnimation  { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        // Subtle left accent stripe
        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 3
            height: btn.compact ? 16 : 28
            radius: 2
            color: btn.accentColor
            opacity: mouseArea.containsMouse ? 0.9 : 0.4
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: btn.compact ? 8 : 16
            anchors.rightMargin: btn.compact ? 8 : 14
            spacing: btn.compact ? 6 : 10

            Kirigami.Icon {
                source: btn.iconName
                width:  btn.compact ? 18 : 22
                height: btn.compact ? 18 : 22
                color: mouseArea.containsMouse ? btn.accentColor : palette.buttonIconIdle
                Behavior on color { ColorAnimation { duration: 150 } }
            }

            Text {
                Layout.fillWidth: true
                text: btn.buttonLabel
                font.pixelSize: btn.compact ? 11 : 13
                font.weight: Font.Normal
                font.letterSpacing: 0.5
                color: mouseArea.containsMouse ? palette.buttonTextHover : palette.buttonTextIdle
                Behavior on color { ColorAnimation { duration: 150 } }
            }
        }
    }

    // Press flash overlay
    Rectangle {
        id: pressFlash
        anchors.fill: bgRect
        radius: bgRect.radius
        color: btn.accentColor
        opacity: 0

        SequentialAnimation {
            id: flashAnim
            NumberAnimation { target: pressFlash; property: "opacity"; to: 0.18; duration: 80 }
            NumberAnimation { target: pressFlash; property: "opacity"; to: 0;    duration: 200 }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: glowRect.opacity = 0.35
        onExited:  glowRect.opacity = 0
        onDoubleClicked: {
            flashAnim.start()
            btn.doubleClicked()
        }
        // Scale feedback on press
        onPressed:  btn.scale = 0.97
        onReleased: btn.scale = 1.0
    }

    Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.OutCubic } }
}
