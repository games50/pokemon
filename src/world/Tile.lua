--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Tile = Class{}

function Tile:init(x, y, id)
    self.x = x
    self.y = y
    self.id = id
end

function Tile:update(dt)

end

function Tile:render()
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id],
        (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end