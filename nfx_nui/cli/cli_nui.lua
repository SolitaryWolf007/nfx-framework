--==============================================================
-- Notify
--==============================================================
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,ms)
	SendNUIMessage({ type = "notify", css = css, mensagem = mensagem, ms = ms or 5000 })
end)
--==============================================================
-- Progress Bar
--==============================================================
RegisterNetEvent("progress")
AddEventHandler("progress",function(time,text)
	SendNUIMessage({ type = "progress", display = true, time = time, text = text })
end)
--==============================================================
-- Interactive Sound
--==============================================================
local default_reinforcement = 0.2

RegisterNetEvent('sounds:source')
AddEventHandler('sounds:source',function(sound,volume)
	SendNUIMessage({ type = "sounds", transactionType = 'playSound', transactionFile = sound, transactionVolume = volume })
end)

RegisterNetEvent('sounds:distance')
AddEventHandler('sounds:distance',function(playerid,maxdistance,sound,volume)
	local distance  = Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerid))))
	if distance <= maxdistance then
		SendNUIMessage({ type = "sounds", transactionType = 'playSound', transactionFile = sound, transactionVolume = volume })
	end
end)

RegisterNetEvent('sounds:fixed')
AddEventHandler('sounds:fixed',function(playerid,x2,y2,z2,maxdistance,sound,volume)
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local distance = GetDistanceBetweenCoords(x2,y2,z2,x,y,z,true)
	if distance <= maxdistance then
		SendNUIMessage({ type = "sounds", transactionType = 'playSound', transactionFile = sound, transactionVolume = volume })
	end
end)

RegisterNetEvent('sounds:variation:vehicle')
AddEventHandler('sounds:variation:vehicle',function(nveh,maxdistance,sound,reinforcement)
	if NetworkDoesNetworkIdExist(nveh) then
		local veh = NetToVeh(nveh)
		if DoesEntityExist(veh) then
			local distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(veh))
			if distance <= maxdistance then
				local vol = (1 - (distance/maxdistance))+(reinforcement or default_reinforcement)
				if vol > 1 then	vol = 1 end		
				SendNUIMessage({ type = "sounds", transactionType = 'playSound', transactionFile = sound, transactionVolume = tonumber(string.format("%.2f",vol)) })
			end
		end
	end
end)

RegisterNetEvent('sounds:variation:fixed')
AddEventHandler('sounds:variation:fixed',function(x,y,z,maxdistance,sound,reinforcement)
	local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))	
	if distance <= maxdistance then
		local vol = (1 - (distance/maxdistance))+(reinforcement or default_reinforcement)
		if vol > 1 then	vol = 1 end	
		SendNUIMessage({ type = "sounds", transactionType = 'playSound', transactionFile = sound, transactionVolume = tonumber(string.format("%.2f",vol)) })
	end
end)