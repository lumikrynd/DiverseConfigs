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
