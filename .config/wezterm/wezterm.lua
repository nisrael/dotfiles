local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Detect platform
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_macos = wezterm.target_triple:find("darwin") ~= nil

-- Default shell configuration
if is_windows then
	-- Use PowerShell on Windows (change to "bash" for Git Bash)
	config.default_prog = { "pwsh.exe", "-NoLogo" }  -- or "powershell.exe" for Windows PowerShell
elseif is_macos then
    config.default_prog = { "/opt/homebrew/bin/tmux" }
else
    config.default_prog = { "tmux" }
end

-- Window settings
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = 'TITLE | RESIZE'
config.window_background_opacity = 1.0
config.window_close_confirmation = "NeverPrompt"
config.initial_cols = 120
config.initial_rows = 30

-- Auto-copy selection to clipboard
config.selection_word_boundary = " \t\n{}[]()\"'`,;:"

-- Theme - GitHub Dark style
config.color_scheme = "GitHub Dark"

-- Bell settings - visual flash instead of sound
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}
config.colors = {
	visual_bell = "#202020",
}

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold", stretch = "Normal", style = "Normal" })

if is_macos then
    config.font_size = 15.5
else
    config.font_size = 11  -- Smaller default font on Windows and Linux
end

-- Font fallback for Windows if JetBrains Mono is not installed
if is_windows then
	config.font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
		{ family = "JetBrainsMono NF", weight = "DemiBold" },
		{ family = "Cascadia Code", weight = "DemiBold" },
		{ family = "Consolas", weight = "Bold" },
	})
end

-- Tab bar
config.enable_tab_bar = true

-- Cursor
config.default_cursor_style = "BlinkingBar"

-- Keybindings
config.keys = {
	{
		key = "q",
		mods = "CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "'",
		mods = "CTRL",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
    {
        key="Enter",
        mods="SHIFT",
        action=wezterm.action{
            SendString = "\x1b\r"
        }
    },
}

-- Mouse bindings
config.mouse_bindings = {
	{
		-- Allow text selection with SHIFT + Left Mouse Drag (and auto-copy)
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'SHIFT',
		action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
	},
	{
		-- Ctrl+click to open links
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- Alt key behavior
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Windows-specific settings
if is_windows then
	-- Use Win32 input mode for better compatibility
	config.enable_kitty_keyboard = false

	-- Add Ctrl+V paste for Windows users
	table.insert(config.keys, {
		key = "v",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	})

	-- Add Ctrl+C copy for Windows users (only if text is selected)
	table.insert(config.keys, {
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(wezterm.action.CopyTo("Clipboard"), pane)
			else
				window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
			end
		end),
	})
end

-- Auto reload
config.automatically_reload_config = true

return config
