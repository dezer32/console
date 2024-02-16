------------
-- Spoons --
------------

local VimMode = hs.loadSpoon("VimMode")
local vim = VimMode:new()

vim:enterWithSequence("jk")

local vimouse = require("plugins.vimouse")
vimouse("cmd", "m")

hs.window.animationDuration = 0
hs.window.setShadows(false)

-----------------------
-- Confing reloading --
-----------------------

function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

---------------------------
-- Application managment --
---------------------------

function bindAppWithNameToKey(name, key)
  hs.hotkey.bind({ "cmd", "ctrl" }, key, function()
    hs.application.open(name)
  end)
end

hs.application.enableSpotlightForNameSearches(true)

bindAppWithNameToKey("Standard Notes", "N")
bindAppWithNameToKey("Dash", "H")
bindAppWithNameToKey("KeePassXC", "K")
bindAppWithNameToKey("Telegram", "G")
