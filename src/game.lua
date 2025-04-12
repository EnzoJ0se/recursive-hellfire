local Menu = require("src.menu")
local GameState = require("src.state.game-state")
local GameStateEnum = require("src.enum.game-state-enum")
local TutorialLevel = require("src.level.tutorial.tutorial-level")

local Game = {}

Game.load = function()
    GameState.name = GameStateEnum.IN_GAME
    TutorialLevel:load()
end

---@param dt number
function Game:update(dt)
    TutorialLevel:update(dt)
end

Game.draw = function()
    TutorialLevel:draw()
    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end

return Game
