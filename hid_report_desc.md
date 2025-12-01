# HID Report Descriptor Documentation

This descriptor defines three separate report interfaces:
1. Standard keyboard (Report ID 1): modifiers + 6 key rollover
2. Consumer control (Report ID 2): media keys, volume, brightness, eject, etc.
3. System control (Report ID 3): power, sleep, wake buttons

## Byte-by-Byte Breakdown

| Bytes | Description |
|-------|-------------|
| `\x05\x01` | Usage Page (Generic Desktop) |
| `\x09\x06` | Usage (Keyboard) |
| `\xa1\x01` | Collection (Application) |
| `\x85\x01` | Report ID (1) - Keyboard |
| `\x05\x07` | Usage Page (Keyboard/Keypad) |
| `\x19\xe0` | Usage Minimum (Left Control) |
| `\x29\xe7` | Usage Maximum (Right GUI) |
| `\x15\x00` | Logical Minimum (0) |
| `\x25\x01` | Logical Maximum (1) |
| `\x75\x01` | Report Size (1 bit) |
| `\x95\x08` | Report Count (8) - 8 modifier keys |
| `\x81\x02` | Input (Data, Variable, Absolute) - Modifier byte |
| `\x95\x01` | Report Count (1) |
| `\x75\x08` | Report Size (8 bits) |
| `\x81\x03` | Input (Constant) - Reserved byte |
| `\x95\x05` | Report Count (5) |
| `\x75\x01` | Report Size (1 bit) |
| `\x05\x08` | Usage Page (LEDs) |
| `\x19\x01` | Usage Minimum (Num Lock) |
| `\x29\x05` | Usage Maximum (Kana) |
| `\x91\x02` | Output (Data, Variable, Absolute) - LED report |
| `\x95\x01` | Report Count (1) |
| `\x75\x03` | Report Size (3 bits) |
| `\x91\x03` | Output (Constant) - LED padding |
| `\x95\x06` | Report Count (6) |
| `\x75\x08` | Report Size (8 bits) |
| `\x15\x00` | Logical Minimum (0) |
| `\x25\x65` | Logical Maximum (101) |
| `\x05\x07` | Usage Page (Keyboard/Keypad) |
| `\x19\x00` | Usage Minimum (0) |
| `\x29\x65` | Usage Maximum (101) |
| `\x81\x00` | Input (Data, Array) - 6 key codes |
| `\xc0` | End Collection |
| `\x05\x0c` | Usage Page (Consumer Devices) |
| `\x09\x01` | Usage (Consumer Control) |
| `\xa1\x01` | Collection (Application) |
| `\x85\x02` | Report ID (2) - Consumer Control |
| `\x15\x00` | Logical Minimum (0) |
| `\x25\x01` | Logical Maximum (1) |
| `\x75\x01` | Report Size (1 bit) |
| `\x95\x08` | Report Count (8) |
| `\x09\xe9` | Usage (Volume Up) |
| `\x09\xea` | Usage (Volume Down) |
| `\x09\xe2` | Usage (Mute) |
| `\x09\xcd` | Usage (Play/Pause) |
| `\x09\xb5` | Usage (Next Track) |
| `\x09\xb6` | Usage (Previous Track) |
| `\x09\xb7` | Usage (Stop) |
| `\x0a\x8a\x01` | Usage (Mail) |
| `\x81\x02` | Input (Data, Variable, Absolute) |
| `\x95\x08` | Report Count (8) |
| `\x09\x6f` | Usage (Brightness Up) |
| `\x09\x70` | Usage (Brightness Down) |
| `\x0a\x21\x02` | Usage (AC Search) |
| `\x0a\x23\x02` | Usage (AC Home) |
| `\x0a\x24\x02` | Usage (AC Back) |
| `\x0a\x25\x02` | Usage (AC Forward) |
| `\x0a\x26\x02` | Usage (AC Stop) |
| `\x0a\x27\x02` | Usage (AC Refresh) |
| `\x81\x02` | Input (Data, Variable, Absolute) |
| `\x95\x01` | Report Count (1) |
| `\x09\xb8` | Usage (Eject) |
| `\x81\x02` | Input (Data, Variable, Absolute) |
| `\x95\x07` | Report Count (7) |
| `\x81\x03` | Input (Constant) - Padding |
| `\xc0` | End Collection |
| `\x05\x01` | Usage Page (Generic Desktop) |
| `\x09\x80` | Usage (System Control) |
| `\xa1\x01` | Collection (Application) |
| `\x85\x03` | Report ID (3) - System Control |
| `\x15\x00` | Logical Minimum (0) |
| `\x25\x01` | Logical Maximum (1) |
| `\x75\x01` | Report Size (1 bit) |
| `\x95\x03` | Report Count (3) |
| `\x09\x81` | Usage (System Power Down) |
| `\x09\x82` | Usage (System Sleep) |
| `\x09\x83` | Usage (System Wake Up) |
| `\x81\x02` | Input (Data, Variable, Absolute) |
| `\x95\x05` | Report Count (5) |
| `\x81\x03` | Input (Constant) - Padding |
| `\xc0` | End Collection |
