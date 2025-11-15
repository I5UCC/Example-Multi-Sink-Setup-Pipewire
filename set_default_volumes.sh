#!/bin/bash

# PipeWire Sink Volume Defaults
# This script sets default volumes for your virtual sinks

# Sink names (match your PipeWire config)
MAIN_SINK="main_output"
MEDIA_SINK="media_output"
VOICE_SINK="voice_output"
HARDWARE_SINK="replace_me_with_your_hardware_sink_name"

# Default volumes (percentage: 0-100, or over 100 for boost)
MAIN_VOLUME="30%"
MEDIA_VOLUME="40%"
VOICE_VOLUME="55%"
HARDWARE_VOLUME="100%"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Setting default volumes for PipeWire sinks..."
echo ""

# Function to set volume
set_volume() {
    local sink_name=$1
    local volume=$2
    local label=$3
    
    if pactl set-sink-volume "$sink_name" "$volume" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $label: $volume"
    else
        echo -e "${RED}✗${NC} $label: Failed (sink may not exist yet)"
        return 1
    fi
}

# Set volumes
set_volume "$MAIN_SINK" "$MAIN_VOLUME" "Game"
set_volume "$MEDIA_SINK" "$MEDIA_VOLUME" "Media"
set_volume "$VOICE_SINK" "$VOICE_VOLUME" "Voice"
set_volume "$HARDWARE_SINK" "$HARDWARE_VOLUME" "Hardware Output"

echo ""
echo "Done! Current sink volumes:"
echo ""

# Show current volumes
pactl list sinks | grep -E "(Name:|Volume:)" | grep -A1 -E "(game_output|music_output|voice_output|alsa_output.pci-0000_2d_00.4.iec958-stereo)" | sed 's/^/  /'

echo ""
echo "Setting default sink..."

# Set default sink
if pactl set-default-sink "$MAIN_SINK" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Default sink set to: $MAIN_SINK"
else
    echo -e "${RED}✗${NC} Failed to set default sink"
fi
