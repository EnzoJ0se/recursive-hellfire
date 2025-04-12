---@class Camera
---@field x number
---@field y number
---@field width number
---@field height number
---@field zoom number
---@field rotation number
local Camera = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    zoom = 0,
    rotation = 0,
}
Camera.__index = Camera

---@type number
local screenWidth = love.graphics.getWidth()
---@type number
local screenHeight = love.graphics.getHeight()

function Camera:new(opts)
    local camera = {
        x = opts.x or Camera.x,
        y = opts.y or Camera.y,
        width = opts.width or love.graphics.getWidth(),
        height = opts.height or love.graphics.getHeight(),
        zoom = opts.zoom or Camera.zoom,
        rotation = opts.rotation or Camera.rotation,
    }

    setmetatable(camera, self)
    self.__index = self

    return camera
end

---@param x number
---@param y number
function Camera:move(x, y)
    self.x = x
    self.y = y

    -- Left border
    if self.x < screenWidth / 2 then
        self.x = screenWidth / 2
    end
    -- Right border
    if self.y < screenHeight / 2 then
        self.y = screenHeight / 2
    end
    -- Right border
    if self.x > (self.width - screenWidth / 2) then
        self.x = (self.width - screenWidth / 2)
    end
    -- Bottom border
    if self.y > (self.height - screenHeight / 2) then
        self.y = (self.height - screenHeight / 2)
    end
end

---@param callback fun()
function Camera:draw(callback)
    self:start()
    callback()
    self:stop()
end

function Camera:start()
    love.graphics.push()
    love.graphics.translate(
        -math.floor(self.x - love.graphics.getWidth() / 2),
        -math.floor(self.y - love.graphics.getHeight() / 2)
    )
end

function Camera:stop()
    love.graphics.pop()
end

---@param x number
---@param y number
function Camera:getGlobalCoordinates(x, y)
    return (x + self.x - screenWidth / 2), (y + self.y - screenHeight / 2)
end

return Camera
