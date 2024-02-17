local hyper = { "cmd", "shift", "ctrl" }

------------
-- Spoons --
------------

hs.loadSppon("Caffeine")
hs.hotkey.bind(hyper, "C", function ()
  spoon.Caffeine:
end)

------------
------------
------------

local vimouse = require("plugins.vimouse")
vimouse("cmd", "M")

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

-- myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
-- hs.alert.show("Config loaded")

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

--------------------------------------------------------------------------------
-- Window management

function almostEqualFrames(first, second)
	local delta = 25.0

	return math.abs(first.x - second.x) < delta
		and math.abs(first.y - second.y) < delta
		and math.abs(first.w - second.w) < delta
		and math.abs(first.h - second.h) < delta
end

-- Return screen frame available for window placement
function currentScreenFrame()
	return hs.screen.mainScreen():frame()
end

function windowLeft()
	local frame = currentScreenFrame()
	frame.w = frame.w / 2
	return frame
end

function windowRight()
	local frame = currentScreenFrame()
	frame.x = frame.x + frame.w / 2
	frame.w = frame.w / 2
	return frame
end

function windowTop()
	local frame = currentScreenFrame()
	frame.h = frame.h / 2
	return frame
end

function windowBottom()
	local frame = currentScreenFrame()
	frame.y = frame.y + frame.h / 2
	frame.h = frame.h / 2
	return frame
end

hs.hotkey.bind(hyper, "F", function()
	hs.window.focusedWindow():setFrame(currentScreenFrame())
end)

function getFocusBackToWindow(window)
	local other = window:otherWindowsAllScreens()

	for i, win in pairs(other) do
		if win:screen() ~= window:screen() then
			win:focus()
			window:focus()
			break
		end
	end
end

hs.hotkey.bind(hyper, "H", function()
	local window = hs.window.focusedWindow()
	local windowFrame = window:frame()
	local frame = windowLeft()

	if almostEqualFrames(windowFrame, frame) then
		local screen = hs.screen.mainScreen():toWest()

		if screen then
			window:moveToScreen(screen)
			getFocusBackToWindow(window)
			return
		end
	elseif almostEqualFrames(windowFrame, windowTop()) then
		frame.h = windowTop().h
	elseif almostEqualFrames(windowFrame, windowBottom()) then
		frame.y = windowBottom().y
		frame.h = windowBottom().h
	end

	hs.window.focusedWindow():setFrame(frame)
end)

hs.hotkey.bind(hyper, "L", function()
	local window = hs.window.focusedWindow()
	local windowFrame = window:frame()
	local frame = windowRight()

	if almostEqualFrames(windowFrame, frame) then
		local screen = hs.screen.mainScreen():toEast()

		if screen then
			window:moveToScreen(screen)
			getFocusBackToWindow(window)
			return
		end
	elseif almostEqualFrames(windowFrame, windowTop()) then
		frame.h = windowTop().h
	elseif almostEqualFrames(windowFrame, windowBottom()) then
		frame.y = windowBottom().y
		frame.h = windowBottom().h
	end

	hs.window.focusedWindow():setFrame(frame)
end)

hs.hotkey.bind(hyper, "J", function()
	local windowFrame = hs.window.focusedWindow():frame()
	local frame = windowBottom()

	if almostEqualFrames(windowFrame, windowLeft()) then
		frame.w = windowLeft().w
	elseif almostEqualFrames(windowFrame, windowRight()) then
		frame.x = windowRight().x
		frame.w = windowRight().w
	end

	hs.window.focusedWindow():setFrame(frame)
end)

hs.hotkey.bind(hyper, "K", function()
	local windowFrame = hs.window.focusedWindow():frame()
	local frame = windowTop()

	if almostEqualFrames(windowFrame, windowLeft()) then
		frame.w = windowLeft().w
	elseif almostEqualFrames(windowFrame, windowRight()) then
		frame.x = windowRight().x
		frame.w = windowRight().w
	end

	hs.window.focusedWindow():setFrame(frame)
end)
