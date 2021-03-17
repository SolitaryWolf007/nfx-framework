--==============================================================
-- MODULES
--==============================================================
Tunnel = module("nfx","shared/Tunnel")
Proxy =  module("nfx","shared/Proxy")
Tools = module("nfx","shared/Tools")
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["core"] = module("nfx","config/_core")
cfg["groups"] = module("nfx","config/groups")
cfg["inventory"] = module("nfx","config/inventory")
cfg["player"] = module("nfx","config/player")
cfg["vehicles"] = module("nfx","config/vehicles")
cfg["weapons"] = module("nfx","config/weapons")

Lang = module("nfx","config/locales/"..cfg["core"].locale)
--==============================================================
-- PROXY AND TUNNEL
--==============================================================
nFXcli = {}
Tunnel.bindInterface("nFX",nFXcli)
Proxy.addInterface("nFX",nFXcli)
nFXsrv = Tunnel.getInterface("nFX-API")
--==============================================================
-- CORE
--==============================================================
RegisterNetEvent('nFX:playerSpawned')
RegisterNetEvent('nFX:playerRespawned')

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if NetworkIsPlayerActive(PlayerId()) then
			nFXsrv.SettingPlayer()
			break
		end
	end
end)

local player = {}
function nFXcli.getPlayerDef()
	if nFXcli._ready then
		return player
	end
end

--==============================================================
-- FUNCTIONS
--==============================================================

function nFXcli.ScreenFade(bool,time)
	if bool then
		DoScreenFadeOut(time)
	else
		DoScreenFadeIn(time)
	end
end

function nFXcli.SpawnPlayer(data)
	
	if (not nFXcli._ready) then
		DoScreenFadeOut(500)
		
		while (not IsScreenFadedOut()) do
			Wait(100)
		end

		local custom = data.clothes
		if GetEntityModel(PlayerPedId()) == GetHashKey('PLAYER_ZERO') then
			local hash = custom.modelhash
			RequestModel(hash)

			while not HasModelLoaded(hash) do
				Citizen.Wait(10)
			end

			if IsModelInCdimage(hash) and IsModelValid(hash) then
				SetPlayerModel(PlayerId(), hash)
				SetPedDefaultComponentVariation(PlayerPedId())
			end
			SetModelAsNoLongerNeeded(characterModel)
		end
		
		SetEntityMaxHealth(PlayerPedId(),cfg["player"].max_player_health)
		FreezeEntityPosition(PlayerPedId(), true)

		SetCanAttackFriendly(PlayerPedId(), true, false)
		NetworkSetFriendlyFireOption(true)

		ClearPlayerWantedLevel(PlayerId())
		SetMaxWantedLevel(0)

		local ped = PlayerPedId()
		for k,v in pairs(custom) do
			if k ~= "modelhash" then
				local isprop, index = parse_clothes_part(k)
				if isprop then
					if v[1] < 0 then
						ClearPedProp(ped,index)
					else
						SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
					end
				else
					SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
				end
			end
		end

		FreezeEntityPosition(PlayerPedId(), false)

		nFXcli.teleport(data.pos.x,data.pos.y,data.pos.z)
		nFXcli.setHeading(data.pos.h)

		if data.weapons then
			nFXcli.giveWeapons(data.weapons,true)
		end
		if data.w_customs then
			nFXcli.GiveWeaponsCustomizations(data.w_customs)
		end
		if data.died then
			nFXcli.setHealth(0)
		else
			nFXcli.setHealth(data.health)
			nFXcli.setArmour(data.armour)
		end

		player.source = data.source
		player.player_id = data.player_id
		player.identifier = data.identifier
		player.access = data.access
		player.registration = data.reg
		player.phone = data.phone

		ShutdownLoadingScreen()

		TriggerEvent('nFX:playerSpawned')
		TriggerServerEvent('nFX:playerSpawned')
		nFXcli._ready = true
		Citizen.Wait(4000)
		DoScreenFadeIn(2000)
	end
end
--==============================================================
-- EXIT AND SAVE
--==============================================================
RegisterCommand("exit",function()
	if nFXcli._ready then
		nFXsrv.updateHealth(nFXcli.getHealth())
		nFXsrv.updateArmour(nFXcli.getArmour())
		nFXsrv.updateClothes(nFXcli.getClothes())
		nFXsrv.updatePosition(nFXcli.getPosition(),nFXcli.getHeading())
		local weapons = nFXcli.getWeapons()
		nFXsrv.updateWeapons(weapons,nFXcli.GetWeaponsCustomizations(weapons))
		RestartGame()
	end
end,false)

Citizen.CreateThread(function()
	while true do
		if nFXcli._ready then
			nFXsrv._updateHealth(nFXcli.getHealth())
			nFXsrv._updateArmour(nFXcli.getArmour())
			Citizen.Wait(2500)
			nFXsrv._updateClothes(nFXcli.getClothes())
			Citizen.Wait(2500)
			nFXsrv._updatePosition(nFXcli.getPosition(),nFXcli.getHeading())
			Citizen.Wait(2500)
			local weapons = nFXcli.getWeapons()
			nFXsrv._updateWeapons(weapons,nFXcli.GetWeaponsCustomizations(weapons))
			Citizen.Wait(2500)
		else
			Citizen.Wait(1000)
		end
	end
end)
--==============================================================
-- SYNC DELETES
--==============================================================
RegisterNetEvent("nFX:CLI:SyncDelObj")
AddEventHandler("nFX:CLI:SyncDelObj",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local obj = NetToObj(index)
		if DoesEntityExist(obj) then
			SetEntityAsMissionEntity(obj,false,false)
			SetPedAsNoLongerNeeded(Citizen.PointerValueIntInitialized(obj))
			DeleteObject(obj)
		end
	end
end)

RegisterNetEvent("nFX:CLI:SyncDelPed")
AddEventHandler("nFX:CLI:SyncDelPed",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local ped = NetToPed(index)
		if DoesEntityExist(ped) then
			SetEntityAsMissionEntity(ped,false,false)
			SetPedAsNoLongerNeeded(Citizen.PointerValueIntInitialized(ped))
			DeletePed(ped)
		end
	end
end)

RegisterNetEvent("nFX:CLI:SyncDelVeh")
AddEventHandler("nFX:CLI:SyncDelVeh",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local veh = NetToVeh(index)
		if DoesEntityExist(veh) then
			SetEntityAsMissionEntity(veh,false,false)
			SetVehicleHasBeenOwnedByPlayer(veh,false)
			SetPedAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
			DeleteVehicle(veh)
		end
	end
end)

RegisterNetEvent('nFX:CLI:SyncFixVeh')
AddEventHandler('nFX:CLI:SyncFixVeh',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local veh = NetToVeh(index)	
		if DoesEntityExist(veh) then
			if IsEntityAVehicle(veh) then
				local fuel = GetVehicleFuelLevel(veh)
				SetVehicleFixed(veh)
				SetVehicleDirtLevel(veh,0.0)
				SetVehicleUndriveable(veh,false)
				SetEntityAsMissionEntity(veh,true,true)
				SetVehicleOnGroundProperly(veh)
				SetVehicleFuelLevel(veh,fuel)
			end
		end
	end
end)