local LevelLayerEnum  = require("src.enum.level-layer-enum")
local WorldObjectType  = require("src.enum.world.world-object-type-enum")
local WorldBodyTypeEnum = require("src.enum.world.world-body-type-enum")

---@class MapLayer
---@field name LevelLayerEnum?
---@field object_type WorldObjectTypeEnum?
---@field body_type WorldBodyTypeEnum?
local MapLayer = {
    name = nil,
    object_type = nil,
    body_type = nil,
}
MapLayer.__index = MapLayer

return MapLayer
