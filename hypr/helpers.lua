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
	if hl.get_active_workspace().tiled_layout ~= "master" then
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
	local workspace = hl.get_active_workspace()
	if not workspace then
		return
	end

	Master_toggle()
	if workspace.tiled_layout == "scrolling" then
		hl.dispatch(hl.dsp.layout("colresize +conf"))
	end
end
