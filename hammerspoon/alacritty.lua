-- Hammerspoon Spaces Management Library
-- https://github.com/asmagill/hs._asm.spaces
local spaces = require('hs.spaces')

local ALACRITTY_NAME = 'Alacritty'
local ALACRITTY_SELECTOR = 'org.alacritty'
local ALACRITTY_TOGGLE_KEY = '.'
local ALACRITTY_TOGGLE_KEY_MODIFIERS = {'alt'}
local ALACRITTY_TOGGLE_FULLSCREEN_KEYBIND = {'cmd', 'return'}
local ALACRITTY_REFOCUS_LAST_ACTIVATED_APP = true

-- Configuration options for the Alacritty script
local CONFIG = {
  WIDTH_SCALE = 0.85,
  HEIGHT_SCALE = 0.8,
  HIDE_ON_FOCUS_LOST = false,
}

-- Global storage for the last acitvated application
local LAST_ACTIVATED_APP = nil

-- Handle triggering the Alacritty application's fullscreen keybind
--
-- @param app The Alacritty application
function toggleAlacrittyFullscreen(app)
  hs.eventtap.keyStroke(table.unpack(ALACRITTY_TOGGLE_FULLSCREEN_KEYBIND), 0, app)
end

-- Handle moving the Alacritty application to the specified space and screen
--
-- @param app The Alacritty application
-- @param space The currently active space
-- @param screen The currently active screen
-- @param widthScale The desired width scaling factor for the application
-- @param heightScale The desired height scaling factor for the application
function moveAlacritty(app, space, screen, widthScale, heightScale)
  widthScale = widthScale or CONFIG['WIDTH_SCALE']
  heightScale = heightScale or CONFIG['HEIGHT_SCALE']

  -- Discover the provided application's main window
  -- Note the while-loop as calls to `mainWindow` could return `nil`
  local window = nil
  while window == nil do
    window = app:mainWindow()
  end

  if window:isFullscreen() then
    toggleAlacrittyFullscreen(app)
  end

  local windowFrame = window:frame()
  local screenFrame = screen:fullFrame()

  if not window:isFullscreen() then
    -- Scale the application's window according to the provided modifiers
    windowFrame.w = screenFrame.w * widthScale
    windowFrame.h = screenFrame.h * heightScale
    window:setFrame(windowFrame)

    -- Center the application on the current screen
    window:centerOnScreen(screen)
  end

  -- Attempt to move the application to the active space
  spaces.moveWindowToSpace(window, space)

  if window:isFullscreen() then
    toggleAlacrittyFullscreen(app)
  end

  -- Draw focus to the applications main window
  window:focus()
end

-- Handle toggling the visibility of the Alacritty application
function toggleAlacritty()
  local alacritty = hs.application.get(ALACRITTY_SELECTOR)

  if alacritty ~= nil and alacritty:isFrontmost() then
    -- If Alacritty is running and is the frontmost application, hide it
    alacritty:hide()
    if ALACRITTY_REFOCUS_LAST_ACTIVATED_APP and LAST_ACTIVATED_APP ~= nil then
      if LAST_ACTIVATED_APP:isRunning() then
        LAST_ACTIVATED_APP:activate()
      end
      LAST_ACTIVATED_APP = nil
    end
  else
    if ALACRITTY_REFOCUS_LAST_ACTIVATED_APP then
      LAST_ACTIVATED_APP = hs.application.frontmostApplication()
    end
    local focusedSpace = spaces.focusedSpace()
    local mainScreen = hs.screen.find(spaces.spaceDisplay(focusedSpace))

    -- If Alacritty is not running, attempt to launch the application
    if alacritty == nil and hs.application.launchOrFocus(ALACRITTY_NAME) then
      local appWatcher = nil
      appWatcher = hs.application.watcher.new(function (name, event, app)
        if event == hs.application.watcher.launched and name == ALACRITTY_NAME then
          app:hide()
          moveAlacritty(app, focusedSpace, mainScreen)
          appWatcher:stop()
        end
      end)
      appWatcher:start()
    end

    if alacritty ~= nil then
      moveAlacritty(alacritty, focusedSpace, mainScreen)
    end
  end
end

-- Bind toggling the Alacritty application
hs.hotkey.bind(ALACRITTY_TOGGLE_KEY_MODIFIERS, ALACRITTY_TOGGLE_KEY, toggleAlacritty)

-- Subscribe to events in order to hide the Alacritty application if focus is lost
if CONFIG['HIDE_ON_FOCUS_LOST'] then
  hs.window.filter.default:subscribe(hs.window.filter.windowUnfocused, function(window, app)
    local alacritty = hs.application.get(ALACRITTY_SELECTOR)
    if alacritty ~= nil then
      alacritty:hide()
    end
  end)
end
