# Copilot instructions

This repository is a personal Arch Linux dotfiles repo installed with GNU Stow. `AGENTS.md` is the full guide; this file is the short repository-wide version.

## Must follow

- Edit files in this repo, not the symlinked copies under `$HOME`.
- Each top-level directory is usually a Stow package that mirrors `$HOME` (`hyprland/.config/hypr/` -> `~/.config/hypr/`).
- Before any Stow change, run `stow --simulate --verbose=2 --target="$HOME" <package>`. Stop on conflicts.
- Do not stage, commit, revert, clean, or check out unrelated user changes.
- Do not launch Waybar, Hyprland, hyprpaper, or Waypaper in KDE/X11 or another wrong session.
- Keep diffs small and match the existing style. Do not turn this into a framework rewrite.
- Track new files with git.
- Hyprland 0.56+ uses Lua. Use `hyprctl dispatch 'hl.dsp.exec_cmd("...")'`, not `hyprctl dispatch exec ...`.
- Hyprpaper's splash is disabled with `splash = false` in `hyprland/.config/hypr/hyprpaper.conf`. Hyprland's `misc:disable_splash_rendering` does not control that overlay.

## Context

- Architecture and package map: `.github/docs/architecture.md`
- Non-negotiable rules: `.github/rules/repository.rules.md`
- Path-specific instructions: `.github/instructions/*.instructions.md`
