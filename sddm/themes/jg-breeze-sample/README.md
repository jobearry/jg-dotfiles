# SDDM Breeze sample

This is a source-only sample based on the installed KDE Breeze SDDM theme. The
copied QML files retain their upstream copyright and SPDX notices, and the
sample includes the referenced Breeze assets; see
`LICENSE-LGPL-2.0-or-later.txt`.

The sample uses a solid dark background, keeps the login controls horizontally
centered, puts a `Welcome` label above them, and moves the desktop-session menu
into the login controls. It hides the user-avatar carousel, so sign-in uses a
username field instead of a profile silhouette. Change `welcomeText` in
`Login.qml` to customize the label. The theme relies on the Breeze QML
components shipped with Plasma.

Nothing here is installed or enabled automatically. This is not a Stow package:
keep editing the source in this repository, and only copy it into SDDM's system
theme directory when you decide to try it. For example:

```sh
sddm-greeter-qt6 --test-mode --theme "$PWD/sddm/themes/jg-breeze-sample"
sudo install -d /usr/share/sddm/themes/jg-breeze-sample
sudo cp -a sddm/themes/jg-breeze-sample/. /usr/share/sddm/themes/jg-breeze-sample/
```

Then set `Current=jg-breeze-sample` in the `[Theme]` section of
`/etc/sddm.conf.d/10-theme.conf`. A solid-color background is used instead of a
wallpaper; SDDM runs before the desktop session, so it cannot show the live
Hyprland desktop behind the greeter.
