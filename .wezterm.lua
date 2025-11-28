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
    -- Use zsh natively (no tmux for local work)
    config.default_prog = { "/bin/zsh", "-l" }
else
    config.default_prog = { "/bin/bash", "-l" }
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

-- Theme
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'carbonfox'
  else
    return 'dayfox'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

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
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })

if is_macos then
    config.font_size = 15
else
    config.font_size = 11  -- Smaller default font on Windows and Linux
end

-- Font fallback for Windows if JetBrains Mono is not installed
if is_windows then
	config.font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
		{ family = "JetBrainsMono NF", weight = "Regular" },
		{ family = "Cascadia Code", weight = "Regular" },
		{ family = "Consolas", weight = "Regular" },
	})
end

-- Tab bar
config.enable_tab_bar = false

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

    -- Splits (einfach für deutsche Tastatur)
    {
        key = "d",
        mods = "CMD",  -- Cmd + d
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
        key = "D",
        mods = "CMD|SHIFT",  -- Cmd + Shift + d
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },

    -- Pane Navigation (vim-style mit Cmd)
    {
        key = "h",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        key = "j",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
        key = "k",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        key = "l",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },

    -- Pane schließen
    {
        key = "w",
        mods = "CMD",
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },

    -- Tabs
    {
        key = "t",
        mods = "CMD",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "1",
        mods = "CMD",
        action = wezterm.action.ActivateTab(0),
    },
    {
        key = "2",
        mods = "CMD",
        action = wezterm.action.ActivateTab(1),
    },
    {
        key = "3",
        mods = "CMD",
        action = wezterm.action.ActivateTab(2),
    },
    {
        key = "4",
        mods = "CMD",
        action = wezterm.action.ActivateTab(3),
    },
    {
        key = "5",
        mods = "CMD",
        action = wezterm.action.ActivateTab(4),
    },
    {
        key = "6",
        mods = "CMD",
        action = wezterm.action.ActivateTab(5),
    },
    {
        key = "7",
        mods = "CMD",
        action = wezterm.action.ActivateTab(6),
    },
    {
        key = "8",
        mods = "CMD",
        action = wezterm.action.ActivateTab(7),
    },
    {
        key = "9",
        mods = "CMD",
        action = wezterm.action.ActivateTab(8),
    },
}

-- Mouse bindings
config.mouse_bindings = {
	{
		-- Normal text selection with left click (auto-copy to clipboard when released)
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'NONE',
		action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection',
	},
	{
		-- Right click to paste
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		-- Shift + Right click to paste (useful when vim captures the mouse)
		event = { Down = { streak = 1, button = "Right" } },
		mods = "SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
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
