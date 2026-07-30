-- Workspace Group Switcher.sh location
local path_to_script = "~/.config/Real1F2L/Workspace Group Switcher.sh"

-- Monitors (CHANGE ME)
local monitors = {
    "DP-1",
    "DP-2"
}

-- Do not change anything below this line unless you know what
-- you're doing!

-- Switch workspace binds
hl.bind("SUPER + 1", hl.dsp.exec_cmd(path_to_script .. " 1"))
hl.bind("SUPER + 2", hl.dsp.exec_cmd(path_to_script .. " 2"))
hl.bind("SUPER + 3", hl.dsp.exec_cmd(path_to_script .. " 3"))
hl.bind("SUPER + 4", hl.dsp.exec_cmd(path_to_script .. " 4"))
hl.bind("SUPER + 5", hl.dsp.exec_cmd(path_to_script .. " 5"))
hl.bind("SUPER + 6", hl.dsp.exec_cmd(path_to_script .. " 6"))
hl.bind("SUPER + 7", hl.dsp.exec_cmd(path_to_script .. " 7"))
hl.bind("SUPER + 8", hl.dsp.exec_cmd(path_to_script .. " 8"))
hl.bind("SUPER + 9", hl.dsp.exec_cmd(path_to_script .. " 9"))


-- Apply workspace rules
local workspaces_per_monitor = 9
-- Loop over all monitors
for monitor_index, monitor in ipairs(monitors) do
    -- Loop over workspaces count
    for slot = 0, workspaces_per_monitor - 1 do
        -- Get this workspace
        local workspace = monitor_index + (slot * #monitors)
        
        -- Assign a rule that locks this workspace to this monitor
        hl.workspace_rule({
            workspace = tostring(workspace),
            monitor = monitor,
            persistent = true,
        })
    end
end