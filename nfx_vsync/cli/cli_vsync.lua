--==============================================================
-- VARS
--==============================================================
local hora = 09
local minuto = 00
local currentweather = "EXTRASUNNY"
local lastWeather = currentweather
--==============================================================
-- UPDATEWEATHER
--==============================================================
RegisterNetEvent("nfx_vsync:updateWeather")
AddEventHandler("nfx_vsync:updateWeather",function(NewWeather)
	currentweather = NewWeather
end)
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
-- PLAYERSPAWNED
--==============================================================
AddEventHandler("nFX:playerSpawned",function()
	TriggerServerEvent("nfx_vsync:requestSync")
end)
--==============================================================
-- SYNCTIMERS
--==============================================================
RegisterNetEvent("nfx_vsync:syncTimers")
AddEventHandler("nfx_vsync:syncTimers",function(timer)
	hora = timer[2]
	minuto = timer[1]
end)
--==============================================================
-- NETWORKCLOCK
--==============================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		NetworkOverrideClockTime(hora,minuto,00)
	end
end)