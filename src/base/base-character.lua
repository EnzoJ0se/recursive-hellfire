local BaseCharacter = {
	x = 0,
	y = 0,
	sprite = nil,
	health = 100,
}
BaseCharacter.__index = BaseCharacter

function BaseCharacter:new(opts)
	local character = {
		x = opts.x or BaseCharacter.x,
		y = opts.y or BaseCharacter.y,
		sprite = love.graphics.newImage(opts.sprite),
		health = opts.health or BaseCharacter.health,
	}

	setmetatable(character, self)
	self.__index = self

	return character
end

return BaseCharacter
