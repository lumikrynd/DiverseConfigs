---@diagnostic disable: unused-local
local scrolling = "scrolling"
local dwindle = "dwindle"
local master = "master"
local monocle = "monocle"
---@diagnostic enable: unused-local

local function get_workspace()
	return hl.get_active_special_workspace()
		or hl.get_active_workspace()
		or {}
end


--- Print debug with a notification
---@param message string
function Debug(message)
	os.execute("notify-send 'Test' '" .. message .. "'")
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
	require("sub-configs.".. name)
end


--- Used to recognize master windows
--- It assume the master window is both higher and wider than the given
--- number.
Master_size = 600

--- Toggle a window between master and servant state
function Master_toggle()
	local ws = get_workspace();

	if ws.tiled_layout ~= master then
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
	if workspace.tiled_layout == scrolling then
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

	cycle_from_to(master, scrolling)
	cycle_from_to(scrolling, monocle)
	cycle_from_to(monocle, master)
end


---@param direction string
local function monocle_dir_fix(direction)
	if direction == "right" then
		hl.dispatch(hl.dsp.layout("cyclenext"))
	elseif direction == "left" then
		hl.dispatch(hl.dsp.layout("cycleprev"))
	end
end

--- Focus function which also works for the monocle layout
---@param direction string
local function custom_focus_logic(direction)
	local layout = get_workspace().tiled_layout;
	if layout == monocle then
		monocle_dir_fix(direction)
		return
	end

	hl.dispatch(hl.dsp.focus({ direction = direction }))
end

--- Focus function which also works for the monocle layout
---@param direction string
function Custom_focus(direction)
	return function()
		custom_focus_logic(direction)
	end
end
