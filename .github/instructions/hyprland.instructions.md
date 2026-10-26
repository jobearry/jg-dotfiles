---
applyTo: "hyprland/**"
---

# Hyprland instructions

## Version and configuration style

- Target is Hyprland 0.56+ with Lua configuration.
- `hyprland.lua` is the entrypoint. Add new modules there with `require("name")`.
- Keep each concern in its existing file: monitors, autostart, environment, permissions, look and feel, misc, input, keybindings, window rules.
- Do not introduce legacy `.conf` syntax.

## Dispatchers

`hyprctl dispatch` takes Lua expressions on this version:

```sh
hyprctl dispatch 'hl.dsp.exec_cmd("firefox")'
```

This does not work:

```sh
hyprctl dispatch exec firefox
```

Use the patterns already present in `keybindings.lua` and `autostart.lua`.

## Wallpaper and splash

- `misc.lua` disables Hyprland's random built-in wallpaper and logo. Keep it that way unless the user explicitly asks to re-enable them.
- Hyprpaper has its own splash overlay. Keep `splash = false` in `hyprpaper.conf`.
- Hyprland's `misc:disable_splash_rendering` does not control hyprpaper's splash.
- `autostart.lua` starts hyprpaper and runs `waypaper --restore` after a short delay. Do not remove that restore step.

## Reloading and verification

```sh
hyprctl reload
hyprctl configerrors
hyprctl getoption misc:disable_splash_rendering
hyprctl getoption misc:disable_hyprland_logo
hyprctl getoption misc:force_default_wallpaper
```

`hyprctl reload config-only` skips the monitor reload. Use a full reload when validating monitor or splash-related changes.

## Session safety

- Do not launch Hyprland or Waybar from KDE/X11 to test changes.
- Do not kill the running compositor unless the user asks for it.
- Use `hyprctl` against the correct instance, especially if more than one Hyprland instance exists.
