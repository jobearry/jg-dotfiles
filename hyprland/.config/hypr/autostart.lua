-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  -- Re-apply the wallpaper chosen with waypaper
  hl.exec_cmd("sh -c 'sleep 1; waypaper --restore'")
  hl.exec_cmd("elephant")
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd("walker --gapplication-service")
end)