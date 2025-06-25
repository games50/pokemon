--[[
    NewPopupState
    Spams a random Textbox popup at a random position with random lorem ipsum text.
]]

require 'BaseState'
require 'Textbox'

local VIRTUAL_WIDTH = VIRTUAL_WIDTH or 384
local VIRTUAL_HEIGHT = VIRTUAL_HEIGHT or 216

local LOREM = {
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
}

local function random_lorem()
    local t = {}
    local n = math.random(2, 5)
    for i = 1, n do
        table.insert(t, LOREM[math.random(#LOREM)])
    end
    return table.concat(t, ' ')
end

NewPopupState = Class{__includes = BaseState}

function NewPopupState:init()
    -- random size
    local w = math.random(120, 220)
    local h = math.random(40, 100)
    -- random position within screen bounds
    local x = math.random(0, VIRTUAL_WIDTH - w)
    local y = math.random(0, VIRTUAL_HEIGHT - h)
    -- random text
    local text = random_lorem()
    self.textbox = Textbox(x, y, w, h, text, gFonts['small'])
end

function NewPopupState:update(dt)
    self.textbox:update(dt)

    if self.textbox:isClosed() then
        gStateStack:pop()
    end
end

function NewPopupState:render()
    self.textbox:render()
end

function NewPopupState:isClosed()
    return self.textbox:isClosed()
end
