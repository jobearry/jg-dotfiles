# AGENTS.md

This is the entry point for AI coding agents working in this repository.

## Goal

This repository is the source of truth for a personal Arch Linux desktop setup. It is installed into `$HOME` with GNU Stow so the environment can be versioned, reviewed, and restored on another machine.

It is not a reusable dotfiles framework. Keep changes small, personal, and consistent with the existing configuration.

## Repository model

Each top-level directory is normally a GNU Stow package that mirrors the target `$HOME` tree:

```text
hyprland/.config/hypr/misc.lua   -> ~/.config/hypr/misc.lua
waybar/.config/waybar/style.css  -> ~/.config/waybar/style.css
bash/.bashrc                     -> ~/.bashrc
local-bin/.local/bin/jg          -> ~/.local/bin/jg
```

| Path | Installed to | Notes |
| --- | --- | --- |
| `bash/` | `~/.bashrc`, `~/.bash_profile`, `~/.bash_logout` | Shell basics. |
| `local-bin/` | `~/.local/bin/` | Personal executable scripts. |
| `hyprland/` | `~/.config/hypr/` | Hyprland 0.56+ Lua config plus `hyprpaper.conf`. |
| `walker/` | `~/.config/walker/` | Walker launcher config; service is prewarmed by Hyprland autostart. |
| `elephant/` | `~/.config/elephant/` | Elephant provider config; owned by Hyprland autostart, not systemd. |
| `waybar/` | `~/.config/waybar/` | Whole directory; currently a folded symlink. |
| `code-oss/` | `~/.config/Code - OSS/User/` | VS Code user settings. |
| `extension-lists/` | Not installed | Reference extension exports, not a Stow package. |
| `vscode/` | Not installed | Empty and untracked; not a package. |

`git ls-files` is authoritative. Empty directories are not tracked by git.

## Stow workflow

Run from the repo root:

```sh
stow --target="$HOME" <package>
stow --restow --target="$HOME" <package>
stow --delete --target="$HOME" <package>
stow --simulate --verbose=2 --target="$HOME" <package>
```

Always dry-run before a real Stow command. Treat `CONFLICT`, an unexpected `WARNING`, or an unexpected target as a stop condition and report it.

To add a file:

1. Put it under the correct package path, for example `hyprland/.config/hypr/new.lua`.
2. Run `stow --simulate --verbose=2 --target="$HOME" hyprland`.
3. Confirm Stow would create `~/.config/hypr/new.lua`.
4. Install it with Stow.
5. Track it with git.

Do not edit installed files under `$HOME` directly. They are usually symlinks into this repo. If a live edit is necessary while debugging, port the change back into the repo before finishing.

## Component notes

### Hyprland

- Target is Hyprland 0.56+ with Lua configuration: `hyprland.lua` plus `require(...)` modules.
- Use the Lua API, not legacy `.conf` syntax.
- `hyprctl dispatch` takes Lua expressions:

  ```sh
  hyprctl dispatch 'hl.dsp.exec_cmd("firefox")'
  ```

  `hyprctl dispatch exec firefox` does not work on this version.
- Keep the random built-in background disabled in `misc.lua` (`force_default_wallpaper = 0`, `disable_hyprland_logo = true`).
- Keep `splash = false` in `hyprpaper.conf`. Hyprpaper draws its own splash overlay; Hyprland's `misc:disable_splash_rendering` does not control it.
- `autostart.lua` launches Waybar, hyprpaper, and other session services, then restores the Waypaper wallpaper after a short delay. Preserve that flow.
- Do not launch Hyprland or Waybar from a KDE/X11 session to test changes.

### Walker and Elephant

- `autostart.lua` starts `elephant` and `walker --gapplication-service`.
- `SUPER + SPACE` activates Walker through `$XDG_RUNTIME_DIR/walker/walker.sock` with `socat`, falling back to the `walker` binary if the socket is unavailable. Do not revert to `hl.dsp.exec_cmd("walker")`.
- Do not run `elephant service enable`. It creates a user systemd unit that outlives the graphical session and duplicates the Hyprland-autostarted Elephant.
- Only one Elephant can own `$XDG_RUNTIME_DIR/elephant/elephant.sock`. Check for duplicates before debugging launcher issues.
- Walker uses the `darker` theme in `walker/.config/walker/themes/darker/style.css`. Keep its window background translucent; the `walker` layer rule in `looknfeel.lua` enables blur.

### Waybar

- `~/.config/waybar` is a symlink into this repo. Edit only the repo files.
- `config.jsonc` is JSONC and intentionally contains comments. Keep it valid JSONC.
- Preserve `custom/wallpaper`: left click opens `waypaper`, right click runs `waypaper --restore`.
- Keep styling in `style.css` and match the existing font/color conventions.
- Some modules reference external scripts that are not tracked here. Check before assuming a script exists.

### Wallpaper

- Waypaper is the picker; hyprpaper is the backend.
- Do not reintroduce Hyprland's random default wallpaper.
- If splash text appears, check `hyprpaper.conf` before changing Hyprland settings.

### Bash and Code - OSS

- Keep Bash configuration minimal and portable.
- The `code-oss` path contains a space; quote it in shell commands.
- `extension-lists/` is reference data, not a Stow package.

## Safety

- Do not stage, commit, amend, revert, reset, clean, or check out unrelated user changes.
- Do not use `stow --adopt` without explicit approval; it moves files from `$HOME` into the repo.
- Do not run destructive commands (`rm -rf`, `git reset --hard`, `git clean -fdx`, deleting symlinks) without explicit approval.
- Do not kill or restart user applications unless it is part of the requested fix.
- Do not add secrets, tokens, SSH keys, or machine-specific credentials.
- New files must be tracked in git to be reproducible.

## Verification

```sh
stow --simulate --verbose=2 --target="$HOME" <package>

hyprctl reload
hyprctl configerrors
hyprctl getoption misc:disable_splash_rendering

# Inside Hyprland only
pkill -SIGUSR2 waybar
pgrep -a -x walker
ss -xlpn | grep -E 'walker|elephant'
```

## Further context

- [.github/docs/architecture.md](.github/docs/architecture.md)
- [.github/docs/bash-scripts.md](.github/docs/bash-scripts.md)
- [.github/rules/repository.rules.md](.github/rules/repository.rules.md)
- [.github/instructions/](.github/instructions/)
