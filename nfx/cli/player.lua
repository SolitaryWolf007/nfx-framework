--==============================================================
-- CLOTHES
--==============================================================
function nFXcli.getDrawables(part)
	local isprop, index = parse_clothes_part(part)
	if isprop then
		return GetNumberOfPedPropDrawableVariations(PlayerPedId(),index)
	else
		return GetNumberOfPedDrawableVariations(PlayerPedId(),index)
	end
end

function nFXcli.getDrawableTextures(part,drawable)
	local isprop, index = parse_clothes_part(part)
	if isprop then
		return GetNumberOfPedPropTextureVariations(PlayerPedId(),index,drawable)
	else
		return GetNumberOfPedTextureVariations(PlayerPedId(),index,drawable)
	end
end

function nFXcli.getClothes()
	local ped = PlayerPedId()
	local custom = {}
	custom.modelhash = GetEntityModel(ped)

	for i = 0,20 do
		custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
	end

	for i = 0,10 do
		custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
	end
	return custom
end

function nFXcli.setClothes(custom)
	local ped = PlayerPedId()
	if custom then
		if custom.modelhash then
			local hash = custom.modelhash
			
			local weapons = nFXcli.getWeapons()
			local health = nFXcli.getHealth()
			local armour = nFXcli.getArmour()

			RequestModel(hash)

			while not HasModelLoaded(hash) do
				Citizen.Wait(10)
			end

			if IsModelInCdimage(hash) and IsModelValid(hash) then
				SetPlayerModel(PlayerId(), hash)
				SetEntityMaxHealth(PlayerPedId(),cfg["player"].max_player_health)
				SetPedDefaultComponentVariation(PlayerPedId())
			end

			nFXcli.giveWeapons(weapons,true)
			nFXcli.setHealth(health)	
			nFXcli.setArmour(armour)
			SetModelAsNoLongerNeeded(characterModel)
			SetCanAttackFriendly(PlayerPedId(), true, false)

		end
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
	end
end

function nFXcli.initClothesShop(clothesdata)
	Citizen.CreateThread(function()
		while true do
			local _wait = 500
			local PED = PlayerPedId()
			local pCDS = GetEntityCoords(PED)
			for k,v in pairs(clothesdata) do
				local dist = #(pCDS - v[2])
				if (dist <= 10) then
					DrawMarker(21,v[2].x,v[2].y,v[2].z-0.2,0,0,0,0.0,0,0,0.4,0.4,0.4,99,47,121,100,1,0,0,1)
					_wait = 1
					if IsControlJustPressed(0,38) and (dist <= 3) then
						nFXsrv.openSkinshop(v[1])
					end
				end
			end
			Citizen.Wait(_wait)
		end
	end)
end
--==============================================================
-- NEAR PLAYERS
--==============================================================
function nFXcli.getNearestPlayers(radius)
	local r = {}
	local spid = GetPlayerServerId(PlayerId())
	
	local pCDS = nFXcli.getPosition()
	local players = nFXsrv.getSourcesList()

	for _,sid in ipairs(players) do
		if sid ~= spid then
			local player = GetPlayerFromServerId(sid)
			if NetworkIsPlayerConnected(player) then
				local oped = GetPlayerPed(player)
				local oCDS = GetEntityCoords(oped,true)
				local distance = #(pCDS - oCDS)
				if distance <= radius then
					r[sid] = distance
				end
			end
		end
	end
	return r
end
function nFXcli.getNearestPlayer(radius)
	local p = nil
	local players = nFXcli.getNearestPlayers(radius)
	local min = radius+0.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end
--==============================================================
-- ANIM
--==============================================================
local anims = {}
local anim_ids = Tools.newIDGenerator()
function nFXcli.LoadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end
function nFXcli.playAnim(upper,seq,looping)
	if seq.task then
		nFXcli.stopAnim(true)

		local ped = PlayerPedId()
		if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local pCDS = nFXcli.getPosition()
			TaskStartScenarioAtPosition(ped,seq.task,pCDS.x,pCDS.y,pCDS.z-1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,seq.task,0,not seq.play_exit)
		end
	else
		nFXcli.stopAnim(upper)
		local flags = 0
		if upper then flags = flags+48 end
		if looping then flags = flags+1 end

		Citizen.CreateThread(function()
			local id = anim_ids:gen()
			anims[id] = true

			for k,v in pairs(seq) do
				local dict = v[1]
				local name = v[2]
				local loops = v[3] or 1

				for i=1,loops do
					if anims[id] then
						local first = (k == 1 and i == 1)
						local last = (k == #seq and i == loops)

						RequestAnimDict(dict)
						local i = 0
						while not HasAnimDictLoaded(dict) and i < 1000 do
						Citizen.Wait(10)
						RequestAnimDict(dict)
						i = i + 1
					end

					if HasAnimDictLoaded(dict) and anims[id] then
						local inspeed = 3.0
						local outspeed = -3.0
						if not first then inspeed = 2.0 end
						if not last then outspeed = 2.0 end

						TaskPlayAnim(PlayerPedId(),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
					end
						Citizen.Wait(1)
						while GetEntityAnimCurrentTime(PlayerPedId(),dict,name) <= 0.95 and IsEntityPlayingAnim(PlayerPedId(),dict,name,3) and anims[id] do
							Citizen.Wait(1)
						end
					end
				end
			end
			anim_ids:free(id)
			anims[id] = nil
		end)
	end
end
function nFXcli.stopAnim(upper)
	anims = {}
	if upper then
		ClearPedSecondaryTask(PlayerPedId())
	else
		ClearPedTasks(PlayerPedId())
	end
end

local animObj_ids = Tools.newIDGenerator()
local animObjs = {}

function nFXcli.playAnimWithObj(dict,anim,prop,flag,hand,pos1,pos2,pos3,pos4,pos5,pos6)
	
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end

	local id = animObj_ids:gen()

	if pos1 then
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		local object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),pos1,pos2,pos3,pos4,pos5,pos6,true,true,false,true,1,true)
		animObjs[id] = object
		return id
	else
		nFXcli.LoadAnimDict(dict)
		TaskPlayAnim(ped,dict,anim,3-.0,3.0,-1,flag,0,0,0,0)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		local object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		animObjs[id] = object
		return id
	end
	Citizen.InvokeNative(0xAD738C3085FE7E11,object,true,true)
end

function nFXcli.DelAnimObject(id)
	if id and animObjs[id] then
		nFXcli.stopAnim(true)
		if DoesEntityExist(object) then
			TriggerServerEvent("nFX:SRV:SyncDelObj",ObjToNet(animObjs[id]))
			animObjs[id] = nil
			animObj_ids:free(id)
		end
	else
		nFXcli.stopAnim(true)
		for idx,obj in ipairs(animObjs) do
			if DoesEntityExist(obj) then
				TriggerServerEvent("nFX:SRV:SyncDelObj",ObjToNet(obj))
				animObjs[idx] = nil
				animObj_ids:free(idx)
			end
		end
	end
end
--==============================================================
-- SOUNDS AND SCREEN
--==============================================================
function nFXcli.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end
function nFXcli.playScreenEffect(name,duration)
	if duration < 0 then
		StartScreenEffect(name,0,true)
	else
		StartScreenEffect(name,0,true)
		Citizen.CreateThread(function()
			Citizen.Wait(math.floor((duration+1)*1000))
			StopScreenEffect(name)
		end)
	end
end
--==============================================================
-- HANDCUFFED
--==============================================================
local handcuffed = false
function nFXcli.toggleHandcuff()
	handcuffed = not handcuffed
	SetEnableHandcuffs(PlayerPedId(),handcuffed)
	if handcuffed then
		nFXcli.playAnim(true,{{"mp_arresting","idle"}},true)	
		LockThread()	
		Citizen.CreateThread(function()
			while handcuffed do
				Citizen.Wait(5000)
				nFXcli.playAnim(true,{{"mp_arresting","idle"}},true)
			end
		end)		
	else
		nFXcli.stopAnim(true)
	end
end
function nFXcli.setHandcuffed(flag)
	if handcuffed ~= flag then
		nFXcli.toggleHandcuff()
	end
end
function nFXcli.isHandcuffed()
	return handcuffed
end
--==============================================================
-- PED HOOD
--==============================================================
local pedhood = false
function nFXcli.togglePedHood()
	pedhood = not pedhood
	if pedhood then
		nFXcli.setDiv("pedhood",".div_pedhood { background: #000; margin: 0; width: 100%; height: 100%; }","")
		SetPedComponentVariation(PlayerPedId(),1,69,2,2)
		LockThread()
	else
		nFXcli.removeDiv("pedhood")
		SetPedComponentVariation(PlayerPedId(),1,0,0,2)
	end
end
function nFXcli.setPedHood(flag)
	if pedhood ~= flag then
		nFXcli.togglePedHood()
	end
end
function nFXcli.isPedHood()
	return pedhood
end
--==============================================================
-- LOOK THREAD
--==============================================================
local LockThreadRunning = false
function LockThread()
	if (not LockThreadRunning) then
		LockThreadRunning = true
		Citizen.CreateThread(function()
			while handcuffed or pedhood do
				BlockWeaponWheelThisFrame()
				DisableControlAction(0,20,true)
				DisableControlAction(0,21,true)
				DisableControlAction(0,22,true)
				DisableControlAction(0,23,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,29,true)
				DisableControlAction(0,32,true)
				DisableControlAction(0,33,true)
				DisableControlAction(0,34,true)
				DisableControlAction(0,35,true)
				DisableControlAction(0,56,true)
				DisableControlAction(0,57,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,73,true)
				DisableControlAction(0,75,true)
				DisableControlAction(0,137,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
				DisableControlAction(0,166,true)
				DisableControlAction(0,167,true)
				DisableControlAction(0,170,true)
				DisableControlAction(0,177,true)
				DisableControlAction(0,178,true)
				DisableControlAction(0,182,true)
				DisableControlAction(0,187,true)
				DisableControlAction(0,188,true)
				DisableControlAction(0,189,true)
				DisableControlAction(0,190,true)
				DisableControlAction(0,243,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,268,true)
				DisableControlAction(0,269,true)
				DisableControlAction(0,270,true)
				DisableControlAction(0,271,true)
				DisableControlAction(0,288,true)
				DisableControlAction(0,289,true)
				DisableControlAction(0,311,true)
				DisableControlAction(0,344,true)	
				Citizen.Wait(1)
			end
			LockThreadRunning = false
		end)
	end
end
--==============================================================
-- BLOCK THREAD
--==============================================================
local blockstatus = false
function nFXcli.LockCommands(bool)
	blockstatus = bool
	if blockstatus then
		BlockThread()
	end
end
function BlockThread()
	Citizen.CreateThread(function()
		while blockstatus do
			Citizen.Wait(1)
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
		end
	end)
end