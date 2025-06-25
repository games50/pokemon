love.graphics.setDefaultFilter('nearest', 'nearest')

Class = require 'lib.class'
push = require 'lib.push'

require 'Panel'
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

    selection = Selection {
        x = 32, y = 32,
        width = VIRTUAL_WIDTH - 64,
        height = VIRTUAL_HEIGHT - 64,
        items = {
            {
                text = 'Red',
                onSelect = function()
                    bg =  {1, 0, 0}
                end
            },
            {
                text = 'Green',
                onSelect = function()
                    bg = {0, 1, 0}
                end
            },
            {
                text = 'Blue',
                onSelect = function()
                    bg = {0, 0, 1}
                end
            },
            {
                text = 'Quit',
                onSelect = function()
                    love.event.quit()
                end
            }
        }
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

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    selection:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push.start()
    love.graphics.clear(bg or {0, 0, 0})
    selection:render()
    push.finish()
end