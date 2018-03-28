--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

NPC = Class{__includes = Entity}

function NPC:init(def)
    Entity.init(self, def)

    -- text that will be 
    self.text = "Hi, I'm an NPC, demonstrating some dialogue! Isn't that cool??"
end

--[[
    Function that will get called when we try to interact with this entity.
]]
function NPC:onInteract()
    gStateStack:push(DialogueState(self.text))
end