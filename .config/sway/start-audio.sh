#!/bin/bash
echo "start-audio.sh running at $(date)" >> /tmp/audio-start.log

# Ensure runtime dir is set
export XDG_RUNTIME_DIR="/tmp/xdg-runtime-$(id -u)"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

# Start DBus session if needed
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval "$(dbus-launch --sh-syntax)"
fi

# Kill any old instances
pkill -x pipewire
pkill -x pipewire-pulse
pkill -x wireplumber
# Start PipeWire core
pipewire &
sleep 1

# Start Pulse plugin
pipewire-pulse &
sleep 1

# Wait for pipewire to become available (up to 3s)
for i in {1..30}; do
    if pw-cli info > /dev/null 2>&1; then
        break
    fi
    sleep 0.1
done

# Now launch wireplumber
wireplumber >> /tmp/wireplumber.log 2>&1 &
