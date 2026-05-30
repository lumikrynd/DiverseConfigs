-- Refer to the wiki for more information.
-- https://wiki.hyprland.org/Configuring/

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

require("sub-configs.input_output") -- Set up first because US-keyboard on error is annoying
require("helpers")


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

local home = os.getenv( "HOME" )
local config = os.getenv("XDG_CONFIG_HOME") or home .. "/.config"
Sub_configs = config .. "/hypr/sub-configs";

Bar = "waybar"
Terminal = "kitty"
Menu = "rofi -show drun"
Emoji = "rofi -mode emoji -show emoji -emoji-mode copy -emoji-file "
	.. config
	.. "/rofi/all-emojis.txt"

Browser = "firefox"
Lock = "hyprlock"

Grim_dir = home .. "/Pictures/screenshots"
hl.env("GRIM_DEFAULT_DIR", Grim_dir)

hl.on("hyprland.start", function()
	hl.exec_cmd("mkdir -p " .. Grim_dir)
end)

ColorPicker = "slurp -b 00000000 -p | grim -g - -"
	.. " | magick - txt:- | tail -n 1 | cut -d ' ' -f 4 | wl-copy"
Snipping = "slurp | grim -g - - | wl-copy"
Screenshot = "grim"

hl.env("DMENU", "rofi -dmenu")

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

Run_local_config("environment")

require("sub-configs.local") -- TODO: delete after done porting all


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
	hl.exec_cmd(Bar)
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("udiskie")
	-- Could also start discord
end)


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
----- SUB-CONFIGS -----
-----------------------

require("sub-configs.looks")
require("sub-configs.layout")


----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background.
	},
})


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(Terminal))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(Menu))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd(Emoji))

hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(ColorPicker))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(Snipping))
hl.bind("Print", hl.dsp.exec_cmd(Screenshot))

hl.bind(mainMod .. " + SHIFT + return", hl.dsp.exec_cmd(Browser))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(Sub_configs .. "/restart-waybar.bash"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(config .. "/scripts/system_menu"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M", Size_toggle)
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(Lock))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(config .. "/scripts/audio_output_switch"))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ monitor = "+1"}))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ monitor = "-1"}))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.swap({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0

	hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd(Sub_configs .. "/change-workspace " .. i))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i}))
end

hl.bind(mainMod .. " + 1", hl.dsp.exec_cmd(". ~/.config/hypr/sub-configs/change-workspace 1"))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic"}))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1"}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1"}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86ScreenSaver",hl.dsp.dpms({ action = "toggle"}), { locked = true })

-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
	name = "steam subwindow float",
	match = {
		class = "^(steam)$",
		title = "negative:^(Steam)$",
	},
	float = true,
})

hl.window_rule({
	name = "qbittorrent subwindow float",
	match = {
		class = "^(org\\.qbittorrent\\.qBittorrent)$",
		title = "negative:qBittorrent.*",
	},
	float = true,
})

hl.window_rule({
	name = "duckstation subwindow float",
	match = {
		class = "^(org\\.duckstation\\.DuckStation)$",
		title = "negative:^(DuckStation.*)",
	},
	float = true,
})

-- Ignore maximize requests from all apps. You'll probably like this.
local suppressMaximizeRule = hl.window_rule({
	name  = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name  = "fix-xwayland-drags",
	match = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},

	no_focus = true,
})

Run_local_config("config")
