---------------
---- INPUT ----
---------------

--Keep first because I don't want to deal with US keyboard when I have errors...
hl.config({
	input = {
		kb_layout = "dk",
		kb_variant = "nodeadkeys",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		numlock_by_default = true,

		follow_mouse = 2,
		float_switch_override_focus = 0,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.config({
	cursor = {
		inactive_timeout = 5
	}
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})


-----------------
---- MONITOR ----
-----------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
