#/bin/bash
WALL=$(find "${HOME}/Pictures/wallpaper/" -type f | sort -R | tail -1)
feh --no-fehbg --bg-scale "$WALL"
# feh --bg-center ${HOME}/Pictures/wallpaper/spark_rc_pro.jpg  --image-bg white
