local BaseCharacter = require("src.base.base-character")
local WorldObject = require("src.model.world-object")

---@class Player : BaseCharacter
local Player = setmetatable({}, { __index = BaseCharacter })
Player.__index = Player

local playerSpeed = 500

---@param worldObject WorldObject
function Player:new(worldObject)
    local instance = BaseCharacter:new({
        sprite = "assets/sprites/player-sprite.png",
        world_object = worldObject,
        x = worldObject.x - (worldObject.width / 2),
        y = worldObject.y - (worldObject.height / 2),
        width = worldObject.width,
        height = worldObject.height,
    })
    setmetatable(instance, self)

    return instance
end

function Player:move(x, y)
    self.world_object.body:setLinearVelocity(0, -playerSpeed)

    self.x = self.x + x
    self.y = self.y + y
end

function Player:update(dt, mapWidth, mapHeight)
    local isMoving = false

    if love.keyboard.isDown("w") then
        isMoving = true
        self.world_object.body:setLinearVelocity(0, -playerSpeed)
    end

    if love.keyboard.isDown("a") then
        isMoving = true
        self.world_object.body:setLinearVelocity(-playerSpeed, 0)
    end

    if love.keyboard.isDown("s") then
        isMoving = true
        self.world_object.body:setLinearVelocity(0, playerSpeed)
    end

    if love.keyboard.isDown("d") then
        isMoving = true
        self.world_object.body:setLinearVelocity(playerSpeed, 0)
    end

    if not isMoving then
        self.world_object.body:setLinearVelocity(0, 0)
    end

    local x, y = self.world_object.body:getPosition()

    if x < 0 then x = 0 end
    if y < 0 then y = 0 end
    if x > mapWidth - self.width then x = mapWidth - self.width end
    if y > mapHeight - self.height then y = mapHeight - self.height end

    self.world_object.body:setPosition(x, y)
    self.x, self.y = x, y
end

function Player:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Player
