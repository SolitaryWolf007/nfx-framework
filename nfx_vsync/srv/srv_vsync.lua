--==============================================================
-- MODULES
--==============================================================
local Tunnel = module("nfx","shared/Tunnel")
local Proxy = module("nfx","shared/Proxy")
--==============================================================
-- nFX
--==============================================================
nFX = Proxy.getInterface("nFX")
nFXcli = Tunnel.getInterface("nFX")
--==============================================================
-- VARS
--==============================================================
local hours = 09
local minutes = 00
local weather = 0

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
	[1] = { "EXTRASUNNY",240 },
	[2] = { "RAIN",12 },
	[3] = { "THUNDER",3 },
	[4] = { "CLEAR",240 },
	[5] = { "SNOW",2 },
	[6] = { "BLIZZARD",1 },
	[7] = { "XMAS",10 },
	[8] = { "SNOW",2 },
}
--==============================================================
-- /weather
--==============================================================
RegisterCommand("weather",function(source,args,rawCommand)
	if isAllowedToChange(source) then
		weather = args[1]
		TriggerClientEvent("nfx_vsync:updateWeather",-1,weather)
	end
end)
--==============================================================
-- /time
--==============================================================
RegisterCommand("time",function(source,args,rawCommand)
	if isAllowedToChange(source) then
		hours = parseInt(args[1])
		minutes = parseInt(args[2])
		TriggerClientEvent("nfx_vsync:syncTimers",-1,{minutes,hours})
	end
end)
--==============================================================
-- REQUESTSYNC
--==============================================================
RegisterServerEvent("nfx_vsync:requestSync")
AddEventHandler("nfx_vsync:requestSync",function()
	TriggerClientEvent("nfx_vsync:updateWeather",-1,timers[weather][1])
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
		TriggerClientEvent("nfx_vsync:syncTimers",-1,{minutes,hours})
	end
end)
--==============================================================
-- UPDATEWEATHER
--==============================================================
Citizen.CreateThread(function()
	while true do
		weather = weather + 1
		if weather > #timers then
			weather = 1
		end
		TriggerClientEvent("nfx_vsync:updateWeather",-1,timers[weather][1])
		Citizen.Wait(timers[weather][2]*60000)
	end
end)