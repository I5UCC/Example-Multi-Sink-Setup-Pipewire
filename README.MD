Example Triple virtual sink setup for Pipewire.

It creates 3 passive virtual sinks that target to the easyeffects sink:
- Main (Default device, controlls all new Programs volume)
- Media (Device for programs like Spotify or Browsers)
- VOIP (Device for VOIP programs like Discord or Teamspeak)

## Notes
- If you dont use Easyeffects:
  - change the target.object to your actual hardware sink.
- If you're using EasyEffects: 
  - don't apply it to all devices, set default device only to your headphones
  - dont route programs throught easy effects itself, the virtual devices already do that.

## Setup

- Place [01-virtual-channels.conf](https://raw.githubusercontent.com/I5UCC/Example-Multi-Sink-Setup-Pipewire/refs/heads/main/01-virtual-channels.conf) your home directorys config folder (create folders if don't exist):

```bash
.config/pipewire/pipewire.conf.d
```

- restart pipewire `systemctl --user restart pipewire.service`
- or restart your device.

## Controlling each sinks volume

You can control each output via the pactl command (maybe as a keyboard shortcut)

```bash
#decrease main sink volume by 2%
pactl set-sink-volume main_output -2%
#increase main sink volume by 2%
pactl set-sink-volume main_output +2%

#decrease media sink volume by 2%
pactl set-sink-volume media_output -2%
#increase media sink volume by 2%
pactl set-sink-volume media_output +2%

#decrease voip sink volume by 2%
pactl set-sink-volume media_output -2%
#increase voip sink volume by 2%
pactl set-sink-volume media_output +2%
```

## Default Volumes Script

The bash script [set_default_volumes.sh](https://raw.githubusercontent.com/I5UCC/Example-Multi-Sink-Setup-Pipewire/refs/heads/main/set_default_volumes.sh) sets a set of default volumes set in the variables `MAIN_VOLUME`, `MEDIA_VOLUME` and `VOICE_VOLUME`, and the variable `HARDWARE_SINK` should be replaced by your hardware sink name. You can set it up as an autostart so default volumes are set at the start of your os.
