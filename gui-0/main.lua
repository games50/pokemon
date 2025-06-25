love.graphics.setDefaultFilter('nearest', 'nearest')

Class = require 'lib.class'
push = require 'lib.push'
require 'Panel'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setTitle('gui-0')
    math.randomseed(os.time())

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    panel = Panel(16, 16, VIRTUAL_WIDTH - 32, VIRTUAL_HEIGHT - 32)

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
    panel:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push.start()
    panel:render()
    push.finish()
end