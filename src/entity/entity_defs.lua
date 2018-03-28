--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['walk-left'] = {
                frames = {16, 17, 18, 17},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-right'] = {
                frames = {28, 29, 30, 29},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-down'] = {
                frames = {4, 5, 6, 5},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-up'] = {
                frames = {40, 41, 42, 41},
                interval = 0.15,
                texture = 'entities'
            },
            ['idle-left'] = {
                frames = {17},
                texture = 'entities'
            },
            ['idle-right'] = {
                frames = {29},
                texture = 'entities'
            },
            ['idle-down'] = {
                frames = {5},
                texture = 'entities'
            },
            ['idle-up'] = {
                frames = {41},
                texture = 'entities'
            },
        }
    },
    ['npc'] = {
        animations = {
            ['walk-left'] = {
                frames = {16, 17, 18, 17},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-right'] = {
                frames = {28, 29, 30, 29},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-down'] = {
                frames = {4, 5, 6, 5},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-up'] = {
                frames = {40, 41, 42, 41},
                interval = 0.15,
                texture = 'entities'
            },
            ['idle-left'] = {
                frames = {17},
                texture = 'entities'
            },
            ['idle-right'] = {
                frames = {29},
                texture = 'entities'
            },
            ['idle-down'] = {
                frames = {5},
                texture = 'entities'
            },
            ['idle-up'] = {
                frames = {41},
                texture = 'entities'
            },
        }
    }
}