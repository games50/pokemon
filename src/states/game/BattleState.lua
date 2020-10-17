--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

BattleState = Class{__includes = BaseState}

function BattleState:init(player)
    self.player = player
    self.bottomPanel = Panel(0, VIRTUAL_HEIGHT - 64, VIRTUAL_WIDTH, 64)

    -- flag for when the battle can take input, set in the first update call
    self.battleStarted = false

    self.opponent = Opponent {
        party = Party {
            pokemon = {
                Pokemon(Pokemon.getRandomDef(), math.random(2, 6))
            }
        }
    }

    self.playerSprite = BattleSprite(self.player.party.pokemon[1].battleSpriteBack, 
        -64, VIRTUAL_HEIGHT - 128)
    self.opponentSprite = BattleSprite(self.opponent.party.pokemon[1].battleSpriteFront, 
        VIRTUAL_WIDTH, 8)

    -- health bars for pokemon
    self.playerHealthBar = ProgressBar {
        x = VIRTUAL_WIDTH - 160,
        y = VIRTUAL_HEIGHT - 80,
        width = 152,
        height = 6,
        color = {r = 189/255, g = 32/255, b = 32/255},
        value = self.player.party.pokemon[1].currentHP,
        max = self.player.party.pokemon[1].HP
    }

    self.opponentHealthBar = ProgressBar {
        x = 8,
        y = 8,
        width = 152,
        height = 6,
        color = {r = 189/255, g = 32/255, b = 32/255},
        value = self.opponent.party.pokemon[1].currentHP,
        max = self.opponent.party.pokemon[1].HP
    }

    -- exp bar for player
    self.playerExpBar = ProgressBar {
        x = VIRTUAL_WIDTH - 160,
        y = VIRTUAL_HEIGHT - 73,
        width = 152,
        height = 6,
        color = {r = 32/255, g = 32/255, b = 189/255},
        value = self.player.party.pokemon[1].currentExp,
        max = self.player.party.pokemon[1].expToLevel
    }

    -- flag for rendering health (and exp) bars, shown after pokemon slide in
    self.renderHealthBars = false

    -- circles underneath pokemon that will slide from sides at start
    self.playerCircleX = -68
    self.opponentCircleX = VIRTUAL_WIDTH + 32

    -- references to active pokemon
    self.playerPokemon = self.player.party.pokemon[1]
    self.opponentPokemon = self.opponent.party.pokemon[1]
end

function BattleState:enter(params)
    
end

function BattleState:exit()
    gSounds['battle-music']:stop()
    -- gSounds['field-music']:play()
end

function BattleState:update(dt)
    -- this will trigger the first time this state is actively updating on the stack
    if not self.battleStarted then
        self:triggerSlideIn()
    end
end

function BattleState:render()
    love.graphics.clear(214/255, 214/255, 214/255, 1)

    love.graphics.setColor(45/255, 184/255, 45/255, 124/255)
    love.graphics.ellipse('fill', self.opponentCircleX, 60, 72, 24)
    love.graphics.ellipse('fill', self.playerCircleX, VIRTUAL_HEIGHT - 64, 72, 24)

    love.graphics.setColor(1, 1, 1, 1)
    self.opponentSprite:render()
    self.playerSprite:render()

    if self.renderHealthBars then
        self.playerHealthBar:render()
        self.opponentHealthBar:render()
        self.playerExpBar:render()

        -- render level text
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.setFont(gFonts['small'])
        love.graphics.print('LV ' .. tostring(self.playerPokemon.level),
            self.playerHealthBar.x, self.playerHealthBar.y - 10)
        love.graphics.print('LV ' .. tostring(self.opponentPokemon.level),
            self.opponentHealthBar.x, self.opponentHealthBar.y + 8)
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 1, 1, 1)
    end

    self.bottomPanel:render()
end

function BattleState:triggerSlideIn()
    self.battleStarted = true

    -- slide the sprites and circles in from the edges, then trigger first dialogue boxes
    Timer.tween(1, {
        [self.playerSprite] = {x = 32},
        [self.opponentSprite] = {x = VIRTUAL_WIDTH - 96},
        [self] = {playerCircleX = 66, opponentCircleX = VIRTUAL_WIDTH - 70}
    })
    :finish(function()
        self:triggerStartingDialogue()
        self.renderHealthBars = true
    end)
end

function BattleState:triggerStartingDialogue()
    
    -- display a dialogue first for the pokemon that appeared, then the one being sent out
    gStateStack:push(BattleMessageState('A wild ' .. tostring(self.opponent.party.pokemon[1].name ..
        ' appeared!'),
    
    -- callback for when the battle message is closed
    function()
        gStateStack:push(BattleMessageState('Go, ' .. tostring(self.player.party.pokemon[1].name .. '!'),
    
        -- push a battle menu onto the stack that has access to the battle state
        function()
            gStateStack:push(BattleMenuState(self))
        end))
    end))
end