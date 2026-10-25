-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
require("monitors")

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
require("autostart")

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
require("environment")

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
require("permissions")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
require("looknfeel")
require("misc")
require("input")
require("keybindings")

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
require("window-rules")