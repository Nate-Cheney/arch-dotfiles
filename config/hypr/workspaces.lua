-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", function() hl.dispatch("movefocus", "l") end)
hl.bind(mainMod .. " + right", function() hl.dispatch("movefocus", "r") end)
hl.bind(mainMod .. " + up", function() hl.dispatch("movefocus", "u") end)
hl.bind(mainMod .. " + down", function() hl.dispatch("movefocus", "d") end)

-- Resize active window
hl.bind(mainMod .. " + bracketleft", function() hl.dispatch("resizeactive", "-100 0") end, { description = "Expand window left" })
hl.bind(mainMod .. " + bracketright", function() hl.dispatch("resizeactive", "100 0") end, { description = "Shrink window left" })
hl.bind(mainMod .. " + SHIFT + bracketleft", function() hl.dispatch("resizeactive", "0 -100") end, { description = "Shrink window up" })
hl.bind(mainMod .. " + SHIFT + bracketright", function() hl.dispatch("resizeactive", "0 100") end, { description = "Expand window down" })

-- Dynamically generate binds for workspaces 1-10
for i = 1, 10 do
    local key = tostring(i % 10) 
    
    -- Switch workspace
    hl.bind(mainMod .. " + " .. key, function() hl.dispatch("workspace", tostring(i)) end)
    -- Move window to workspace
    hl.bind(mainMod .. " + SHIFT + " .. key, function() hl.dispatch("movetoworkspace", tostring(i)) end)
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag, { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize, { mouse = true })

-- Define workspaces
hl.workspace_rule({ workspace = "1", monitor = monitor1, default = true })
hl.workspace_rule({ workspace = "2", monitor = monitor2, default = true })

hl.workspace_rule({ workspace = "3", monitor = monitor1 })
hl.workspace_rule({ workspace = "4", monitor = monitor2 })

hl.workspace_rule({ workspace = "5", monitor = monitor1 })
hl.workspace_rule({ workspace = "6", monitor = monitor2 })

hl.workspace_rule({ workspace = "7", monitor = monitor1 })
hl.workspace_rule({ workspace = "8", monitor = monitor2 })

hl.workspace_rule({ workspace = "9", monitor = monitor1 })
hl.workspace_rule({ workspace = "10", monitor = monitor2 })

