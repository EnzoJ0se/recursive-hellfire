local Menu = require("src.menu")
local GameState = require("src.state.game-state")
local GameStateEnum = require("src.enum.game-state-enum")
local TutorialLevel = require("src.level.tutorial.tutorial-level")

local M = {}

M.load = function()
    GameState.name = GameStateEnum.IN_GAME
    TutorialLevel:load()
end

function M:update(dt)
    TutorialLevel:update(dt)
end

M.draw = function()
    TutorialLevel:draw()
    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end

return M
