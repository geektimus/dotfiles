#!/bin/sh

# systray battery icon
pidof cbatticon || cbatticon -u 5 &
# systray volume
pidof volumeicon || volumeicon &
