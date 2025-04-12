local GameState = require("src.state.game-state")
local Button = require("src.ui.button")

local screenWidth, screenHeight = love.graphics.getDimensions()
local buttonWidth = screenWidth * (1 / 3)
local buttonHeight = screenHeight * (1 / 10)

---@class Menu
---@field buttons Button[]
local Menu = {
    buttons = {
        Button:new({
            text = "Start Game",
            x = screenWidth / 2 - buttonWidth / 2,
            y = screenHeight * (1 / 3),
            width = buttonWidth,
            height = buttonHeight,
            color = { 0.1, 0.1, 0.1 },
            hover_color = { 0.5, 0.5, 0.5 },
            text_color = { 1, 1, 1 },
            on_click = function()
                GameState.name = "IN_GAME"
                GameState.is_in_game = true
                GameState.reload_state= true
            end,
        }),
        Button:new({
            text = "Exit",
            x = screenWidth / 2 - buttonWidth / 2,
            y = screenHeight * (2 / 3),
            width = buttonWidth,
            height = buttonHeight,
            color = { 0.1, 0.1, 0.1 },
            hover_color = { 0.5, 0.5, 0.5 },
            text_color = { 1, 1, 1 },
            on_click = function()
                love.event.quit()
            end,
        }),
    },
}

function Menu:load()
    for _, button in ipairs(self.buttons) do
        button:load()
    end
end

---@param dt number
function Menu:update(dt)
    for _, button in ipairs(self.buttons) do
        button:update(dt)
    end
end

function Menu:draw()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    for _, button in ipairs(self.buttons) do
        button:draw()
    end
end

return Menu
