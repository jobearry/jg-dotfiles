# Personal Bash scripts

Custom commands that should be available from a Bash prompt belong in the
`local-bin/` Stow package. Its paths mirror the home directory:

```text
local-bin/.local/bin/jg  ->  ~/.local/bin/jg
```

Keep the script in the repository; do not edit the installed path under `$HOME`
directly. A stowed file is a symlink to the repository file, so its executable
permission comes from the source file.

## Adding a command

1. Create the script under `local-bin/.local/bin/`. Name it for the command
   users should type; for example, the file named `jg` provides the `jg`
   command.
2. Start a Bash script with a shebang and strict mode:

   ```bash
   #!/usr/bin/env bash
   set -euo pipefail
   ```

3. Make the repository file executable:

   ```sh
   chmod +x local-bin/.local/bin/<command>
   ```

4. Check its syntax:

   ```sh
   bash -n local-bin/.local/bin/<command>
   ```

5. Preview Stow before installing or changing the package:

   ```sh
   stow --simulate --verbose=2 --target="$HOME" local-bin
   ```

   Stop if the preview reports a conflict, an unexpected warning, or an
   unexpected target. If the preview is as expected, install the package:

   ```sh
   stow --target="$HOME" local-bin
   ```

   If `~/.local/bin` is already a folded symlink to this package, adding a file
   under it may make that file available immediately. Still use the preview to
   check the package state.

6. Confirm `~/.local/bin` is on `PATH` and Bash finds the command:

   ```sh
   printf '%s\n' "$PATH"
   command -v <command>
   ```

   This repository adds `~/.local/bin` to `PATH` in `bash/.bashrc`. Open a new
   terminal or run `source ~/.bashrc` to load that change in the current one.

## Command behavior

Scripts receive arguments in `"$1"`, `"$2"`, and so on. Check the argument
count and allowed values before using them, quote expansions, and show a
usage message for invalid input. For example, `jg` accepts a connection name
using:

```bash
jg -r homelab
```

The script validates that the name contains only letters, numbers,
underscores, and hyphens before using it as part of a file path.

## User data and permissions

Keep personal, changeable script data outside the Stow package. `jg` saves each
connection in `${XDG_CONFIG_HOME:-$HOME/.config}/jg/<name>`; for example,
`jg -r homelab` uses `~/.config/jg/homelab` when `XDG_CONFIG_HOME` is unset.
The file contains the SSH host on the first line and username on the second.
The script creates the config directory with owner-only permissions and uses a
restrictive umask when creating connection files.

Do not store passwords, private keys, tokens, or other secrets in a script or
its config files. Use SSH keys and the system's normal SSH configuration for
authentication. Never print secret values in diagnostics.

When a script is intended to run as `<command>`, it needs both an executable
permission and a filename matching that command. Running `bash
~/.local/bin/<command>` explicitly does not require the executable bit.
