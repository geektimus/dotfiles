#!/usr/bin/env bash

input=~/.cache/wal/colors.json

background=$(cat $input | jq '.special.background' | tr -d '"')
foreground=$(cat $input | jq '.special.foreground' | tr -d '"')

color0=$(cat $input | jq '.colors.color0' | tr -d '"')
color1=$(cat $input | jq '.colors.color1' | tr -d '"')
color2=$(cat $input | jq '.colors.color2' | tr -d '"')
color3=$(cat $input | jq '.colors.color3' | tr -d '"')
color4=$(cat $input | jq '.colors.color4' | tr -d '"')
color5=$(cat $input | jq '.colors.color5' | tr -d '"')
color6=$(cat $input | jq '.colors.color6' | tr -d '"')
color7=$(cat $input | jq '.colors.color7' | tr -d '"')
color8=$(cat $input | jq '.colors.color8' | tr -d '"')
color9=$(cat $input | jq '.colors.color9' | tr -d '"')
color10=$(cat $input | jq '.colors.color10' | tr -d '"')
color11=$(cat $input | jq '.colors.color11' | tr -d '"')
color12=$(cat $input | jq '.colors.color12' | tr -d '"')
color13=$(cat $input | jq '.colors.color13' | tr -d '"')
color14=$(cat $input | jq '.colors.color14' | tr -d '"')
color15=$(cat $input | jq '.colors.color15' | tr -d '"')

sed -e "s/BGCOLOR/$background/g" \
    -e "s/FGCOLOR/$foreground/g" \
    ~/.local/bin/pywal-templates/dmenu-run.template > ~/.local/bin/dm-run
