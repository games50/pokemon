--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

BattleMessageState = Class{__includes = BaseState}

function BattleMessageState:init(msg, onClose, canInput)
    self.textbox = Textbox(0, VIRTUAL_HEIGHT - 64, VIRTUAL_WIDTH, 64, msg, gFonts['medium'])

    -- function to be called once this message is popped
    self.onClose = onClose or function() end

    -- whether we can detect input with this or not; true by default
    self.canInput = canInput

    -- default input to true if nothing was passed in
    if self.canInput == nil then self.canInput = true end
end

function BattleMessageState:update(dt)
    if self.canInput then
        self.textbox:update(dt)

        if self.textbox:isClosed() then
            gStateStack:pop()
            self.onClose()
        end
    end
end

function BattleMessageState:render()
    self.textbox:render()
end