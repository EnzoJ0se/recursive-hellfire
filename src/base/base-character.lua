local WorldObject = require("src.model.world-object")

---@class BaseCharacter
---@field x number
---@field y number
---@field angle number
---@field width number
---@field height number
---@field sprite love.Image
---@field health number
---@field world_object WorldObject
local BaseCharacter = {
    x = 0,
    y = 0,
    angle = 0,
    width = 0,
    height = 0,
    sprite = nil,
    health = 100,
    world_object = nil,
}
BaseCharacter.__index = BaseCharacter

---@param opts table
function BaseCharacter:new(opts)
    local character = {
        x = opts.x or BaseCharacter.x,
        y = opts.y or BaseCharacter.y,
        width = opts.width or BaseCharacter.width,
        height = opts.height or BaseCharacter.height,
        sprite = love.graphics.newImage(opts.sprite),
        health = opts.health or BaseCharacter.health,
        world_object = opts.world_object,
    }

    setmetatable(character, self)
    self.__index = self

    return character
end

return BaseCharacter
