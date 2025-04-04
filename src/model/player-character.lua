local BaseCharacter = require("src.base.base-character")

local PlayerCharacter = setmetatable({}, { __index = BaseCharacter })
PlayerCharacter.__index = PlayerCharacter

function PlayerCharacter:new()
	local instance = BaseCharacter:new({ sprite = "assets/sprites/player-sprite.png" })
	setmetatable(instance, self)

	return instance
end

function PlayerCharacter:move(x, y)
	self.x = self.x + x
	self.y = self.y + y
end

function PlayerCharacter:update(dt)
	if love.keyboard.isDown("w") then
		self:move(0, -200 * dt)
	end

	if love.keyboard.isDown("a") then
		self:move(-200 * dt, 0)
	end

	if love.keyboard.isDown("s") then
		self:move(0, 200 * dt)
	end

	if love.keyboard.isDown("d") then
		self:move(200 * dt, 0)
	end
end

function PlayerCharacter:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, 1.5, 1.5)
end

return PlayerCharacter
