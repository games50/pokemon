love.graphics.setDefaultFilter('nearest', 'nearest')

Timer =  require 'lib.knife.timer'
Class = require 'lib.class'
push = require 'lib.push'

require 'Panel'
require 'ProgressBar'
require 'Selection'
require 'Textbox'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setTitle('gui-1')
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

    gTextures = {
        ['cursor'] = love.graphics.newImage('cursor.png'),
    }

    gSounds = {
        ['blip'] = love.audio.newSource('blip.wav', 'static'),
    }

    animating = false
    pb = ProgressBar {
        x = 32, y = 32,
        width = VIRTUAL_WIDTH - 64,
        height = 16,
        value = 0,
        max = 1.0,
        color = { r = 0.2, g = 0.8, b = 0.2 },
        text = 'Progress',
        font = gFonts['medium']
    }

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if not animating then
        if key == 'right' and pb.value < 1 then
            Timer.tween(1, {
                [pb] = { value = 1 }
            }):finish(function()
                animating = false
            end)
            animating = true
        elseif key == 'left' and pb.value > 0 then
            Timer.tween(1, {
                [pb] = { value = 0 }
            }):finish(function()
                animating = false
            end)
            animating = true
        end
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    pb:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push.start()
    love.graphics.clear(0.2, 0.2, 0.2, 1)
    pb:render()
    push.finish()
end