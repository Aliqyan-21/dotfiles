local wezterm = require("wezterm")

return {
	-- font = wezterm.font("JetBrainsMonoNL NF Light"),
	font = wezterm.font("Iosevka Term light"),
	font_size = 16.0,

	-- window_background_opacity = 0.75,

	line_height = 1.0,
	cell_width = 1.0,
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "NONE",
	enable_scroll_bar = false,

	window_close_confirmation = "NeverPrompt",

	colors = {
		-- darkvoid color scheme base
		foreground = "#c0c0c0",
		-- background = "#040709",
		background = "#1c1c1c",

		cursor_bg = "#c1c1c1",
		cursor_fg = "#090a04",
		cursor_border = "#7fbfff",
		selection_fg = "#c0c0c0",
		selection_bg = "#303030",
		scrollbar_thumb = "#404040",

		ansi = {
			"#1c1c1c",
			"#e62020",
			"#66b2b2",
			"#d1d1d1",
			"#b1b1b1",
			"#b16286",
			"#1bfd9c",
			"#c0c0c0",
		},

		brights = {
			"#404040",
			"#b2beb5",
			"#b8bb26",
			"#bdfe58",
			"#6a7a8a",
			"#d3869b",
			"#b2d8d8",
			"#ebdbb2",
		},

		visual_bell = "#7fbfff",
		tab_bar = {
			background = "#1c1c1c",
			active_tab = {
				bg_color = "#303030",
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
