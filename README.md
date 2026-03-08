# Power Control - KDE Plasma 6 Widget

A minimal KDE Plasma 6 plasmoid that provides quick access to **Restart** and **Shutdown** actions directly from your panel.

## Screenshot

![Preview](https://github.com/DocBrown101/org.kde.plasma.power.control/blob/main/docs/screenshot.png)

## Installation

### Build from source

```bash
git clone https://github.com/DocBrown101/org.kde.plasma.power.control.git
cd org.kde.plasma.power.control
kpackagetool6 -t Plasma/Applet -i src/
```

To update an existing installation:

```bash
kpackagetool6 -t Plasma/Applet -u src/
```

## Usage

1. Add the **Power Control** widget to your panel via *Right-click panel → Add Widgets*
2. Click the power icon in the panel to open the popup
3. **Double-click** either button to execute the action

## Development & Testing

The Plasma SDK provides `plasmoidviewer` for testing the widget without a system-wide installation:

```bash
plasmoidviewer -a src/
```

## Requirements

- KDE Plasma **6.0** or later
- Qt **6**

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is licensed under the [MIT License](LICENSE).
