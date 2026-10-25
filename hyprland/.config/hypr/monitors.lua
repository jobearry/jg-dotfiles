-- samsung monitor
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = "1",
})

-- default laptop monitor
hl.monitor({
    output = "eDP-2",
    mode = "preferred",
    position = "1920x0",
    scale = "1",
})