local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.default_domain = "WSL:Ubuntu-22.04"
config.audible_bell = "Disabled"

config.font_size = 10.5
config.font = wezterm.font("FiraCode Nerd Font")
config.color_scheme = "tokyonight_night"
config.colors = {
    cursor_bg = "#7aa2f7",
    cursor_border = "#7aa2f7"
}

config.mouse_bindings = mouse_bindings
config.keys = {
    {
        key = "V",
        mods = "CTRL",
        action = act.PasteFrom "Clipboard"
    },
    {
        key = "w",
        mods = "CTRL",
        action = act.CloseCurrentPane {confirm = false}
    },
    {
        key = "d",
        mods = "CTRL",
        action = act.SplitHorizontal {domain = "CurrentPaneDomain"}
    },
    {
        key = "e",
        mods = "CTRL",
        action = act.SplitVertical {domain = "CurrentPaneDomain"}
    },
    {
        key = "Backspace",
        mods = "CTRL",
        action = act.SendKey {key = "w", mods = "CTRL"}
    },
    {
        key = "Delete",
        mods = "CTRL",
        action = act.SendKey {key = "W", mods = "CTRL"}
    },
    {
        key = "LeftArrow",
        mods = "CTRL",
        action = act.SendKey {key = "b", mods = "ALT"}
    },
    {
        key = "RightArrow",
        mods = "CTRL",
        action = act.SendKey {key = "f", mods = "ALT"}
    }
}

-- config.window_decorations = "RESIZE"
config.enable_tab_bar = false

return config
