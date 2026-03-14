import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: root
    property string cfg_backgroundStyle: "dark"
    property double cfg_backgroundOpacity: 0.88

    QQC2.ComboBox {
        id: combo
        Kirigami.FormData.label: "Hintergrund:"
        model: [
            { text: "Dunkel", value: "dark"  },
            { text: "Hell",   value: "light" }
        ]
        textRole: "text"
        valueRole: "value"
        currentIndex: indexOfValue(cfg_backgroundStyle)
        onActivated: cfg_backgroundStyle = currentValue
    }

    QQC2.Slider {
        id: opacitySlider
        Kirigami.FormData.label: "Transparenz:"
        from: 0.1
        to: 1.0
        stepSize: 0.05
        value: cfg_backgroundOpacity
        onMoved: cfg_backgroundOpacity = value

        QQC2.Label {
            anchors.left: parent.right
            anchors.leftMargin: Kirigami.Units.smallSpacing
            anchors.verticalCenter: parent.verticalCenter
            text: Math.round(opacitySlider.value * 100) + "%"
        }
    }
}
