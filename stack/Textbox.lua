--[[
    CS50 2D
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Textbox = Class{}

function Textbox:init(x, y, width, height, text, font)
    self.panel = Panel(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.text = text
    self.font = font or gFonts['small']
    
    self.padding = 8 -- global padding for all edges
    self.lineHeight = self.font:getHeight()
    self.linePadding = 2 -- extra vertical space between lines
    
    -- total lines that can fit in the textbox
    self.maxLines = math.floor((self.height - 2 * self.padding) / (self.lineHeight + self.linePadding))
    
    -- break the text into chunks that fit within the textbox width
    _, self.textChunks = self.font:getWrap(self.text, self.width - 2 * self.padding)

    self.chunkCounter = 1
    self.endOfText = false
    self.closed = false

    self:next()
end

--[[
    Goes to the next page of text if there is any, otherwise toggles the textbox.
]]
function Textbox:nextChunks()
    local chunks = {}
    local startIdx = self.chunkCounter
    local endIdx = math.min(self.chunkCounter + self.maxLines - 1, #self.textChunks)

    for i = startIdx, endIdx do
        table.insert(chunks, self.textChunks[i])
    end

    if endIdx == #self.textChunks then
        self.endOfText = true
    else
        self.chunkCounter = endIdx + 1
    end

    return chunks
end

function Textbox:next()
    if self.endOfText then
        self.displayingChunks = {}
        self.panel:toggle()
        self.closed = true
    else
        self.displayingChunks = self:nextChunks()
    end
end

function Textbox:update(dt)
    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self:next()
    end
end

function Textbox:isClosed()
    return self.closed
end

function Textbox:render()
    self.panel:render()
    
    love.graphics.setFont(self.font)
    for i = 1, #self.displayingChunks do
        love.graphics.print(
            self.displayingChunks[i],
            self.x + self.padding,
            self.y + self.padding + (i - 1) * (self.lineHeight + self.linePadding)
        )
    end
end