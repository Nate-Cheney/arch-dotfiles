-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Resize active window
hl.bind(mainMod .. " + bracketleft", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { description = "Shrink window left" })
hl.bind(mainMod .. " + bracketright", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { description = "Expand window left" })
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { description = "Shrink window up" })
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { description = "Expand window down" })

-- Dynamically generate binds for workspaces 1-10
for i = 1, 10 do
    local key = tostring(i % 10) 
    
    -- Switch workspace
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    
    -- Move window to workspace
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

