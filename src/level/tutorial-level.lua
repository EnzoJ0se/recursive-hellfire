local TextureEnum = require("src.enum.texture-enum")
local PlayerCharacter = require("src.model.player-character")

local TutorialLevel = {
	name = "tutorial-level",
	player = nil,
	enemies = {},
	level_struture = {},
}

local assets = {}
local tileSize = 32
local quad

function TutorialLevel:load()
	assets = self.loadAssets()
	quad = love.graphics.newQuad(1 * tileSize, 0, tileSize, tileSize, assets[TextureEnum.GRASS_TILE]:getDimensions())
	self:setLevelStructure()
	self:createSpriteBatch()

	self.player = PlayerCharacter:new()
end

function TutorialLevel:update(dt)
	self.player:update(dt)
end

function TutorialLevel:draw()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
	love.graphics.draw(spriteBatch)
	self.player:draw()
end

function TutorialLevel.loadAssets()
	return {
		[TextureEnum.GRASS] = love.graphics.newImage(TextureEnum.getAsset(TextureEnum.GRASS)),
		[TextureEnum.GRASS_TILE] = love.graphics.newImage(TextureEnum.getAsset(TextureEnum.GRASS_TILE)),
	}
end

function TutorialLevel:setLevelStructure()
	for i = 1, 600 do
		self.level_struture[i] = {}

		for j = 1, 800 do
			self.level_struture[i][j] = TextureEnum.GRASS_TILE
		end
	end
end

function TutorialLevel:createSpriteBatch()
	local rows = #self.level_struture
	local cols = #self.level_struture[1]
	spriteBatch = love.graphics.newSpriteBatch(assets[TextureEnum.GRASS_TILE], rows * cols)

	for row = 1, rows do
		for col = 1, cols do
			spriteBatch:add(quad, (col - 1) * tileSize, (row - 1) * tileSize)
		end
	end
end

return TutorialLevel
