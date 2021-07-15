--==============================================================
-- VARS
--==============================================================
local hours = 09
local minutes = 00
local weather = "EXTRASUNNY"

function isAllowedToChange(source)
    if source == 0 then
		return true
	end
	local player = nFX.getPlayer(source)
    if player then
        return player.haveAccessLevel("moderator")
    end
	return false
end
--==============================================================
-- TIMERS
--==============================================================
local timers = {
	["EXTRASUNNY"] = { time = 240 },
	["RAIN"] = { time = 3 },
	["THUNDER"] = { time = 6 },
	["RAIN"] = { time = 6 },
	["BLIZZARD"] = { time = 1 },
	["CLEAR"] = { time = 60 },
}
--==============================================================
-- /weather
--==============================================================
RegisterCommand("weather",function(source,args,rawCommand)
	if isAllowedToChange(source) then
		if args[1] and timers[args[1]] then
			weather = args[1]
			TriggerClientEvent("nfx:weather:updateWeather",-1,weather)
		end
	end
end)
--==============================================================
-- /time
--==============================================================
RegisterCommand("time",function(source,args,rawCommand)
	if isAllowedToChange(source) then
		hours = parseInt(args[1])
		minutes = parseInt(args[2])
		TriggerClientEvent("nfx:weather:syncTimers",-1,{minutes,hours})
	end
end)
--==============================================================
-- REQUESTSYNC
--==============================================================
RegisterServerEvent("nfx:weather:requestSync")
AddEventHandler("nfx:weather:requestSync",function()
	TriggerClientEvent("nfx:weather:updateWeather",-1,weather)
end)
--==============================================================
-- UPDATECLOCK
--==============================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		minutes = minutes + 1
		if minutes >= 60 then
			minutes = 0
			hours = hours + 1
			if hours >= 24 then
				hours = 0
			end
		end
		TriggerClientEvent("nfx:weather:syncTimers",-1,{minutes,hours})
	end
end)
--==============================================================
-- UPDATEWEATHER
--==============================================================
Citizen.CreateThread(function()
	while true do
		for wt,data in pairs(timers) do
			weather = wt
			TriggerClientEvent("nfx:weather:updateWeather",-1,weather)
			Citizen.Wait(data.time*60000)
		end
	end
end)