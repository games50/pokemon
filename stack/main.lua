love.graphics.setDefaultFilter('nearest', 'nearest')

Class = require 'lib.class'
push = require 'lib.push'
Timer = require 'lib.knife.timer'

require 'Panel'
require 'Textbox'
require 'StateStack'
require 'stack.NewPopupState'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setTitle('stack')
    math.randomseed(os.time())

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }

    gStateStack = StateStack()
    local popupCap = 100
    local popupCount = 0

    local function spawnPopup()
        if popupCount < popupCap then
            gStateStack:push(NewPopupState())
            popupCount = popupCount + 1
        end
    end

    Timer.every(0.05, spawnPopup)

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push.start()
    gStateStack:render()
    -- print size of stack
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle('fill', 0, 0, 100, 30)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('Stack size: ' .. tostring(#gStateStack.states), 10, 10)
    push.finish()
end