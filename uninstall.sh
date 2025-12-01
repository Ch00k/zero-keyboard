#!/usr/bin/env bash

set -e

echo "Stopping zero-kbd service..."
sudo systemctl stop zero-kbd.service 2>/dev/null || true

echo "Disabling zero-kbd service..."
sudo systemctl disable zero-kbd.service 2>/dev/null || true

echo "Removing systemd service from /etc/systemd/system/zero-kbd.service"
sudo rm -f /etc/systemd/system/zero-kbd.service

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Removing module loading configuration from /etc/modules-load.d/zero-kbd.conf"
sudo rm -f /etc/modules-load.d/zero-kbd.conf

echo "Removing USB Gadget support from /boot/firmware/config.txt"
sudo sed -i '/^dtoverlay=dwc2$/d' /boot/firmware/config.txt

echo "Removing type script from /usr/local/bin/"
sudo rm -f /usr/local/bin/type

echo "Removing init_kbd.sh from /usr/local/sbin/"
sudo rm -f /usr/local/sbin/init_kbd.sh

echo ""
echo "Uninstall complete!"
echo ""
echo "To fully remove the USB gadget configuration, you should reboot the Pi:"
echo "  sudo reboot"
