local BaseCharacter = require("src.base.base-character")
local WorldObject = require("src.model.world-object")

---@class Player : BaseCharacter
---@field in_dash boolean
---@field dash_time number
---@field dash_cooldown number
---@field sprite_dash love.Image?
local Player = setmetatable({
    in_dash = false,
    dash_time = 0,
    dash_cooldown = 0,
    sprite_dash = nil,
}, { __index = BaseCharacter })
Player.__index = Player

---@class MovementData
---@field speed number
---@field dash_speed number
---@field dash_cooldown number
---@field dash_time number
local MovementData = {
    speed = 800,
    dash_speed = 1600,
    dash_cooldown = 80,
    dash_time = 20,
}

---@param self Player
---@param x number
---@param y number
---@param map Map
local function validatePosition(self, x, y, map)
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

---@param self Player
---@param dt number
---@return number
local function bindPlayerSpeed(self, dt)
    if self.dash_cooldown > 0 then
        self.dash_cooldown = self.dash_cooldown - (1 * dt)

        if self.dash_cooldown <= 0 then
            self.dash_cooldown = 0
        end
    end

    if not self.in_dash then
        return MovementData.speed
    end

    self.dash_time = self.dash_time - (1 * dt)

    if self.dash_time <= 0 then
        self.in_dash = false
        self.dash_time = 0
        self.dash_cooldown = MovementData.dash_cooldown * dt
    end

    if self.in_dash then
        return MovementData.dash_speed
    end

    return MovementData.speed
end

---@param self Player
---@param dt number
local function listenKeyboardInputs(self, dt)
    local isMoving = false
    local speed = bindPlayerSpeed(self, dt)

    if love.keyboard.isDown("space") and not self.in_dash and self.dash_cooldown == 0 then
        self.in_dash = true
        self.dash_time = MovementData.dash_time * dt
    end

    if love.keyboard.isDown("w") then
        isMoving = true
        self.world_object.body:setLinearVelocity(0, -speed)
    end

    if love.keyboard.isDown("a") then
        isMoving = true
        self.world_object.body:setLinearVelocity(-speed, 0)
    end

    if love.keyboard.isDown("s") then
        isMoving = true
        self.world_object.body:setLinearVelocity(0, speed)
    end

    if love.keyboard.isDown("d") then
        isMoving = true
        self.world_object.body:setLinearVelocity(speed, 0)
    end

    if not isMoving then
        self.world_object.body:setLinearVelocity(0, 0)
    end
end

---@return Player
function Player:new()
    local instance = BaseCharacter:new({ sprite = "assets/sprites/player-top.png" })
    instance.sprite_dash = love.graphics.newImage("assets/sprites/player-top-dash.png")
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
    listenKeyboardInputs(self, dt)

    local mouseX, mouseY = camera:getGlobalCoordinates(love.mouse.getPosition())
    local x, y, angle = self.world_object.body:getPosition()

    x, y = validatePosition(self, x, y, map)
    angle = math.atan2(mouseY - y, mouseX - x)

    self.world_object.body:setTransform(x, y, angle)
    self.x, self.y, self.angle = x, y, angle
end

function Player:draw()
    love.graphics.draw(
        self.in_dash and self.sprite_dash or self.sprite,
        self.x,
        self.y,
        self.angle,
        2,
        2,
        self.sprite:getWidth() / 2,
        self.sprite:getHeight() / 2
    )
end

return Player
