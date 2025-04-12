---@class Button
---@field x number
---@field y number
---@field mx number
---@field my number
---@field px number
---@field py number
---@field width number
---@field height number
---@field color table
---@field hover_color table
---@field text_color table
---@field text string?
---@field on_click function?
---@field clicking boolean
---@field clicked boolean
local Button = {
    x = 0,
    y = 0,
    mx = 0,
    my = 0,
    px = 0,
    py = 0,
    width = 0,
    height = 0,
    color = { 1, 1, 1 },
    hover_color = { 0.5, 0.5, 0.5 },
    text_color = { 0, 0, 1 },
    text = nil,
    on_click = nil,
    clicking = false,
    clicked = false,
}
Button.__index = Button

---@param opts table
---@return Button
function Button:new(opts)
    local button = {
        text = opts.text or Button.text,
        x = opts.x or Button.x,
        y = opts.y or Button.y,
        mx = opts.mx or Button.mx,
        my = opts.my or Button.my,
        px = opts.px or Button.px,
        py = opts.py or Button.py,
        width = opts.width or Button.width,
        height = opts.height or Button.height,
        color = opts.color or Button.color,
        text_color = opts.text_color or Button.text_color,
        hover_color = opts.hover_color or Button.hover_color,
        on_click = opts.on_click or Button.on_click,
        clicking = false,
        clicked = false,
    }

    setmetatable(button, self)
    self.__index = self

    return button
end

---@type love.Font
local font

function Button:load()
    font = love.graphics.newFont(32)
end

function Button:update()
    if self.clicking and not self.clicked then
        self.on_click()
    end
end

function Button:draw()
    self.clicked = self.clicking
    local x = self.x + (self.width / 2) - (font:getWidth(self.text) / 2)
    local y = self.y + (self.height / 2) - (font:getHeight() / 2)
    local mx, my = love.mouse.getPosition()

    local isHovering = (mx >= self.x and mx <= self.x + self.width) and (my >= self.y and my <= self.y + self.height)

    if isHovering and self.hover_color then
        self.clicking = love.mouse.isDown(1)
        love.graphics.setColor(unpack(self.hover_color))
    else
        love.graphics.setColor(unpack(self.color))
    end

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(unpack(self.text_color))
    love.graphics.print(self.text, font, x, y)
end

return Button
