# Architecture

## Goal

Personal Arch Linux dotfiles, installed into `$HOME` with GNU Stow. This repository is the source of truth; live configs are symlinks back here.

## Stow model

GNU Stow uses this repo as the Stow directory and `$HOME` as the target:

```sh
cd ~/dev/jg-dotfiles
stow --target="$HOME" <package>
```

A package mirrors the target tree:

```text
hyprland/.config/hypr/misc.lua
  -> ~/.config/hypr/misc.lua

waybar/.config/waybar/
  -> ~/.config/waybar/   (folded directory symlink)

bash/.bashrc
  -> ~/.bashrc
```

Directories may be folded (one symlink for the whole tree) or unfolded (one symlink per file), depending on conflicts. Both are normal. Do not "fix" folding by hand.

Current observed layout:

- `~/.config/waybar` is one symlink to the package directory.
- `~/.config/walker` and `~/.config/elephant` are folded symlinks to their package directories.
- `~/.config/hypr` is a real directory containing per-file symlinks.

## Packages

| Top-level path | Stow target | Status / notes |
| --- | --- | --- |
| `bash/` | `~/.bashrc`, `~/.bash_profile`, `~/.bash_logout` | Active. |
| `hyprland/` | `~/.config/hypr/` | Active; Hyprland 0.56+ Lua and `hyprpaper.conf`. |
| `walker/` | `~/.config/walker/` | Active; Walker overrides merged with packaged defaults. |
| `elephant/` | `~/.config/elephant/` | Active; Elephant overrides merged with built-in defaults. |
| `fonts/` | `~/.local/share/fonts/` | JetBrainsMono Nerd Font Regular and its OFL license. |
| `waybar/` | `~/.config/waybar/` | Active; folder symlink. |
| `code-oss/` | `~/.config/Code - OSS/User/` | Active; `settings.json`. |
| `extension-lists/` | None | Reference data only. |
| `vscode/` | None | Empty and untracked; not a package. |

The authoritative list is `git ls-files`. Empty directories are not tracked by git.

## Hyprland layout

`hyprland.lua` is the entrypoint and `require`s:

- `monitors.lua` - monitor layout
- `autostart.lua` - startup processes and wallpaper restore
- `environment.lua` - cursor and KDE Qt platform theme environment
- `permissions.lua` - permission rules, mostly commented out
- `looknfeel.lua` - general, decoration, animations
- `misc.lua` - built-in wallpaper, logo, and splash settings
- `input.lua` - keyboard, touchpad, gestures
- `keybindings.lua` - keybinds
- `window-rules.lua` - window and layer rules
- `hyprpaper.conf` - hyprpaper configuration (`splash = false`)

## Wallpaper flow

1. Hyprland starts.
2. `autostart.lua` launches `hyprpaper`.
3. `autostart.lua` runs `waypaper --restore` after a short delay.
4. Waypaper tells hyprpaper which wallpaper to use.
5. Hyprland's built-in random wallpaper and logo are disabled in `misc.lua`.
6. Hyprpaper's own splash overlay is disabled in `hyprpaper.conf`.

Waybar's `custom/wallpaper` module is the picker:

- Left click: `waypaper`
- Right click: `waypaper --restore`

## Launcher flow

1. Hyprland starts.
2. `autostart.lua` launches `elephant`.
3. `autostart.lua` starts `walker --gapplication-service`, prewarming the UI.
4. `SUPER + SPACE` connects to `$XDG_RUNTIME_DIR/walker/walker.sock` with `socat`.
5. Walker queries Elephant over `$XDG_RUNTIME_DIR/elephant/elephant.sock`.
6. Elephant's `desktopapplications` provider finds and launches apps.

Opening Walker through its socket avoids starting a new `walker` client process. The keybind falls back to `walker` if the socket is missing.

Walker uses the `darker` theme from the `walker` package. Its background is translucent so the `walker` layer rule in `looknfeel.lua` can show Hyprland's blur behind it.

## Known quirks

- `hyprland/.gitkeep` is at the package root, so a plain Stow run would link it to `~/.gitkeep`. Avoid adding package-root `.gitkeep` files; prefer keeping real files in the package.
- `code-oss/.config/Code - OSS/User/README.md` is inside the Stow tree, so Stow would link it into the user's VS Code config. It is documentation, not an app config.
- `extension-lists/` is not a Stow package even though it is top-level.
- `vscode/` is empty and untracked; it will not exist after a fresh clone.
- Hyprland 0.56 uses Lua dispatchers. `hyprctl dispatch exec ...` does not work; use `hyprctl dispatch 'hl.dsp.exec_cmd("...")'`.
- Hyprland's `misc:disable_splash_rendering` does not control hyprpaper's splash overlay.
- Elephant is intentionally owned by Hyprland autostart. Do not enable `elephant.service`; it outlives the session and conflicts with the autostarted instance on the shared socket.
- Walker is opened through `$XDG_RUNTIME_DIR/walker/walker.sock`, not by starting the `walker` binary.

## Validation

```sh
stow --simulate --verbose=2 --target="$HOME" hyprland
stow --simulate --verbose=2 --target="$HOME" walker
stow --simulate --verbose=2 --target="$HOME" elephant
stow --simulate --verbose=2 --target="$HOME" waybar
stow --simulate --verbose=2 --target="$HOME" code-oss
stow --simulate --verbose=2 --target="$HOME" bash

hyprctl configerrors
hyprctl getoption misc:disable_splash_rendering
pgrep -a -x walker
ss -xlpn | grep -E 'walker|elephant'
```
