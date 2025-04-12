local Menu = require("src.view.menu")
local GameState = require("src.state.game-state")
local GameStateEnum = require("src.enum.game-state-enum")
local TutorialLevel = require("src.level.tutorial.tutorial-level")

local Game = {
    is_loaded = false,
}

function Game:load()
    if not self.is_loaded then
        GameState.name = GameStateEnum.MENU
        GameState.is_main_menu = true
        self.is_loaded = true
    end

    if GameState.is_main_menu then
        Menu:load()
    end

    if GameState.is_in_game then
        TutorialLevel:load()
    end
end

---@param dt number
function Game:update(dt)
    if GameState.is_main_menu then
        Menu:update(dt)
    end

    if GameState.reload_state then
        self:load()
        GameState.reload_state = false
    end

    if GameState.is_in_game then
        TutorialLevel:update(dt)
    end
end

function Game.draw()
    if GameState.is_main_menu then
        Menu:draw()
    end

    if GameState.is_in_game then
        TutorialLevel:draw()
    end

    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end

return Game
