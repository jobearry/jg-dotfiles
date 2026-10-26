---
applyTo: "waybar/**"
---

# Waybar instructions

## Source files

- `~/.config/waybar` is a symlink into this repository. Edit only `waybar/.config/waybar/`.
- `config.jsonc` is JSONC and intentionally uses comments. Keep it valid JSONC.
- `style.css` holds styling. Match the existing font, spacing, and color conventions.

## Modules

- Preserve `custom/wallpaper`:
  - left click: `waypaper`
  - right click: `waypaper --restore`
- If you add or rename a module, update both `config.jsonc` and `style.css`.
- Some modules reference external scripts that are not tracked here. Check for the script before assuming it exists.

## Reloading

Reload Waybar from inside Hyprland only:

```sh
pkill -SIGUSR2 waybar
```

Do not start Waybar in KDE/X11 just to test a config change. If Waybar is not running, ask the user or wait until the Hyprland session is active.

## Style

- Keep the existing top-bar layout and dimensions unless the request is specifically about layout.
- Reuse existing color values and module selectors instead of introducing a new theme.
- Keep diffs focused; do not reformat the whole file.
