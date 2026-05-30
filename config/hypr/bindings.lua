-- Main keybinds
hl.bind(mainMod .. " + B", function() hl.exec_cmd("uwsm-app -- " .. browser) end)
hl.bind(mainMod .. " + E", function() hl.exec_cmd("uwsm-app -- " .. fileManager) end)
hl.bind(mainMod .. " + P", function() hl.exec_cmd("uwsm-app -- " .. passwordManager) end)
hl.bind(mainMod .. " + T", function() hl.exec_cmd("uwsm-app -- " .. terminal) end)
hl.bind(mainMod .. " + V", function() hl.exec_cmd("uwsm-app -- " .. clipboardManager) end)
hl.bind(mainMod .. " + Space", function() hl.exec_cmd("uwsm-app -- " .. runMenu) end)

-- Launching direct commands
hl.bind(mainMod .. " + L", function() hl.exec_cmd("uwsm-app -- hyprlock") end)
hl.bind(mainMod .. " + M", function() hl.exec_cmd("uwsm-app -- spotify-launcher") end)
hl.bind(mainMod .. " + O", function() hl.exec_cmd("uwsm-app -- obsidian") end)
hl.bind(mainMod .. " + ESCAPE", function() hl.exec_cmd("uwsm-app -- system-menu.sh") end)
hl.bind(mainMod .. " + SHIFT + S", function() hl.exec_cmd("uwsm-app -- hyprshot -m region --clipboard-only") end)

-- Window management dispatchers
hl.bind(mainMod .. " + F", function() hl.dispatch("fullscreen") end)
hl.bind(mainMod .. " + J", function() hl.dispatch("togglesplit") end)
hl.bind(mainMod .. " + W", function() hl.dispatch("killactive") end)
hl.bind(mainMod .. " + SHIFT + L", function() hl.dispatch("exit") end)
hl.bind(mainMod .. " + SHIFT + V", function() hl.dispatch("togglefloating") end)

-- Laptop multimedia keys for volume and brightness
hl.bind("XF86AudioRaiseVolume", function() hl.exec_cmd("uwsm-app -- wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") end, { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", function() hl.exec_cmd("uwsm-app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end, { repeating = true, locked = true })
hl.bind("XF86AudioMute", function() hl.exec_cmd("uwsm-app -- wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end, { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", function() hl.exec_cmd("uwsm-app -- wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") end, { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", function() hl.exec_cmd("uwsm-app -- brightnessctl -e4 -n2 set 5%+") end, { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", function() hl.exec_cmd("uwsm-app -- brightnessctl -e4 -n2 set 5%-") end, { repeating = true, locked = true })

-- Multimedia keybinds (requires playerctl)
hl.bind("XF86AudioNext", function() hl.exec_cmd("uwsm-app -- playerctl next") end, { locked = true })
hl.bind("XF86AudioPause", function() hl.exec_cmd("uwsm-app -- playerctl play-pause") end, { locked = true })
hl.bind("XF86AudioPlay", function() hl.exec_cmd("uwsm-app -- playerctl play-pause") end, { locked = true })
hl.bind("XF86AudioPrev", function() hl.exec_cmd("uwsm-app -- playerctl previous") end, { locked = true })

