#!/bin/bash

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
    -e "s/COLOR10/$color10/g" \
    -e "s/COLOR11/$color11/g" \
    -e "s/COLOR12/$color12/g" \
    -e "s/COLOR13/$color13/g" \
    -e "s/COLOR14/$color14/g" \
    -e "s/COLOR15/$color15/g" \
    -e "s/COLOR0/$color0/g" \
    -e "s/COLOR1/$color1/g" \
    -e "s/COLOR2/$color2/g" \
    -e "s/COLOR3/$color3/g" \
    -e "s/COLOR4/$color4/g" \
    -e "s/COLOR5/$color5/g" \
    -e "s/COLOR6/$color6/g" \
    -e "s/COLOR7/$color7/g" \
    -e "s/COLOR8/$color8/g" \
    -e "s/COLOR9/$color9/g" \
    ~/.local/bin/pywal-templates/polybar-colors.ini > ~/.config/polybar/shapes/colors.ini