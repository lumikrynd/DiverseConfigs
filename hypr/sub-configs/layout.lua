----------------
---- LAYOUT ----
----------------

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		mfact = 0.80,
		orientation = "top",
		allow_small_split = true,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		direction = "right",
		column_width = 0.95,
		focus_fit_method = 1,
		fullscreen_on_one_column = true,
	},
})

hl.config({
	general = {
		layout = "master",
	},
})

hl.workspace_rule({ workspace = 1, layout = "scrolling" })
