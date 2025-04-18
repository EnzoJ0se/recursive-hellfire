---@class BaseLevel
---@field name string
---@field player Player
---@field enemies table
---@field map_location string
---@field map table
local BaseLevel = {
    name = nil,
    player = nil,
    enemies = {},
    world = nil,
}
BaseLevel.__index = BaseLevel

---@param opts table
function BaseLevel:new(opts)
    local level = {
        name = opts.name or BaseLevel.name,
        player = opts.player or BaseLevel.player,
        enemies = {},
        map_location = opts.map_location or BaseLevel.map_location,
        map = nil,
    }

    setmetatable(level, self)
    self.__index = self

    return level
end

return BaseLevel
