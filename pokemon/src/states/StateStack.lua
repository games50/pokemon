--[[
    CS50 2D
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StateStack = Class{}

function StateStack:init()
    self.states = {}
end

function StateStack:update(dt)
    if #self.states == 0 then
        return
    end
    self.states[#self.states]:update(dt)
end

function StateStack:processAI(params, dt)
    if #self.states == 0 then
        return
    end
    self.states[#self.states]:processAI(params, dt)
end

function StateStack:render()
    for i, state in ipairs(self.states) do
        state:render()
    end
end

function StateStack:clear()
    self.states = {}
end

function StateStack:push(state)
    table.insert(self.states, state)
    state:enter()
end

function StateStack:pop()
    if #self.states == 0 then
        return
    end
    self.states[#self.states]:exit()
    table.remove(self.states)
end