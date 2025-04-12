---@class GameState
---@field name string
---@field level_name string
---@field is_main_menu boolean
---@field is_paused boolean
---@field is_game_over boolean
---@field is_in_game boolean
GameState = {
    name = nil,
    level_name = nil,

    is_paused = false,
    is_main_menu = true,
    is_game_over = false,
    is_in_game = false,
    reload_state = false,
}

return GameState
