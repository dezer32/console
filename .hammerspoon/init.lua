local hyper = { "alt", "shift", "ctrl", "cmd" } 
local cc = { "cmd", "ctrl" }
local co = { "shift", "alt" }

------------
-- Spoons --
------------

------------
------------
------------

local vimouse = require("plugins.vimouse")
vimouse(cc, "M")

hs.window.animationDuration = 0
hs.window.setShadows(false)

require("plugins.caffeine")
hs.hotkey.bind(co, "C", function()
	toggleCaffeine()
end)

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
	hs.hotkey.bind(co, key, function()
		hs.application.open(name)
	end)
end

hs.application.enableSpotlightForNameSearches(true)

bindAppWithNameToKey("Standard Notes", "N")
bindAppWithNameToKey("Dash", "H")
bindAppWithNameToKey("KeePassXC", "K")
bindAppWithNameToKey("GoLand", "G")
bindAppWithNameToKey("Firefox", "B")
bindAppWithNameToKey("Telegram", "M")
bindAppWithNameToKey("Obsidian", "O")
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

-- function getFocusBackToWindow(window)
-- 	local other = window:otherWindowsAllScreens()
--
-- 	for i, win in pairs(other) do
-- 		if win:screen() ~= window:screen() then
-- 			win:focus()
-- 			window:focus()
-- 			break
-- 		end
-- 	end
-- end
--
-- hs.hotkey.bind(hyper, "H", function()
-- 	local window = hs.window.focusedWindow()
-- 	local windowFrame = window:frame()
-- 	local frame = windowLeft()
--
-- 	if almostEqualFrames(windowFrame, frame) then
-- 		local screen = hs.screen.mainScreen():toWest()
--
-- 		if screen then
-- 			window:moveToScreen(screen)
-- 			getFocusBackToWindow(window)
-- 			return
-- 		end
-- 	elseif almostEqualFrames(windowFrame, windowTop()) then
-- 		frame.h = windowTop().h
-- 	elseif almostEqualFrames(windowFrame, windowBottom()) then
-- 		frame.y = windowBottom().y
-- 		frame.h = windowBottom().h
-- 	end
--
-- 	hs.window.focusedWindow():setFrame(frame)
-- end)
--
-- hs.hotkey.bind(hyper, "L", function()
-- 	local window = hs.window.focusedWindow()
-- 	local windowFrame = window:frame()
-- 	local frame = windowRight()
--
-- 	if almostEqualFrames(windowFrame, frame) then
-- 		local screen = hs.screen.mainScreen():toEast()
--
-- 		if screen then
-- 			window:moveToScreen(screen)
-- 			getFocusBackToWindow(window)
-- 			return
-- 		end
-- 	elseif almostEqualFrames(windowFrame, windowTop()) then
-- 		frame.h = windowTop().h
-- 	elseif almostEqualFrames(windowFrame, windowBottom()) then
-- 		frame.y = windowBottom().y
-- 		frame.h = windowBottom().h
-- 	end
--
-- 	hs.window.focusedWindow():setFrame(frame)
-- end)
--
-- hs.hotkey.bind(hyper, "J", function()
-- 	local windowFrame = hs.window.focusedWindow():frame()
-- 	local frame = windowBottom()
--
-- 	if almostEqualFrames(windowFrame, windowLeft()) then
-- 		frame.w = windowLeft().w
-- 	elseif almostEqualFrames(windowFrame, windowRight()) then
-- 		frame.x = windowRight().x
-- 		frame.w = windowRight().w
-- 	end
--
-- 	hs.window.focusedWindow():setFrame(frame)
-- end)
--
-- hs.hotkey.bind(hyper, "K", function()
-- 	local windowFrame = hs.window.focusedWindow():frame()
-- 	local frame = windowTop()
--
-- 	if almostEqualFrames(windowFrame, windowLeft()) then
-- 		frame.w = windowLeft().w
-- 	elseif almostEqualFrames(windowFrame, windowRight()) then
-- 		frame.x = windowRight().x
-- 		frame.w = windowRight().w
-- 	end
--
-- 	hs.window.focusedWindow():setFrame(frame)
-- end)

----------------------
-- Screen managment --
----------------------

-- bind hotkey
hs.hotkey.bind(hyper, "n", function()
	-- get the focused window
	local win = hs.window.focusedWindow()
	-- get the screen where the focused window is displayed, a.k.a. current screen
	local screen = win:screen()
	-- compute the unitRect of the focused window relative to the current screen
	-- and move the window to the next screen setting the same unitRect
	win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)


function screenInDirection(dir)
    local current = hs.mouse.getCurrentScreen()
    local currentFrame = current:frame()

    local bestScreen = nil
    local bestScore = nil

    for _, screen in ipairs(hs.screen.allScreens()) do
        if screen ~= current then
            local frame = screen:frame()
            local dx = frame.x - currentFrame.x
            local dy = frame.y - currentFrame.y

            local score = nil

            if dir == "left" and dx < 0 and math.abs(dy) < currentFrame.h then
                score = math.abs(dx)
            elseif dir == "right" and dx > 0 and math.abs(dy) < currentFrame.h then
                score = dx
            elseif dir == "up" and dy < 0 and math.abs(dx) < currentFrame.w then
                score = math.abs(dy)
            elseif dir == "down" and dy > 0 and math.abs(dx) < currentFrame.w then
                score = dy
            end

            if score and (not bestScore or score < bestScore) then
                bestScreen = screen
                bestScore = score
            end
        end
    end

    return bestScreen
end

function pointInRect(point, rect)
    return point.x >= rect.x
       and point.x <= rect.x + rect.w
       and point.y >= rect.y
       and point.y <= rect.y + rect.h
end

function focusWindowUnderMouse()
    local mousePos = hs.mouse.absolutePosition()
    local windows = hs.window.orderedWindows()

    for _, win in ipairs(windows) do
        if win:isStandard() and win:isVisible() then
            local frame = win:frame()
            if pointInRect(mousePos, frame) then
                win:focus()
                return
            end
        end
    end
end

function moveMouseToScreen(screen)
    if not screen then return end

    local f = screen:frame()
    hs.mouse.setAbsolutePosition({
        x = f.x + f.w / 2,
        y = f.y + f.h / 2
    })

        focusWindowUnderMouse()
end

-- Горячие клавиши для направления
hs.hotkey.bind(hyper, "H", function()
    local nextScreen = screenInDirection("left")
    moveMouseToScreen(nextScreen)
end)

hs.hotkey.bind(hyper, "L", function()
    local nextScreen = screenInDirection("right")
    moveMouseToScreen(nextScreen)
end)

hs.hotkey.bind(hyper, "K", function()
    local nextScreen = screenInDirection("up")
    moveMouseToScreen(nextScreen)
end)

hs.hotkey.bind(hyper, "J", function()
    local nextScreen = screenInDirection("down")
    moveMouseToScreen(nextScreen)
end)
