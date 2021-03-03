local config = {}
--======================================================
-- PLAYER
--======================================================
-- default clothes
config.default_clothes = {
    modelhash = 1885233650
}
for i=0,19 do
	config.default_clothes[i] = { 0,0 }
end
-- first spawn
config.first_spawn_pos = { ['x'] = -1037.15, ['y'] = -2736.89, ['z'] = 13.77, ["h"] = 330.33 }
-- max health
config.max_player_health = 200
-- identity
config.reg_format = "DDLLLLDD"
config.phone_format = "DDD-DDD"

return config