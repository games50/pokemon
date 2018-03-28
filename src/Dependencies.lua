--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Party'
require 'src/Pokemon'
require 'src/pokemon_defs'
require 'src/StateMachine'
require 'src/Util'

require 'src/battle/BattleSprite'
require 'src/battle/Opponent'

require 'src/entity/entity_defs'
require 'src/entity/Entity'
require 'src/entity/Player'

require 'src/gui/Menu'
require 'src/gui/Panel'
require 'src/gui/ProgressBar'
require 'src/gui/Selection'
require 'src/gui/Textbox'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'

require 'src/states/game/BattleState'
require 'src/states/game/BattleMenuState'
require 'src/states/game/BattleMessageState'
require 'src/states/game/DialogueState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/TakeTurnState'

require 'src/world/Level'
require 'src/world/tile_ids'
require 'src/world/Tile'
require 'src/world/TileMap'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/sheet.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['cursor'] = love.graphics.newImage('graphics/cursor.png'),

    ['aardart-back'] = love.graphics.newImage('graphics/pokemon/aardart-back.png'),
    ['aardart-front'] = love.graphics.newImage('graphics/pokemon/aardart-front.png'),
    ['agnite-back'] = love.graphics.newImage('graphics/pokemon/agnite-back.png'),
    ['agnite-front'] = love.graphics.newImage('graphics/pokemon/agnite-front.png'),
    ['anoleaf-back'] = love.graphics.newImage('graphics/pokemon/anoleaf-back.png'),
    ['anoleaf-front'] = love.graphics.newImage('graphics/pokemon/anoleaf-front.png'),
    ['bamboon-back'] = love.graphics.newImage('graphics/pokemon/bamboon-back.png'),
    ['bamboon-front'] = love.graphics.newImage('graphics/pokemon/bamboon-front.png'),
    ['cardiwing-back'] = love.graphics.newImage('graphics/pokemon/cardiwing-back.png'),
    ['cardiwing-front'] = love.graphics.newImage('graphics/pokemon/cardiwing-front.png'),
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
    ['field-music'] = love.audio.newSource('sounds/field_music.wav'),
    ['battle-music'] = love.audio.newSource('sounds/battle_music.mp3'),
    ['blip'] = love.audio.newSource('sounds/blip.wav'),
    ['powerup'] = love.audio.newSource('sounds/powerup.wav'),
    ['hit'] = love.audio.newSource('sounds/hit.wav'),
    ['run'] = love.audio.newSource('sounds/run.wav'),
    ['heal'] = love.audio.newSource('sounds/heal.wav'),
    ['exp'] = love.audio.newSource('sounds/exp.wav'),
    ['levelup'] = love.audio.newSource('sounds/levelup.wav'),
    ['victory-music'] = love.audio.newSource('sounds/victory.wav'),
    ['intro-music'] = love.audio.newSource('sounds/intro.mp3')
}