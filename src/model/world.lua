local WorldObjectTypeEnum = require("src.enum.world.world-object-type-enum")
local WorldBodyTypeEnum = require("src.enum.world.world-body-type-enum")
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

---@param dt number
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
    local object = setmetatable({
        x = opts.x,
        y = opts.y,
        width = opts.width,
        height = opts.height,
    }, { __index = Object })

    object.body = love.physics.newBody(self.instance, opts.x, opts.y, opts.body_type or "static")
    object.shape = createShape(object.body, opts)
    object.fixture = love.physics.newFixture(object.body, object.shape, opts.density or 1)

    table.insert(self.objects[type], object)

    return object
end

---@param player Player
---@return WorldObject
function World:createPlayer(player)
    local spriteW = player.sprite:getWidth()
    local spriteH = player.sprite:getHeight()

    local playerFn = function(body, opts)
        return love.physics.newRectangleShape(0, 0, spriteW, spriteW)
    end

    local playerObject = self:createObject(playerFn, WorldObjectTypeEnum.PLAYER, {
        x = 64,
        y = 64,
        width = 64,
        height = 64,
        body_type = WorldBodyTypeEnum.DYNAMIC,
    })
    playerObject.body:setFixedRotation(true)

    return playerObject
end

---@param map Map
---@param layers MapLayer[]
function World:createColisionsFromMap(map, layers)
    local createWallFn = function(body, opts)
        return love.physics.newRectangleShape(opts.width, opts.height)
    end

    for _, layer in ipairs(layers) do
        if not map.instance.layers[layer.name] then
            goto continue
        end

        for _, object in ipairs(map.instance.layers[layer.name].objects) do
            self:createObject(createWallFn, layer.object_type, {
                x = object.x + (object.width / 2),
                y = object.y + (object.height / 2),
                body_type = layer.body_type,
                width = object.width,
                height = object.height,
            })
        end

        ::continue::
    end
end

return World
