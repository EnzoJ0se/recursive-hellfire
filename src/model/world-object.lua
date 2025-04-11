---@class WorldObject
---@field x number
---@field y number
---@field width number
---@field height number
---@field body love.Body
---@field shape love.Shape
---@field fixture love.Fixture
local WorldObject = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    body = nil,
    shape = nil,
    fixture = nil,
}
WorldObject.__index = WorldObject

function WorldObject:new(opts)
    local object = {
        x = opts.x or WorldObject.x,
        y = opts.y or WorldObject.y,
        width = opts.width or WorldObject.width,
        height = opts.height or WorldObject.height,
        body = opts.body,
        shape = opts.shape,
        fixture = opts.fixture,
    }

    setmetatable(object, self)
    self.__index = self

    return object
end

return WorldObject
