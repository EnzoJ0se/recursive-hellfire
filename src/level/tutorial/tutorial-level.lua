local BaseLevel = require("src.base.base-level")
local Player = require("src.model.player")
local Camera = require("src.model.camera")
local inspect = require("libraries.inspect")
local Map = require("src.model.map")
local LevelLayerEnum = require("src.enum.level-layer-enum")
local World = require("src.model.world")
local WorldObjectTypeEnum = require("src.enum.world.world-object-type-enum")
local WorldBodyTypeEnum = require("src.enum.world.world-body-type-enum")

---@field camera Camera
local camera = nil

---@field map Map
local map = nil

---@field levelLayers MapLayer[]
local levelLayers = {
    { name = LevelLayerEnum.WALLS, object_type = WorldObjectTypeEnum.WALL, body_type = WorldBodyTypeEnum.STATIC },
}

---@class TutorialLevel : BaseLevel
---@field name string
---@field player Player
---@field enemies table
local TutorialLevel = setmetatable({
    name = "tutorial-level",
    player = nil,
    enemies = {},
}, { __index = BaseLevel })
TutorialLevel.__index = TutorialLevel

function TutorialLevel:load()
    map = Map:new("src/level/tutorial/tutorial-map.lua", { LevelLayerEnum.BACKGROUND, LevelLayerEnum.BARRIER })
    camera = Camera:new({ width = map.width, height = map.height })

    self.world = World:new({})
    self.world:createColisionsFromMap(map, levelLayers)
    self.player = Player:new()
    self.player:createCollision(self.world)
end

---@param dt number
function TutorialLevel:update(dt)
    map:update(dt)
    self.world:update(dt)
    self.player:update(dt, camera, map)
    camera:move(self.player.x, self.player.y)
end

function TutorialLevel:draw()
    camera:draw(function()
        love.graphics.setColor(1, 1, 1)
        map:draw()
        self.world:draw()
        self.player:draw()
    end)
end

return TutorialLevel
