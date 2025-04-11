local BaseLevel = require("src.base.base-level")
local Player = require("src.model.player")
local Camera = require("src.model.camera")
local inspect = require("libraries.inspect")
local Map = require("src.model.map")
local LevelLayerEnum = require("src.enum.level-layer-enum")
local World = require("src.model.world")
local WorldObjectTypeEnum = require("src.enum.world.world-object-type")
local WorldBodyTypeEnum = require("src.enum.world.world-body-type")

---@class Camera
local camera = nil

---@class Map
local map = nil

---@class TutorialLevel : BaseLevel
local TutorialLevel = setmetatable({
    name = "tutorial-level",
    player = nil,
    enemies = {},
}, { __index = BaseLevel })
TutorialLevel.__index = TutorialLevel

function TutorialLevel:load()
    self.world = World:new({})
    map = Map:new("src/level/tutorial/tutorial-map.lua", { LevelLayerEnum.BACKGROUND, LevelLayerEnum.BARRIER })
    camera = Camera:new({ width = map.width, height = map.height })

    self:loadColliders()
    self.player = Player:new(self.world.objects[WorldObjectTypeEnum.PLAYER][1])
end

---@param dt number
function TutorialLevel:update(dt)
    map:update(dt)
    self.world:update(dt)
    self.player:update(dt)

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

function TutorialLevel:loadColliders()
    self.world:createObject(self.createPlayerFn, WorldObjectTypeEnum.PLAYER, {
        x = 16,
        y = 16,
        width = 32,
        height = 32,
        body_type = WorldBodyTypeEnum.DYNAMIC,
    })
    self.world.objects[WorldObjectTypeEnum.PLAYER][1].body:setFixedRotation(true)

    if map.instance.layers[LevelLayerEnum.WALLS] then
        for _, object in ipairs(map.instance.layers[LevelLayerEnum.WALLS].objects) do
            self.world:createObject(self.createWallFn, WorldObjectTypeEnum.WALL, {
                x = object.x + (object.width / 2),
                y = object.y + (object.height / 2),
                body_type = WorldBodyTypeEnum.STATIC,
                width = object.width,
                height = object.height,
            })
        end
    end
end

return TutorialLevel
