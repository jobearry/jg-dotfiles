-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")
  -- Re-apply the wallpaper chosen with waypaper
  hl.exec_cmd("sh -c 'sleep 1; waypaper --restore'")
  -- Elephant is owned by this session; do not enable the systemd user unit.
  hl.exec_cmd("elephant")
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  -- Prewarm Walker; SUPER + SPACE activates it through its socket.
  hl.exec_cmd("walker --gapplication-service")
end)