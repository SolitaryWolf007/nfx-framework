--==============================================================
-- ALL VEHICLE ENTITYES
--==============================================================
function nFXcli.getAllVehicles()
	local vehs = {}
	local it, veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
		EndFindVehicle(it)
	return vehs
end
--==============================================================
-- NEAREST VEHICLES
--==============================================================
function nFXcli.getNearestVehicles(radius)
	local r = {}
	local pCDS = nFXcli.getPosition()
	for _,veh in pairs(nFXcli.getAllVehicles()) do
		local vCDS = GetEntityCoords(veh)
		local distance = #(pCDS - vCDS)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end
function nFXcli.getNearestVehicle(radius,withdata)	
	local veh
	local vehs = nFXcli.getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	if IsEntityAVehicle(veh) then
		if withdata then		
			local hash = GetEntityModel(veh)
			local model = cfg["vehicles"].hashes[hash]
			if model then
				if cfg["vehicles"].data[model] then
					local lock = GetVehicleDoorLockStatus(veh)
					local trunk = GetVehicleDoorAngleRatio(v,5)
					local vCDS = GetEntityCoords(veh)
					return veh,VehToNet(veh),model,cfg["vehicles"].data[model],GetVehicleNumberPlateText(veh),lock,trunk,vCDS
				end
			end
		else
			return veh, VehToNet(veh)
		end
	end
end
--==============================================================
-- VEHICLE IN DIRECTION - RAYCAST
--==============================================================
function nFXcli.getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
--==============================================================
-- VEHICLE SPAWN
--==============================================================
function nFXcli.spawnVehicle(model,coords,heading,setin,plate)    
    local mhash = GetHashKey(model)
    local i = 0
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(1)
        i = i+1
        if (i > 30000) then
            return false
        end
    end
    local nveh = CreateVehicle(mhash,coords.x,coords.y,coords.z+0.5,heading,true,true) 
    SetVehicleOnGroundProperly(nveh)
    SetVehicleNumberPlateText(nveh,plate)
    SetEntityAsMissionEntity(nveh,true,true)
    SetVehRadioStation(nveh,"OFF")
    SetModelAsNoLongerNeeded(mhash)
    if setin then
        SetPedIntoVehicle(PlayerPedId(),nveh,-1)
    end

    return true,VehToNet(nveh)
end
--==============================================================
-- PED-VEHICLE FUNCTIONS
--==============================================================
function nFXcli.ejectVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
	end
end

function nFXcli.isInVehicle()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end

function nFXcli.putInNearestVehicle(radius,seat)
	local veh = nFXcli.getNearestVehicle(radius)
	if IsEntityAVehicle(veh) then
		if seat then
			if IsVehicleSeatFree(veh,seat) then
				SetPedIntoVehicle(PlayerPedId(),veh,seat)
				return true
			end
		else
			for i=1,math.max(GetVehicleMaxNumberOfPassengers(veh),3) do
				if IsVehicleSeatFree(veh,i) then
					SetPedIntoVehicle(PlayerPedId(),veh,i)
					return true
				end
			end
		end
	end
	return false
end