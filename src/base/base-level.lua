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

BaseLevel.createPlayerFn = function(body, opts)
    return love.physics.newRectangleShape(opts.x, opts.y, 32, 32)
end

BaseLevel.createWallFn = function(body, opts)
    --TODO: fix shape position
    return love.physics.newRectangleShape(opts.x, opts.y, opts.width, opts.height)
end

return BaseLevel
