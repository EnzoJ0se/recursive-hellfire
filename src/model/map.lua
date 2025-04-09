local sti = require("libraries.sti")

---@class Map
---@field instance sti
---@field width number
---@field height number
---@field path string
---@field layers table
local Map = {
    instance = nil,
    width = 0,
    height = 0,
    path = nil,
    layers = {},
}
Map.__index = Map

---@param path string
---@param layers table
---@return Map
function Map:new(path, layers)
    local map = { path = path, layers = layers }
    map.instance = sti(path, { "box2d" })
    map.width = map.instance.width * map.instance.tilewidth
    map.height = map.instance.width * map.instance.tilewidth

    setmetatable(map, self)
    self.__index = self

    return map
end

---@param self Map
---@param dt number
function Map:update(dt)
    self.instance:update(dt)
end

function Map:draw()
    for _, layer in ipairs(self.layers) do
        self.instance:drawLayer(self.instance.layers[layer])
    end
end

return Map
