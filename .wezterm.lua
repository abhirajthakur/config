local wezterm = require("wezterm")
local config = wezterm.config_builder()
local action = wezterm.action

config.default_domain = "WSL:Ubuntu-22.04"
config.audible_bell = "Disabled"

config.font_size = 11
config.font = wezterm.font("FiraCode Nerd Font")
config.color_scheme = "tokyonight_night"
config.colors = {
	cursor_bg = "#7aa2f7",
	cursor_border = "#7aa2f7"
}

config.mouse_bindings = mouse_bindings
config.keys = {
	{ 
		key = 'V', 
		mods = 'CTRL', 
		action = action.PasteFrom 'Clipboard' 
	},
	{ 
		key = 'w', 
		mods = 'CTRL', 
		action = action.CloseCurrentPane { confirm = false }, 
	},
	{ 
		key = 'd', 
		mods = 'CTRL', 
		action = action.SplitHorizontal { domain = 'CurrentPaneDomain' }, 
	},
	{ 
		key = 'e', 
		mods = 'CTRL', 
		action = action.SplitVertical { domain = 'CurrentPaneDomain' }, 
	},
	{
		key = "Backspace",
	    mods = "CTRL",
	    action = action.SendKey { key = "w", mods = "CTRL" },
    },

}


-- config.window_decorations = "RESIZE"
config.enable_tab_bar = false

return config
