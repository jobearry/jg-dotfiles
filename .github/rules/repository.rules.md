# Repository rules

Non-negotiable rules for humans and AI agents. If a user request conflicts with a rule, ask before proceeding.

## Source of truth and Stow

1. This repo is the source of truth; entries under `$HOME` are installed copies or symlinks.
2. MUST edit repo files, not live files under `$HOME`. If debugging requires a live edit, port it back into the repo.
3. MUST place new files under the correct package path so Stow can link them.
4. MUST use GNU Stow for install and removal. A manual symlink is acceptable only for temporary debugging and must match Stow's relative target.
5. MUST dry-run before a real Stow command: `stow --simulate --verbose=2 --target="$HOME" <package>`.
6. MUST stop and report on `CONFLICT`, `WARNING`, or an unexpected target.
7. MUST NOT use `stow --adopt` without explicit approval.
8. MUST NOT delete or restow unrelated Stow packages without approval.
9. MUST track new files in git. An untracked file is not reproducible.

## Git

1. MUST NOT stage, commit, amend, reset, clean, or check out unrelated user changes.
2. MUST preserve staged and unstaged work.
3. MUST ask before destructive git operations.
4. MAY create a new file, but SHOULD tell the user to commit it unless they asked for a commit.
5. MUST NOT rewrite history or force-push.

## Session and process safety

1. MUST check the active session before launching GUI/session apps. See `$XDG_CURRENT_DESKTOP`, `$HYPRLAND_INSTANCE_SIGNATURE`, and `$WAYLAND_DISPLAY`.
2. MUST NOT start Waybar, Hyprland, hyprpaper, or Waypaper in a KDE/X11 session.
3. MUST NOT kill or restart user applications unless it is part of the requested fix.
4. Prefer graceful reloads (`hyprctl reload`, `pkill -SIGUSR2 waybar`) over kill/restart.

## Hyprland and wallpaper

1. Hyprland 0.56+ uses Lua configuration. Do not mix in legacy `.conf` syntax.
2. `hyprctl dispatch` uses Lua expressions: `hyprctl dispatch 'hl.dsp.exec_cmd("app")'`.
3. Keep `misc.force_default_wallpaper = 0` and `misc.disable_hyprland_logo = true` unless the user asks to re-enable random backgrounds.
4. Keep `splash = false` in `hyprpaper.conf`; hyprpaper draws its own splash overlay.
5. Waypaper is the wallpaper picker. Do not add a second wallpaper daemon.

## Waybar

1. `~/.config/waybar` is a symlink into this repo; do not create a duplicate config.
2. Keep `config.jsonc` valid JSONC, including comments.
3. Preserve `custom/wallpaper`: left click launches `waypaper`, right click runs `waypaper --restore`.
4. Match the existing style conventions in `style.css`.

## General

1. Keep diffs minimal and focused.
2. Match existing formatting, naming, and comments.
3. Do not add secrets, tokens, SSH keys, or machine-specific credentials.
4. Do not refactor unrelated files.
