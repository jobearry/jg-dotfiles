---
applyTo: "**"
---

# Stow instructions

## Model

- The repository root is the GNU Stow directory.
- The target is `$HOME`.
- A top-level directory is a package.
- Package paths mirror the target tree: `hyprland/.config/hypr/foo.lua` becomes `~/.config/hypr/foo.lua`.

## Adding, renaming, and removing files

1. Add or move the file inside the correct package path.
2. Preview the change:

   ```sh
   stow --simulate --verbose=2 --target="$HOME" <package>
   ```

3. Check that the expected `$HOME` path is created, moved, or removed.
4. Apply it:

   ```sh
   stow --restow --target="$HOME" <package>
   ```

5. Track the change with git.

Do not create the symlink by hand. If a manual link is unavoidable during debugging, it must point to the repo file with the same relative target Stow would use.

## Conflicts

- `CONFLICT` means a real file or directory already exists at the target. Stop and report it.
- Do not delete, move, or overwrite the conflicting user file without explicit approval.
- `stow --adopt` moves the existing target into the repo. Do not use it without explicit approval.
- Folding and unfolding are both normal Stow behavior. Do not fight them by hand.

## Gotchas

- A `.gitkeep` at the package root links to `~/.gitkeep`. Put placeholder files only where the target actually needs them.
- Empty directories are not tracked by git. Do not rely on an empty directory being present after a clone.
- Stow normally creates relative symlinks. Do not replace them with absolute symlinks.
- After a change, verify with `readlink` and the Stow dry-run.
