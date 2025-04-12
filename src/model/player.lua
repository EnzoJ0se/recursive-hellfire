local BaseCharacter = require("src.base.base-character")
local WorldObject = require("src.model.world-object")

---@class Player : BaseCharacter
local Player = setmetatable({}, { __index = BaseCharacter })
Player.__index = Player

local playerSpeed = 800

---@return Player
function Player:new()
    local instance = BaseCharacter:new({ sprite = "assets/sprites/player-top.png" })
    setmetatable(instance, self)

    return instance
end

---@param world World
function Player:createCollision(world)
    local worldObject = world:createPlayer(self)

    self.world_object = worldObject
    self.x = worldObject.x - (worldObject.width / 2)
    self.y = worldObject.y - (worldObject.height / 2)
    self.width = worldObject.width
    self.height = worldObject.height
end

---@param dt number
---@param camera Camera
---@param map Map
function Player:update(dt, camera, map)
    self:listenKeyboardInputs()

    local mouseX, mouseY = camera:getGlobalCoordinates(love.mouse.getPosition())
    local x, y, angle = self.world_object.body:getPosition()

    x, y = self:validatePosition(x, y, map)
    angle = math.atan2(mouseY - y, mouseX - x)

    self.world_object.body:setTransform(x, y, angle)
    self.x, self.y, self.angle = x, y, angle
end

function Player:draw()
    love.graphics.draw(
        self.sprite,
        self.x,
        self.y,
        self.angle,
        2,
        2,
        self.sprite:getWidth() / 2,
        self.sprite:getHeight() / 2
    )
end

function Player:listenKeyboardInputs()
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
end

---@param x number
---@param y number
---@param map Map
function Player:validatePosition(x, y, map)
    if x < 0 then
        x = 0
    end

    if y < 0 then
        y = 0
    end

    if x > map.width - self.width then
        x = map.width - self.width
    end

    if y > map.height - self.height then
        y = map.height - self.height
    end

    return x, y
end

return Player
