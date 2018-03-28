--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeState('walk')
    end
end