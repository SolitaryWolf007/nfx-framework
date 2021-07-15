--==============================================================
-- VARS
--==============================================================
local hour = 09
local minute = 00
local currentweather = "EXTRASUNNY"
local lastWeather = currentweather
--==============================================================
-- FUNCTIONWEATHER
--==============================================================
Citizen.CreateThread(function()
	while true do
		if lastWeather ~= currentweather then
			lastWeather = currentweather
			SetWeatherTypeOverTime(currentweather,45.0)
			Citizen.Wait(15000)
		end
		ClearOverrideWeather()
		ClearWeatherTypePersist()
		SetWeatherTypePersist(lastWeather)
		SetWeatherTypeNow(lastWeather)
		SetWeatherTypeNowPersist(lastWeather)
		Citizen.Wait(100)
		if lastWeather == "XMAS" then
			SetForceVehicleTrails(true)
			SetForcePedFootstepsTracks(true)
		else
			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
		end
	end
end)
--==============================================================
-- NETWORKCLOCK
--==============================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		NetworkOverrideClockTime(hour,minute,00)
	end
end)
--==============================================================
-- PLAYERSPAWNED
--==============================================================
AddEventHandler("nFX:playerSpawned",function()
	TriggerServerEvent("nfx:weather:requestSync")
end)
--==============================================================
-- UPDATEWEATHER
--==============================================================
RegisterNetEvent("nfx:weather:updateWeather")
AddEventHandler("nfx:weather:updateWeather",function(nweather)
	currentweather = nweather
end)
--==============================================================
-- SYNCTIMERS
--==============================================================
RegisterNetEvent("nfx:weather:syncTimers")
AddEventHandler("nfx:weather:syncTimers",function(timer)
	hour = timer[2]
	minute = timer[1]
end)