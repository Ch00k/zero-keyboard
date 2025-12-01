# Zero Keyboard

Turn a Raspberry Pi into a USB HID keyboard that can be controlled remotely (e.g. via SSH).

## Hardware Requirements

- Raspberry Pi (any variant with USB OTG support). Raspberry Pi Zero / Zero W / Zero 2 W work best, but other models can
  work with additional configuration. See [Using OTG mode on Raspberry Pi SBCs](https://pip-assets.raspberrypi.com/categories/685-app-notes-guides-whitepapers/documents/RP-009276-WP-1-Using%20OTG%20mode%20on%20Raspberry%20Pi%20SBCs.pdf) for details.
- USB cable
- Target computer with USB port

## Installation

1. Download and unpack this repository on Raspberry Pi:
```bash
wget https://github.com/Ch00k/zero-keyboard/archive/refs/heads/main.zip
unzip main.zip
cd zero-keyboard-main
```

2. Run the installation script:
```bash
sudo ./install.sh
```

The installer will:
- Enable USB gadget support in `/boot/firmware/config.txt`
- Configure `dwc2` and `libcomposite` kernel modules to auto-load on boot
- Install the HID gadget initialization script to `/usr/local/sbin/`
- Install the `zero-type` command to `/usr/local/bin/`
- Set up a systemd service to initialize the keyboard on boot

3. Reboot the Pi:
```bash
sudo reboot
```

4. Connect the Raspberry Pi's OTG port to your target computer

## Usage

SSH into the Pi and use the `zero-type` command:

```bash
# Type a password
zero-type "mypassword"

# Type text with Enter key
zero-type "mypassword\n"

# Pipe text to the command
echo "some text" | zero-type
```

The `zero-type` command supports:
- All letters (a-z, A-Z)
- Numbers (0-9)
- Symbols: `! @ # $ % ^ & * ( ) - _ = + [ ] { } \ | ; : ' " \` ~ , < . > / ?`
- Special keys: Enter (`\n`), Tab (`\t`), Space

## Credits

Based on [this](https://randomnerdtutorials.com/raspberry-pi-zero-usb-keyboard-hid/) tutorial at Random Nerd Tutorials,
which in its turn is based on [this](https://www.isticktoit.net/?p=1383) guide by iSticktoit.
