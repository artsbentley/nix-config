-- local b = require("utils/background")
-- local cs = require("utils/color_scheme")
local f = require("utils/font")
local h = require("utils/helpers")
local k = require("utils/keys")
-- local w = require("utils/wallpaper")

local wezterm = require("wezterm")
local act = wezterm.action

-- Detect if system is Linux or macOS
local is_linux = wezterm.target_triple == "x86_64-unknown-linux-gnu"
	or wezterm.target_triple == "aarch64-unknown-linux-gnu"
local is_macos = wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin"

local modifier_key = is_macos and "CMD" or "SUPER" -- Switch CMD for macOS and SUPER for Linux

local config = {
	-- background
	-- background = {
	-- 	w.get_wallpaper(),
	-- 	b.get_background(),
	-- },
	max_fps = 120,
	-- Spawn a fish shell in login mode
	-- default_prog = { "/usr/local/bin/fish", "-l" },
	-- default_prog = { "fish" },

	-- fix for nixos textures
	front_end = "WebGpu",
	enable_wayland = false,
	-- webgpu_power_preference = "HighPerformance",

	-- font
	font = f.get_font(),
	-- font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
	-- font = wezterm.font("Liga SFMono Nerd Font", { weight = "Medium" }),
	-- font = wezterm.font("JetBrains Mono"),

	font_size = is_linux and 9.0 or 14.5,
	-- font_size = 14.5,
	line_height = 1.35,

	-- colors
	-- color_scheme = cs.get_color_scheme(),
	-- color_scheme = "GruvboxDark",
	-- color_scheme = "Gruvbox Dark (Gogh)",
	color_scheme = "Gruvbox Material (Gogh)",
	force_reverse_video_cursor = true,
	-- color_scheme = "Gruvbox dark, medium (base16)",

	colors = {
		background = "#1d2021",
		-- foreground = "#d4be97",
	},

	-- padding
	window_padding = {
		left = 30,
		right = 30,
		top = 20,
		bottom = 10,
	},

	set_environment_variables = {
		-- THEME_FLAVOUR = "latte",
		-- BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
	},

	-- general options
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",

	-- keys
	keys = {
		-- forward and backward cursor
		k.cmd_key("i", act.SendKey({ mods = "CTRL", key = "o" })),
		k.cmd_key("I", act.SendKey({ mods = "CTRL", key = "i" })),

		-- tmux pane navigation
		k.ctrl_key("LeftArrow", act.SendKey({ mods = "CTRL", key = "h" })),
		k.ctrl_key("DownArrow", act.SendKey({ mods = "CTRL", key = "j" })),
		k.ctrl_key("UpArrow", act.SendKey({ mods = "CTRL", key = "k" })),
		k.ctrl_key("RightArrow", act.SendKey({ mods = "CTRL", key = "l" })),

		k.shift_key("LeftArrow", act.SendKey({ mods = "CTRL", key = "h" })),
		k.shift_key("DownArrow", act.SendKey({ mods = "CTRL", key = "j" })),
		k.shift_key("UpArrow", act.SendKey({ mods = "CTRL", key = "k" })),
		k.shift_key("RightArrow", act.SendKey({ mods = "CTRL", key = "l" })),

		-- tmux pane resizing
		k.shift_key("LeftArrow", act.SendKey({ mods = "CTRL", key = "h" })),
		k.shift_key("DownArrow", act.SendKey({ mods = "CTRL", key = "j" })),
		k.shift_key("UpArrow", act.SendKey({ mods = "CTRL", key = "k" })),
		k.shift_key("RightArrow", act.SendKey({ mods = "CTRL", key = "l" })),

		k.cmd_shift_key("LeftArrow", act.SendKey({ mods = "CTRL|META", key = "h" })),
		k.cmd_shift_key("DownArrow", act.SendKey({ mods = "CTRL|META", key = "j" })),
		k.cmd_shift_key("UpArrow", act.SendKey({ mods = "CTRL|META", key = "k" })),
		k.cmd_shift_key("RightArrow", act.SendKey({ mods = "CTRL|META", key = "l" })),

		-- custom commands
		k.cmd_key("f", k.multiple_actions(":Yazi")),
		k.cmd_key("P", k.multiple_actions(":GoToGit")),
		k.cmd_key("p", k.multiple_actions(":GoToFile")),
		k.cmd_key("q", k.multiple_actions(":qa!")),
		-- terminal fg with ctrl + z
		k.cmd_key("m", act.SendKey({ mods = "CTRL", key = "z" })),

		-- window navigation
		k.cmd_to_tmux_prefix("1", "1"),
		k.cmd_to_tmux_prefix("2", "2"),
		k.cmd_to_tmux_prefix("3", "3"),
		k.cmd_to_tmux_prefix("4", "4"),
		k.cmd_to_tmux_prefix("5", "5"),
		k.cmd_to_tmux_prefix("6", "6"),
		k.cmd_to_tmux_prefix("7", "7"),
		k.cmd_to_tmux_prefix("8", "8"),
		k.cmd_to_tmux_prefix("9", "9"),

		k.cmd_to_tmux_prefix("`", "n"),
		k.cmd_to_tmux_prefix("b", "B"),
		k.cmd_to_tmux_prefix("c", "c"), -- thumbs copy mode
		-- k.cmd_to_tmux_prefix("C", "C"), -- copy selection mode
		k.cmd_to_tmux_prefix("d", "d"),
		k.cmd_to_tmux_prefix("e", "%"),
		k.cmd_to_tmux_prefix("E", '"'),
		k.cmd_to_tmux_prefix("G", "G"), -- lazygit
		k.cmd_to_tmux_prefix("g", "g"), -- lazygit
		k.cmd_to_tmux_prefix("j", "T"),
		k.cmd_to_tmux_prefix("J", "J"),
		k.cmd_to_tmux_prefix("R", "R"),
		k.cmd_to_tmux_prefix("l", "L"), -- switch last session
		k.cmd_to_tmux_prefix("n", "l"), -- switch last window
		k.cmd_to_tmux_prefix("L", ";"), -- switch last pane
		k.cmd_to_tmux_prefix("y", "["), -- selecting mode

		k.cmd_to_tmux_prefix("o", "o"), -- sesh connect notes
		k.cmd_to_tmux_prefix("O", "F"),
		k.cmd_to_tmux_prefix("u", "u"), -- fzf url
		k.cmd_to_tmux_prefix("T", "!"),
		k.cmd_to_tmux_prefix("t", "c"),
		k.cmd_to_tmux_prefix("w", "x"),
		k.cmd_to_tmux_prefix("z", "z"),

		k.cmd_key(
			"R",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- escape
				k.multiple_actions(":source %"),
			})
		),

		k.cmd_key(
			"s",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- escape
				k.multiple_actions(":w"),
			})
		),

		{
			mods = modifier_key .. "|SHIFT",
			key = "}",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "b" }),
				act.SendKey({ key = "n" }),
			}),
		},
		{
			mods = modifier_key .. "|SHIFT",
			key = "{",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "b" }),
				act.SendKey({ key = "p" }),
			}),
		},

		{
			mods = "CTRL",
			key = "Tab",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "b" }),
				act.SendKey({ key = "n" }),
			}),
		},

		{
			mods = "CTRL|SHIFT",
			key = "Tab",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "b" }),
				act.SendKey({ key = "n" }),
			}),
		},

		{
			mods = modifier_key,
			key = "~",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "b" }),
				act.SendKey({ key = "p" }),
			}),
		},
	},
}

return config
