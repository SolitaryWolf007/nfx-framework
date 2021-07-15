--==============================================================
-- POLICE
--==============================================================
cPOLICE = {}
Tunnel.bindInterface("nfx_jobs-police",cPOLICE)
Proxy.addInterface("nfx_jobs-police",cPOLICE)
sPOLICE = Tunnel.getInterface("nfx_jobs-police")
--==============================================================
-- CARRY
--==============================================================
local carry_src = nil
local carry_active = false
local carry_running = false
function cPOLICE.ToogleCarry(src)
    other = p1
    carry_active = not carry_active
    if carry_active then
        CarryThread()
    end
end
function CarryThread()
    Citizen.CreateThread(function()
        while carry_active do
            Citizen.Wait(1)
            if carry_src then
                local ped = GetPlayerPed(GetPlayerFromServerId(other))
                Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
                carry_running = true
            else
                if carry_running then
                    DetachEntity(PlayerPedId(),true,false)
                    carry_running = false
                end
            end
        end
    end)
end
RegisterCommand('nfxjobs:policecarry',function()
    sPOLICE.TryToogleCarry()
end, false)
RegisterKeyMapping('nfxjobs:policecarry' , 'Toggle Carry' , 'keyboard' , 'h' )
--==============================================================
-- HANDCUFF
--==============================================================
RegisterCommand('nfxjobs:policecuff',function()
    sPOLICE.TryToogleHandcuff()
end, false)
RegisterKeyMapping('nfxjobs:policecuff' , 'Toggle Handcuff' , 'keyboard' , 'g' )
--==============================================================
-- CONE
--==============================================================
function cPOLICE.ConeManager(remove)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
	local prop = "prop_mp_cone_02"
	local h = GetEntityHeading(PlayerPedId())
	if remove then
        local cone = GetClosestObjectOfType(coord.x,coord.y,coord.z,1.2,GetHashKey(prop),false,false,false)
		if DoesEntityExist(cone) then
			TriggerServerEvent("nFX:SRV:SyncDelObj",ObjToNet(cone))
        end
	else
        local cone = CreateObject(GetHashKey(prop),coord.x,coord.y-0.5,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(cone)
		SetModelAsNoLongerNeeded(cone)
		Citizen.InvokeNative(0xAD738C3085FE7E11,cone,true,true)
		SetEntityHeading(cone,h)
		FreezeEntityPosition(cone,true)
		SetEntityAsNoLongerNeeded(cone)
	end
end
--==============================================================
-- BARRIER
--==============================================================
function cPOLICE.BarrierManager(remove)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.5,-0.94)
	local prop = "prop_mp_barrier_02b"
	local h = GetEntityHeading(PlayerPedId())
	if remove then
        local barrier = GetClosestObjectOfType(coord.x,coord.y,coord.z,3.5,GetHashKey(prop),false,false,false)
		if DoesEntityExist(barrier) then
			TriggerServerEvent("nFX:SRV:SyncDelObj",ObjToNet(barrier))
		end 
	else
        local barrier = CreateObject(GetHashKey(prop),coord.x,coord.y-0.95,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(barrier)
		SetModelAsNoLongerNeeded(barrier)
		Citizen.InvokeNative(0xAD738C3085FE7E11,barrier,true,true)
		SetEntityHeading(barrier,h-180)
		FreezeEntityPosition(barrier,true)
		SetEntityAsNoLongerNeeded(barrier)
	end
end
--==============================================================
-- SHOTS
--==============================================================
local blacklistedWeapons = {
	[GetHashKey("WEAPON_DAGGER")] = true,
	[GetHashKey("WEAPON_BAT")] = true,
	[GetHashKey("WEAPON_BOTTLE")] = true,
	[GetHashKey("WEAPON_CROWBAR")] = true,
	[GetHashKey("WEAPON_FLASHLIGHT")] = true,
	[GetHashKey("WEAPON_GOLFCLUB")] = true,
	[GetHashKey("WEAPON_HAMMER")] = true,
	[GetHashKey("WEAPON_HATCHET")] = true,
	[GetHashKey("WEAPON_KNUCKLE")] = true,
	[GetHashKey("WEAPON_KNIFE")] = true,
	[GetHashKey("WEAPON_MACHETE")] = true,
	[GetHashKey("WEAPON_SWITCHBLADE")] = true,
	[GetHashKey("WEAPON_NIGHTSTICK")] = true,
	[GetHashKey("WEAPON_WRENCH")] = true,
	[GetHashKey("WEAPON_BATTLEAXE")] = true,
	[GetHashKey("WEAPON_POOLCUE")] = true,
	[GetHashKey("WEAPON_STONE_HATCHET")] = true,
	[GetHashKey("WEAPON_STUNGUN")] = true,
	[GetHashKey("WEAPON_FLARE")] = true,
	[GetHashKey("GADGET_PARACHUTE")] = true,
	[GetHashKey("WEAPON_FIREEXTINGUISHER")] = true,
	[GetHashKey("WEAPON_PETROLCAN")] = true
}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if IsPedShooting(ped) then
			if (not blacklistedWeapons[GetSelectedPedWeapon(ped)]) then
                sPOLICE.PlayerShooting()
            end
		end
	end
end)
local blips = {}
function cPOLICE.AddShotBlip(coords,maxdist,origin)
    local ped = PlayerPedId()
    local pCDS = GetEntityCoords(ped)

    local distance = #(pCDS - coords)
	if distance <= maxdist then
		if not DoesBlipExist(blips[origin]) then
			PlaySoundFrontend(-1,"Enter_1st","GTAO_FM_Events_Soundset",false)
			TriggerEvent('chatMessage',Lang["POLICE_SHOT_NUM"],{65,130,255},Lang["POLICE_SHOT_WARN"])
			blips[origin] = AddBlipForCoord(coords.x,coords.y,coords.z)
			SetBlipScale(blips[origin],0.6)
			SetBlipSprite(blips[origin],313)
			SetBlipColour(blips[origin],75)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Lang["POLICE_SHOT_BLIP"])
			EndTextCommandSetBlipName(blips[origin])
			SetBlipAsShortRange(blips[origin],false)
			SetTimeout(30000,function()
				if DoesBlipExist(blips[origin]) then
					RemoveBlip(blips[origin])
				end
			end)
		end
	end
end
--==============================================================
-- PRISON
--==============================================================
local isprisoner = false
function cPOLICE.setPrisoner(status)
	isprisoner = status
	local ped = PlayerPedId()
	if isprisoner then
		SetEntityInvincible(ped,true)
		FreezeEntityPosition(ped,true)
		SetEntityVisible(ped,false,false)
		SetTimeout(5000,function()
			SetEntityInvincible(ped,false)
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true,false)
		end)
		Citizen.CreateThread(function()
			while isprisoner do
				Citizen.Wait(5000)
				local pCDS = GetEntityCoords(ped)
				local distance = #(pCDS - cfg["police"].prison_coords)
				if distance >= cfg["police"].prison_radius then
					SetEntityCoords(PlayerPedId(),cfg["police"].prison_coords)
				end
			end
		end)
	end
end