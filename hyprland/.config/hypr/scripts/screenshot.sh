#!/bin/sh
# Hyprland screenshot helper.
# grim captures, satty annotates, wl-copy copies, and the result is also
# saved under $HOME/Pictures/Screenshots.
#
# Usage: screenshot.sh [region|output|window]
# Bound in keybindings.lua. Requires: grim, slurp, satty, wl-clipboard.
set -eu

mode="${1:-region}"
dir="$HOME/Pictures/Screenshots"
file="$dir/$(date +%Y%m%d_%H%M%S).png"
tmp="$(mktemp --suffix=.png "${XDG_RUNTIME_DIR:-/tmp}/screenshot.XXXXXX")"
trap 'rm -f "$tmp"' EXIT INT TERM

mkdir -p "$dir"

case "$mode" in
    region)
        # slurp exits non-zero when the selection is cancelled.
        geometry="$(slurp)" || exit 0
        grim -g "$geometry" "$tmp"
        ;;
    output)
        grim "$tmp"
        ;;
    window)
        geometry="$(hyprctl activewindow | awk '
            /^\tat:/   { gsub(",", " "); x = $2; y = $3 }
            /^\tsize:/ { gsub(",", " "); w = $2; h = $3 }
            END { if (w) printf "%d,%d %dx%d\n", x, y, w, h }')"
        if [ -z "$geometry" ]; then
            notify-send "Screenshot" "No active window to capture"
            exit 1
        fi
        grim -g "$geometry" "$tmp"
        ;;
    *)
        echo "usage: ${0##*/} [region|output|window]" >&2
        exit 2
        ;;
esac

# Enter copies (and saves a file), Ctrl+Shift+S saves, Escape discards.
satty --filename "$tmp" \
    --resize smart \
    --output-filename "$file" \
    --copy-command wl-copy \
    --save-after-copy
