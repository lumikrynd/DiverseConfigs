require("helpers")

---Get workspace with name
---@param name string
---@return HL.Workspace | nil
local function get_workspace_by_name(name)
	local all = hl.get_workspaces()
	for _, ws in pairs(all) do
		if ws.name == name then
			return ws
		end
	end
end

---Swap workspace names
---@param a string
---@param b string
local function swap_name(a, b)
	local aw = get_workspace_by_name(a);
	local bw = get_workspace_by_name(b);

	Debug("Swap " .. a .. " with " .. b)

	if not aw then
		Debug("No: " .. a)
	end
	if not bw then
		Debug("No: " .. b)
	end

	if aw then hl.dispatch(hl.dsp.workspace.rename({ workspace = aw, name = b })) end
	if bw then hl.dispatch(hl.dsp.workspace.rename({ workspace = bw, name = a })) end
end

---Swap workspace ids
---@param a integer
---@param b integer
local function swap_id(a, b)
	hl.dispatch(hl.dsp.workspace.change_id({ workspace = b, id = 42 }))
	hl.dispatch(hl.dsp.workspace.change_id({ workspace = a, id = b }))
	hl.dispatch(hl.dsp.workspace.change_id({ workspace = 42, id = a }))
end

---Swap around workspace
---@param target integer
local function Custom_swap_workspace_logic(target)
	local current = hl.get_active_workspace()
	if not current then return end

	local current_special = SPECIAL .. current.name
	local target_special = SPECIAL .. target

	swap_id(current.id, target)
	swap_name(current.name, tostring(target))

	-- This does not currently work for some reason...
	swap_name(current_special, target_special)

	Custom_change_workspace_logic(target)
end

---Swap around workspace
---@param target integer
function Custom_swap_workspace(target)
	return function()
		Custom_swap_workspace_logic(target)
	end
end
