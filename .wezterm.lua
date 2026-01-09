local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.default_domain = "WSL:Ubuntu-24.04"
config.audible_bell = "Disabled"


config.window_background_opacity = 0.6
config.win32_system_backdrop = "Acrylic"

config.font_size = 11
config.font = wezterm.font { 
  family = "FiraCode Nerd Font", weight = 'Medium' 
}
-- config.color_scheme = "tokyonight_night"
config.color_scheme = "Apple System Colors"
config.colors = {
  cursor_bg = "#7aa2f7",
  cursor_border = "#7aa2f7",
}

-- config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.mouse_bindings = mouse_bindings

config.keys = {
  {
    key = "v",
    mods = "CTRL",
    action = act.PasteFrom "Clipboard",
  },
  {
    key = "w",
    mods = "CTRL",
    action = act.CloseCurrentPane { confirm = true },
  },
  { key = "d", 
    mods = "CTRL", 
    action = act.SplitHorizontal {domain = "CurrentPaneDomain"} 
  }, 
  { key = "e", 
    mods = "CTRL", 
    action = act.SplitVertical {domain = "CurrentPaneDomain"} 
  },
  {
    key = "Backspace",
    mods = "CTRL",
    action = act.SendKey { key = "w", mods = "CTRL" },
  },
  {
    key = "Delete",
    mods = "CTRL",
    action = act.SendString("\x1bd"),
  },
  {
    key = "LeftArrow",
    mods = "CTRL",
    action = act.SendKey { key = "b", mods = "ALT" },
  },
  {
    key = "RightArrow",
    mods = "CTRL",
    action = act.SendKey { key = "f", mods = "ALT" },
  },
}

return config
