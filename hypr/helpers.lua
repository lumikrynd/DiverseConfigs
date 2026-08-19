local LAYOUT = {
	scrolling = "scrolling",
	dwindle = "dwindle",
	master = "master",
	monocle = "monocle",
}

local DIRECTION = {
	left = "left",
	right = "right",
}

local SPECIAL = "special:"


local function get_workspace()
	return hl.get_active_special_workspace()
		or hl.get_active_workspace()
		or {}
end


--- Print debug with a notification
---@param message string
function Debug(message)
	hl.notification.create({ text = message, timeout = 3000 })
end

--- Register local config file.
--- Creates the file if it doesn't exist to avoid errors.
---@param name string
function Run_local_config(name)
	local name = name .. '_local';

	--feels like a hack I always call touch.. oh well.
	-- hl.exec_cmd doesn't wait for completion, so using os.execute instead... for now
	-- hl.exec_cmd("touch -a '" .. Sub_configs .. "/" .. name .. ".lua'")
	os.execute("touch -a '" .. Sub_configs .. "/" .. name .. ".lua'");
	require("sub-configs." .. name)
end

--- Used to recognize master windows
--- It assume the master window is both higher and wider than the given
--- number.
Master_size = 600

--- Toggle a window between master and servant state
function Master_toggle()
	local ws = get_workspace();

	if ws.tiled_layout ~= LAYOUT.master then
		return
	end

	local size = hl.get_active_window().size
	local is_master = size['x'] > Master_size and size['y'] > Master_size

	-- local debug_message = "x: " .. tostring(size['x'])
	-- 	.. ", y: " .. tostring(size['y'])
	-- 	.. ", is_master: " .. tostring(is_master);
	-- Debug(debug_message)

	if is_master then
		hl.dispatch(hl.dsp.layout("removemaster"))
	else
		hl.dispatch(hl.dsp.layout("addmaster"))
	end
end

-- Toggle the size of the window
-- This is achieved differently depending on the layout
function Size_toggle()
	local workspace = get_workspace()

	Master_toggle()
	if workspace.tiled_layout == LAYOUT.scrolling then
		hl.dispatch(hl.dsp.layout("colresize +conf"))
	end
end

function Toggle_Layout()
	local workspace = get_workspace()
	local current = workspace.tiled_layout;

	local function cycle_from_to(from, to)
		if current == from then
			hl.workspace_rule({ workspace = workspace.name, layout = to })
		end
	end

	cycle_from_to(LAYOUT.master, LAYOUT.scrolling)
	cycle_from_to(LAYOUT.scrolling, LAYOUT.monocle)
	cycle_from_to(LAYOUT.monocle, LAYOUT.master)
end

---@param direction string
local function monocle_focus(direction)
	if direction == DIRECTION.right then
		hl.dispatch(hl.dsp.layout("cyclenext"))
	elseif direction == DIRECTION.left then
		hl.dispatch(hl.dsp.layout("cycleprev"))
	end
end


--- Test predicate returns true for the x-value of all windows
--- on the current workspace, against the x-value of the active
--- window
---@param predicate fun(active_x: integer, other_x: integer): boolean
---@return boolean
local function active_window_x_all(predicate)
	local window = hl.get_active_window()
	if window == nil then return true end

	local others = hl.get_windows({ workspace = window.workspace })

	local final = true
	for _, value in pairs(others) do
		final = final and predicate(window.at.x, value.at.x)
	end

	return final
end


local function focus_restricted_right()
	if active_window_x_all(function(a, b) return a >= b end) then
		return
	end

	hl.dispatch(hl.dsp.focus({ direction = DIRECTION.right }))
end


local function focus_restricted_left()
	if active_window_x_all(function(a, b) return a <= b end) then
		return
	end

	hl.dispatch(hl.dsp.focus({ direction = DIRECTION.left }))
end


--- Focus function which wont go to another screen
---@param direction string
local function focus_restricted_to_monitor(direction)
	if direction == DIRECTION.right then
		focus_restricted_right()
	elseif direction == DIRECTION.left then
		focus_restricted_left()
	else
		-- Assuming that I don't have monitors above/bellow each other
		hl.dispatch(hl.dsp.focus({ direction = direction }))
	end
end


--- Focus function which also works for the monocle layout
---@param direction string
local function layout_specific_focus(direction)
	local layout = get_workspace().tiled_layout;
	if layout == LAYOUT.monocle then
		monocle_focus(direction)
		return
	end

	focus_restricted_to_monitor(direction)
end


--- Focus function which also works for the monocle layout
---@param direction string
function Custom_focus(direction)
	return function()
		layout_specific_focus(direction)
	end
end

local function scrolling_swap(direction)
	local arg = string.sub(direction, 1, 1)
	hl.dispatch(hl.dsp.layout("swapcol " .. arg))
end


--- Swap function which swap column instead of windows for scrolling layout
---@param direction string
local function custom_swap_logic(direction)
	local layout = get_workspace().tiled_layout;
	if layout == LAYOUT.scrolling then
		scrolling_swap(direction)
		return
	end

	hl.dispatch(hl.dsp.window.swap({ direction = direction }))
end


--- Swap function which swap column instead of windows for scrolling layout
---@param direction string
function Custom_swap(direction)
	return function()
		custom_swap_logic(direction)
	end
end

---Get name needed for workspace specific special workspace
---@return string | nil
local function get_current_name()
	local workspace = hl.get_active_workspace()
	if workspace then
		return workspace.name
	end

	return nil
end

function Custom_special_workspace()
	local name = get_current_name();
	hl.dispatch(hl.dsp.workspace.toggle_special(name))
end

function Custom_move_special_workspace()
	local name = get_current_name();
	hl.dispatch(hl.dsp.window.move({ workspace = SPECIAL .. name }))
end

---@param ws integer | string The workspace
local function Custom_change_workspace_logic(ws)
	hl.dispatch(hl.dsp.focus({ workspace = ws }));
	hl.dispatch(hl.dsp.workspace.toggle_special("minimize"));
	hl.dispatch(hl.dsp.workspace.toggle_special("minimize"));
end

---@param ws integer | string The workspace
function Custom_change_workspace(ws)
	return function()
		Custom_change_workspace_logic(ws)
	end
end
