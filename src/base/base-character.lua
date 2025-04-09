local WorldObject = require("src.model.world-object")

---@class BaseCharacter
---@field x number
---@field y number
---@field sprite love.Image
---@field health number
---@field world_object WorldObject
local BaseCharacter = {
    x = 0,
    y = 0,
    sprite = nil,
    health = 100,
    world_object = nil,
}
BaseCharacter.__index = BaseCharacter

function BaseCharacter:new(opts)
    local character = {
        x = opts.x or BaseCharacter.x,
        y = opts.y or BaseCharacter.y,
        sprite = love.graphics.newImage(opts.sprite),
        health = opts.health or BaseCharacter.health,
        world_object = opts.world_object,
    }

    setmetatable(character, self)
    self.__index = self

    return character
end

return BaseCharacter
