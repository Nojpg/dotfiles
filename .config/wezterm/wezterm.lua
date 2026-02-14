local wezterm = require'wezterm'
local act = wezterm.action --- Wezterm Action and Keybinding
local mux = wezterm.mux    --- Wezterm Multiplexer
local font = wezterm.font  --- Wezterm Font Manager

local config = wezterm.config_builder()

config.color_scheme = 'tokyonight_storm'

return config
