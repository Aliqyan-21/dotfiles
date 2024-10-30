local wezterm = require("wezterm")

return {
	font = wezterm.font("JetBrainsMonoNL NF Light"),
	font_size = 15.0,

	window_background_opacity = 0.75,

	line_height = 1.0,
	cell_width = 1.0,
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "NONE",
	enable_scroll_bar = false,

	window_close_confirmation = "NeverPrompt",

	colors = {
		foreground = "#c0c0c0",
		background = "#040709",
		cursor_bg = "#c1c1c1",
		cursor_fg = "#090a04",
		cursor_border = "#bdfe58",
		selection_fg = "#c0c0c0",
		selection_bg = "#303030",
		scrollbar_thumb = "#404040",

		-- Map of ANSI color codes to theme colors
		ansi = {
			"#1c1c1c",
			"#ff3131",
			"#66b2b2",
			"#d1d1d1",
			"#4b8902",
			"#b16286",
			"#1bfd9c",
			"#c0c0c0",
		},

		brights = {
			"#585858",
			"#fb4934",
			"#b8bb26",
			"#9efd84",
			"#83a598",
			"#d3869b",
			"#8ec07c",
			"#ebdbb2",
		},

		-- Additional elements you might want to color
		visual_bell = "#404040",
		tab_bar = {
			background = "#1c1c1c",
			active_tab = {
				bg_color = "#303030", -- visual selection color
				fg_color = "#c0c0c0",
			},
			inactive_tab = {
				bg_color = "#1c1c1c",
				fg_color = "#585858",
			},
			inactive_tab_hover = {
				bg_color = "#303030",
				fg_color = "#c0c0c0",
			},
		},
	},

	front_end = "OpenGL",
	max_fps = 60,
	freetype_load_flags = "NO_HINTING",
	adjust_window_size_when_changing_font_size = false,
	scrollback_lines = 1000,

	keys = {
		{ key = "Insert", mods = "SHIFT", action = wezterm.action.DisableDefaultAssignment },
		{ key = "Insert", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
		{ key = '"', mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
		{ key = "%", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
		{ key = "t", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	},

	cursor_blink_rate = 1200,
	default_cursor_style = "SteadyBlock",
	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},
}
