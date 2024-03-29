local config = {}
--======================================================
-- PLAYER
--======================================================
config.default_name = "New"
config.default_lname = "User"
config.default_age = 18

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
-- default player money
config.default_money = { money = 3000, bank = 50000 }
-- identity
config.reg_format = "DDLLLLDD"
config.phone_format = "DDD-DDD"

return config