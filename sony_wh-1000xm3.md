# Sony WH-1000XM3 Config

## Bluetooth
- Set bluetooth to turn on during startup:
  - `/etc/bluetooth/main.conf`
  - `[Policy] AutoEnable=true`
- Bluetooth headset
  - Install `pulseaudio-modules-bt-git` from AUR
  - Add lines to `default.pa` in `/etc/pulse` or `~/.config/pulse` :
    - `load-module module-bluetooth-policy`
    - `load-module module-bluetooth-discover a2dp_config="aac_bitrate_mode=5"`
    - For settings, refer to `https://github.com/EHfive/pulseaudio-modules-bt`
    - `load-module module-switch-on-connect`
  - A workaround is needed for `bluez<=5.5.0` involving DBus, refer to 
    `https://github.com/liskin/dotfiles/blob/home/bin/bluetooth-fix-a2dp` and 
    `https://github.com/liskin/dotfiles/blob/home/.config/systemd/user/bluetooth-fix-a2dp.service`
  - In order to switch/choose between A2DP profiles, modify the 
    `bluetooth.service` file and append the `-E` flag to the line containing 
    `bluetoothd`
