Menu = require("src.menu")
GameState = require("src.state.game-state")
GameStateEnum = require("src.enum.game-state-enum")

M = {}

M.load = function()
	Menu.load()
end

function M:update(dt)
	-- TODO
end

M.draw = function()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
	love.graphics.print("In Game", 10, 10)
end

return M
