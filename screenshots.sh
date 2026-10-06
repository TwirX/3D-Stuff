#!/usr/bin/env bash
set -euo pipefail

model="${1:?Usage: bash screenshots.sh model.scad}"
out="${2:-screenshots}"
mkdir -p "$out"

while read -r view rotation; do
    flatpak run org.openscad.OpenSCAD \
        -o "${out}/$(basename "$model" .scad)_${view}.png" \
        --camera="0,0,0,$rotation,500" \
        --autocenter \
        --viewall \
        --projection=ortho \
        --imgsize=2048,1152 \
        --render=true \
        "$model"
done <<'VIEWS'
top    0,0,0
bottom 180,0,0
front  90,0,0
back   90,0,180
left   90,0,90
right  90,0,270
diagonal_above_front_right 55,0,25
diagonal_above_back_right  55,0,115
diagonal_above_back_left   55,0,205
diagonal_above_front_left  55,0,295
diagonal_below_front_right 125,0,25
diagonal_below_back_right  125,0,115
diagonal_below_back_left   125,0,205
diagonal_below_front_left  125,0,295
VIEWS
