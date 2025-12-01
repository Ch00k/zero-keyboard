#!/usr/bin/env bash

echo "Installing init_kbd.sh to /usr/local/sbin/"
sudo cp init_kbd.sh /usr/local/sbin/init_kbd.sh
sudo chmod +x /usr/local/sbin/init_kbd.sh

echo "Installing type script to /usr/local/bin/"
sudo cp type /usr/local/bin/type
sudo chmod +x /usr/local/bin/type

if grep -q '^dtoverlay=dwc2$' /boot/firmware/config.txt; then
    echo "USB Gadget support already enabled in /boot/firmware/config.txt"
else
    echo "Enabling USB Gadget support in /boot/firmware/config.txt"
    echo 'dtoverlay=dwc2' | sudo tee -a /boot/firmware/config.txt
fi

if [ -f /etc/modules-load.d/zero-kbd.conf ]; then
    echo "Module loading configuration already exists at /etc/modules-load.d/zero-kbd.conf"
else
    echo "Creating module loading configuration at /etc/modules-load.d/zero-kbd.conf"
    echo -en 'dwc2\nlibcomposite\n' | sudo tee /etc/modules-load.d/zero-kbd.conf
fi

echo "Installing systemd service to /etc/systemd/system/zero-kbd.service"
sudo cp zero-kbd.service /etc/systemd/system/zero-kbd.service

echo "Enabling and starting zero-kbd service"
sudo systemctl daemon-reload
sudo systemctl enable zero-kbd.service
sudo systemctl start zero-kbd.service
