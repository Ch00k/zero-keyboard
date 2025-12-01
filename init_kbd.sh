#!/usr/bin/env bash

USB_GADGET_DIR=/sys/kernel/config/usb_gadget
KBD_GADGET_DIR=${USB_GADGET_DIR}/zero_kbd
KBD_STRINGS_DIR=${KBD_GADGET_DIR}/strings/0x409
KBD_CONFIGS_DIR=${KBD_GADGET_DIR}/configs/c.1
KBD_CONFIG_STRINGS_DIR=${KBD_CONFIGS_DIR}/strings/0x409
KBD_FUNCTIONS_DIR=${KBD_GADGET_DIR}/functions/hid.usb0
KBD_FUNCTIONS_LINK=${KBD_CONFIGS_DIR}/hid.usb0
KBD_UDC_FILE=${KBD_GADGET_DIR}/UDC

# Unbind gadget if already bound
if [ -f ${KBD_UDC_FILE} ]; then
    echo "" >${KBD_UDC_FILE} 2>/dev/null || true
fi

# Remove existing gadget to ensure clean state
rm -rf ${KBD_GADGET_DIR}

mkdir -p ${KBD_GADGET_DIR}
mkdir -p ${KBD_STRINGS_DIR}
mkdir -p ${KBD_CONFIG_STRINGS_DIR}
mkdir -p ${KBD_FUNCTIONS_DIR}

echo 0x1d6b >${KBD_GADGET_DIR}/idVendor  # Linux Foundation
echo 0x0104 >${KBD_GADGET_DIR}/idProduct # Multifunction Composite Gadget
echo 0x0110 >${KBD_GADGET_DIR}/bcdDevice # v1.1.0
echo 0x0200 >${KBD_GADGET_DIR}/bcdUSB    # USB2.0

echo "ZK0000000001" >${KBD_STRINGS_DIR}/serialnumber
echo "Zero Inc." >${KBD_STRINGS_DIR}/manufacturer
echo "Zero Keyboard" >${KBD_STRINGS_DIR}/product

echo "Config 1: HID Keyboard" >${KBD_CONFIG_STRINGS_DIR}/configuration
echo 0x80 >${KBD_CONFIGS_DIR}/bmAttributes # Bus-powered
echo 250 >${KBD_CONFIGS_DIR}/MaxPower

echo 1 >${KBD_FUNCTIONS_DIR}/protocol
echo 1 >${KBD_FUNCTIONS_DIR}/subclass
echo 9 >${KBD_FUNCTIONS_DIR}/report_length

# HID Report Descriptor - see hid_report_desc.md for byte-by-byte documentation
/usr/bin/printf '%b' \
    '\x05\x01' \
    '\x09\x06' \
    '\xa1\x01' \
    '\x85\x01' \
    '\x05\x07' \
    '\x19\xe0' \
    '\x29\xe7' \
    '\x15\x00' \
    '\x25\x01' \
    '\x75\x01' \
    '\x95\x08' \
    '\x81\x02' \
    '\x95\x01' \
    '\x75\x08' \
    '\x81\x03' \
    '\x95\x05' \
    '\x75\x01' \
    '\x05\x08' \
    '\x19\x01' \
    '\x29\x05' \
    '\x91\x02' \
    '\x95\x01' \
    '\x75\x03' \
    '\x91\x03' \
    '\x95\x06' \
    '\x75\x08' \
    '\x15\x00' \
    '\x25\x65' \
    '\x05\x07' \
    '\x19\x00' \
    '\x29\x65' \
    '\x81\x00' \
    '\xc0' \
    '\x05\x0c' \
    '\x09\x01' \
    '\xa1\x01' \
    '\x85\x02' \
    '\x15\x00' \
    '\x25\x01' \
    '\x75\x01' \
    '\x95\x08' \
    '\x09\xe9' \
    '\x09\xea' \
    '\x09\xe2' \
    '\x09\xcd' \
    '\x09\xb5' \
    '\x09\xb6' \
    '\x09\xb7' \
    '\x0a\x8a\x01' \
    '\x81\x02' \
    '\x95\x08' \
    '\x09\x6f' \
    '\x09\x70' \
    '\x0a\x21\x02' \
    '\x0a\x23\x02' \
    '\x0a\x24\x02' \
    '\x0a\x25\x02' \
    '\x0a\x26\x02' \
    '\x0a\x27\x02' \
    '\x81\x02' \
    '\x95\x01' \
    '\x09\xb8' \
    '\x81\x02' \
    '\x95\x07' \
    '\x81\x03' \
    '\xc0' \
    '\x05\x01' \
    '\x09\x80' \
    '\xa1\x01' \
    '\x85\x03' \
    '\x15\x00' \
    '\x25\x01' \
    '\x75\x01' \
    '\x95\x03' \
    '\x09\x81' \
    '\x09\x82' \
    '\x09\x83' \
    '\x81\x02' \
    '\x95\x05' \
    '\x81\x03' \
    '\xc0' \
    >${KBD_FUNCTIONS_DIR}/report_desc

ln -s ${KBD_FUNCTIONS_DIR} ${KBD_FUNCTIONS_LINK}

# Bind to the first available UDC
# shellcheck disable=SC2012
UDC=$(ls /sys/class/udc 2>/dev/null | head -n1)
if [ -z "$UDC" ]; then
    echo "Error: No UDC (USB Device Controller) found" >&2
    exit 1
fi
echo "$UDC" >${KBD_UDC_FILE}
