--==============================================================
-- MODULES
--==============================================================
local Tunnel = module("nfx","shared/Tunnel")
local Proxy = module("nfx","shared/Proxy")
nFXcli = Proxy.getInterface("nFX")
--==============================================================
-- nFX
--==============================================================
cFX = {}
sFX = Tunnel.getInterface("nfx_admin")
Tunnel.bindInterface("nfx_admin",cFX)
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["main"] = module("nfx_admin","config/admin")
Lang = module("nfx_admin","config/locales/"..cfg["main"].locale)


--===========================================================
-- NOCLIP
--===========================================================
local noclip = false
function cFX.Noclip()
	noclip = not noclip
	local ped = PlayerPedId()
	if noclip then
		SetEntityInvincible(ped,true)
		SetEntityVisible(ped,false,false)
		TaskInitNoClipFunc()
	else
		SetEntityInvincible(ped,false)
		SetEntityVisible(ped,true,false)
	end
end

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
        x = x/len
        y = y/len
        z = z/len
    end
    return x,y,z
end

function TaskInitNoClipFunc()
	Citizen.CreateThread(function()
		while noclip do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			local cds = GetEntityCoords(ped)
			local x,y,z = cds.x,cds.y,cds.z
			local dx,dy,dz = getCamDirection()
			local speed = 1.0

			SetEntityVelocity(ped,0.0001,0.0001,0.0001)

			if IsControlPressed(0,21) then
				speed = 5.0
			end

			if IsControlPressed(0,32) then
				x = x+speed*dx
				y = y+speed*dy
				z = z+speed*dz
			end

			if IsControlPressed(0,269) then
				x = x-speed*dx
				y = y-speed*dy
				z = z-speed*dz
			end

			SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		end
	end)
end
--===========================================================
-- TPWAY
--===========================================================
function cFX.TpWay()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		ped = GetVehiclePedIsUsing(ped)
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,0,0,1)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			RequestCollisionAtCoord(x,y,z)
			Citizen.Wait(1)
		end
		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(PlayerPedId(),0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		RequestCollisionAtCoord(x,y,z)
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,0,0,1)
end
--===========================================================
-- TUNING
--===========================================================
function cFX.TuningVehicle()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if (not IsPedInAnyVehicle(ped)) then
		vehicle = nFXcli.getVehicleInDirection(GetEntityCoords(ped),GetOffsetFromEntityInWorldCoords(ped,0.0,10.0,0.0))
	end
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleWheelType(vehicle,7)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
		SetVehicleTyreSmokeColor(vehicle,0,0,127)
		SetVehicleWindowTint(vehicle,1)
		SetVehicleTyresCanBurst(vehicle,false)
		SetVehicleNumberPlateText(vehicle,"NFXFRAME")
		SetVehicleNumberPlateTextIndex(vehicle,5)
		SetVehicleModColor_1(vehicle,4,12,0)
		SetVehicleModColor_2(vehicle,4,12)
		SetVehicleColours(vehicle,12,12)
		SetVehicleExtraColours(vehicle,70,141)
	end
end
--===========================================================
-- HASH VEH
--===========================================================
function cFX.HashVehicle()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if (not IsPedInAnyVehicle(ped)) then
		vehicle = nFXcli.getVehicleInDirection(GetEntityCoords(ped),GetOffsetFromEntityInWorldCoords(ped,0.0,10.0,0.0))
	end
	if IsEntityAVehicle(vehicle) then
		return GetEntityModel(vehicle)
	end
	return 0
end
--===========================================================
-- FIX
--===========================================================	
RegisterNetEvent('nFX:RepairNearVeh')
AddEventHandler('nFX:RepairNearVeh',function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if (not IsPedInAnyVehicle(ped)) then
		vehicle = nFXcli.getVehicleInDirection(GetEntityCoords(ped),GetOffsetFromEntityInWorldCoords(ped,0.0,10.0,0.0))
	end
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("nFX:SRV:SyncFixVeh",VehToNet(vehicle))
	end
end)

--===========================================================
-- DV
--===========================================================	
RegisterNetEvent('nFX:DeleteNearVeh')
AddEventHandler('nFX:DeleteNearVeh',function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if (not IsPedInAnyVehicle(ped)) then
		vehicle = nFXcli.getVehicleInDirection(GetEntityCoords(ped),GetOffsetFromEntityInWorldCoords(ped,0.0,5.0,0.0))
	end
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("nFX:SRV:SyncDelVeh",VehToNet(vehicle))
	end
end)

--===========================================================
-- ...
--===========================================================