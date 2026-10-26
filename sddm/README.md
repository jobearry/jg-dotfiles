# SDDM themes

Themes are stored in this directory as source files. They are **not Stow
packages**: SDDM loads its active theme from `/usr/share/sddm/themes/`, and
selects it through system configuration under `/etc`.

## Preview and install a theme

From the repository root, replace `jg-breeze-sample` below with the theme
directory you want to use.

1. Preview it in a window from your current desktop:

   ```sh
   sddm-greeter-qt6 --test-mode --theme "$PWD/sddm/themes/jg-breeze-sample"
   ```

   Check the terminal for `Fallback to embedded theme` or QML errors. If those
   appear, fix the theme before activating it.

2. Copy the theme into SDDM's system theme directory:

   ```sh
   sudo install -d /usr/share/sddm/themes/jg-breeze-sample
   sudo cp -a sddm/themes/jg-breeze-sample/. /usr/share/sddm/themes/jg-breeze-sample/
   ```

   When you edit the repository copy later, repeat the `cp` command to update
   the installed copy.

3. Check whether SDDM already has a theme configured:

   ```sh
   grep -R -n -E '^\[Theme\]|^Current=' /etc/sddm.conf /etc/sddm.conf.d 2>/dev/null
   ```

   Set `Current=jg-breeze-sample` under `[Theme]` in the existing SDDM
   configuration. If there is no existing theme setting, create a drop-in:

   ```sh
   sudo install -d /etc/sddm.conf.d
   sudo tee /etc/sddm.conf.d/10-theme.conf >/dev/null <<'EOF'
   [Theme]
   Current=jg-breeze-sample
   EOF
   ```

   Avoid adding a second conflicting `[Theme]` / `Current=` setting if one is
   already present.

4. Save your work and reboot to see the active login theme. Do not restart SDDM
   from your current desktop session; doing so can end that session.

## Revert to Breeze

Set `Current=breeze` in the SDDM configuration, then reboot. The installed
custom theme can remain in `/usr/share/sddm/themes/`; selecting Breeze makes it
inactive.
