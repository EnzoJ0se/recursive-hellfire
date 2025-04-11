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
    })
    setmetatable(instance, self)

    return instance
end

function Player:move(x, y)
    self.world_object.body:setLinearVelocity(0, -playerSpeed)

    self.x = self.x + x
    self.y = self.y + y
end

function Player:update(dt)
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

    self.x, self.y = self.world_object.body:getPosition()
end

function Player:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Player
