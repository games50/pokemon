--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity, level)
    EntityWalkState.init(self, entity, level)
    self.encounterFound = false
end

function PlayerWalkState:enter()
    self:checkForEncounter()

    if not self.encounterFound then
        self:attemptMove()
    end
end

function PlayerWalkState:checkForEncounter()
    local x, y = self.entity.mapX, self.entity.mapY

    -- chance to go to battle if we're walking into a grass tile, else move as normal
    if self.level.grassLayer.tiles[y][x].id == TILE_IDS['tall-grass'] and math.random(10) == 1 then
        self.entity:changeState('idle')

        -- trigger music changes
        gSounds['field-music']:pause()
        gSounds['battle-music']:play()
        
        -- first, push a fade in; when that's done, push a battle state and a fade
        -- out, which will fall back to the battle state once it pushes itself off
        gStateStack:push(
            FadeInState({
                r = 1, g = 1, b = 1,
            }, 1, 
            
            -- callback that will execute once the fade in is complete
            function()
                gStateStack:push(BattleState(self.entity))
                gStateStack:push(FadeOutState({
                    r = 1, g = 1, b = 1,
                }, 1,
            
                function()
                    -- nothing to do or push here once the fade out is done
                end))
            end)
        )

        self.encounterFound = true
    else
        self.encounterFound = false
    end
end