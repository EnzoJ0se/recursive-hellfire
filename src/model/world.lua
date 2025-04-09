local WorldObjectTypeEnum = require("src.enum.world.world-object-type")
local Object = require("src.model.world-object")
local inspect = require("libraries.inspect")

---@class World
---@field instance love.World
---@field objects table
---@field objects.walls table
---@field objects.enemies table
---@field objects.items table
---@field objects.player table
local World = {
    instance = nil,
    objects = {
        walls = {},
        enemies = {},
        items = {},
        player = {},
    },
}
World.__index = World

local meter = 32

---@param opts table
---@return World
function World:new(opts)
    love.physics.setMeter(opts.meter or meter)

    local world = { instance = love.physics.newWorld(0, 0) }
    setmetatable(world, self)
    self.__index = self

    return world
end

---@param self World
---@param createShape fun(body: love.Body, opts: table): love.Shape
---@param type WorldObjectTypeEnum
---@param opts table
---@return WorldObject
function World:createObject(createShape, type, opts)
    local object = setmetatable({ x = opts.x, y = opts.y }, { __index = Object })
    local x = (opts.x + opts.width / 2) / meter
    local y = (opts.y + opts.height / 2) / meter

    --TODO: fix body position
    object.body = love.physics.newBody(self.instance, x, y, opts.body_type or "static")
    object.shape = createShape(object.body, opts)
    object.fixture = love.physics.newFixture(object.body, object.shape, opts.density or 1)

    table.insert(self.objects[type], object)

    return object
end

function World:update(dt)
    self.instance:update(dt)
end

function World:draw()
    local player = self.objects.player[1]
    love.graphics.polygon("line", player.body:getWorldPoints(player.shape:getPoints()))

    for _, obj in ipairs(self.objects[WorldObjectTypeEnum.WALL]) do
        love.graphics.polygon("line", obj.body:getWorldPoints(obj.shape:getPoints()))
    end
end

return World
