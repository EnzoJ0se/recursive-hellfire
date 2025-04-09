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

function Camera:move(x, y)
    self.x = x
    self.y = y

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    -- Left border
    if self.x < w / 2 then self.x = w / 2 end
    -- Right border
    if self.y < h / 2 then self.y = h / 2 end
    -- Right border
    if self.x > (self.width - w / 2) then self.x = (self.width - w / 2) end
    -- Bottom border
    if self.y > (self.height - h / 2) then self.y = (self.height - h / 2) end
end

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

return Camera
