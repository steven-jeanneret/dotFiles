#/bin/bash
WALL=$(find "${HOME}/Pictures/wallpaper/" -type f | sort -R | tail -1)
feh --no-fehbg --bg-scale "$WALL"
