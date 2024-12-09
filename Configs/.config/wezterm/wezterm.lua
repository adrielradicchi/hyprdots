-- Pull in the wezterm API
local wezterm = require("wezterm")

local gpus = wezterm.gui.enumerate_gpus()

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Mocha"
	end
end

config.color_scheme_dirs = {
	"~/.config/wezterm/dracula.toml",
	"~/.config/wezterm/catppuccin-frappe.toml",
	"~/.config/wezterm/catppuccin-latte.toml",
	"~/.config/wezterm/catppuccin-macchiato.toml",
	"~/.config/wezterm/catppuccin-mocha.toml",
}

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte}
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.font = wezterm.font_with_fallback({
	family = "FiraCode Nerd Font",
	weight = "Thin",
	assume_emoji_presentation = true,
})

config.keys = {
	-- This will create a new split and run your default program inside it
	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "a",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Right" }),
	},
}

config.window_background_opacity = 0.45

config.text_background_opacity = 0.45

config.default_prog = { "zellij" }

config.webgpu_preferred_adapter = gpus[0]
config.enable_wayland = true
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
return config
