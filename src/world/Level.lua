--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Level = Class{}

function Level:init()
    self.tileWidth = 50
    self.tileHeight = 50

    self.baseLayer = TileMap(self.tileWidth, self.tileHeight)
    self.grassLayer = TileMap(self.tileWidth, self.tileHeight)
    self.halfGrassLayer = TileMap(self.tileWidth, self.tileHeight)

    self:createMaps()

    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        mapX = 10,
        mapY = 10,
        width = 16,
        height = 16,
    }

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }
    self.player.stateMachine:change('idle')
end

function Level:createMaps()

    -- fill the base tiles table with random grass IDs
    for y = 1, self.tileHeight do
        table.insert(self.baseLayer.tiles, {})

        for x = 1, self.tileWidth do
            local id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]

            table.insert(self.baseLayer.tiles[y], Tile(x, y, id))
        end
    end

    -- place tall grass in the tall grass layer
    for y = 1, self.tileHeight do
        table.insert(self.grassLayer.tiles, {})
        table.insert(self.halfGrassLayer.tiles, {})

        for x = 1, self.tileWidth do
            local id = y > 10 and TILE_IDS['tall-grass'] or TILE_IDS['empty']

            table.insert(self.grassLayer.tiles[y], Tile(x, y, id))
        end
    end
end

function Level:update(dt)
    self.player:update(dt)
end

function Level:render()
    self.baseLayer:render()
    self.grassLayer:render()
    self.player:render()
end