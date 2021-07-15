--==============================================================
-- VARS
--==============================================================
local default_deathtimer = 30
local deathtimer = default_deathtimer
local isdead = false
local lockstatus = false
--==============================================================
-- HEALTH
--==============================================================
function nFXcli.getHealth()
	return GetEntityHealth(PlayerPedId())
end

function nFXcli.setHealth(health)
	SetEntityHealth(PlayerPedId(),parseInt(health))
end

function nFXcli.isDead()
	return isdead
end

function nFXcli.revivePlayer(health)		
	local ped = PlayerPedId()
	if isdead or IsPedFatallyInjured(ped) then
		local x,y,z = table.unpack(GetEntityCoords(ped))
		NetworkResurrectLocalPlayer(x,y,z,true,true,false)	
		deathtimer = default_deathtimer
	end
	nFXsrv.setDead(false)
	TransitionFromBlurred(1000)
	ClearPedBloodDamage(ped)
	SetEntityHealth(ped,health or cfg["player"].max_player_health)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end

function nFXcli.PrisionGod()
	local ped = PlayerPedId()
	if isdead or IsPedFatallyInjured(ped) then	
		local x,y,z = table.unpack(GetEntityCoords(ped))
		NetworkResurrectLocalPlayer(x,y,z,true,true,false)
		deathtimer = default_deathtimer
		nFXsrv.setDead(false,200)
		TransitionFromBlurred(1000)
		ClearPedBloodDamage(ped)
		SetEntityHealth(ped,cfg["player"].max_player_health)
		ClearPedTasks(ped)
		ClearPedSecondaryTask(ped)
	end
end
--==============================================================
-- ARMOUR
--==============================================================
function nFXcli.getArmour()
	return GetPedArmour(PlayerPedId())
end

function nFXcli.setArmour(armour)
	SetPedArmour(PlayerPedId(),parseInt(armour))
end

--==============================================================
-- THREAD
--==============================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(128)
		local ped = PlayerPedId()
		if IsPedFatallyInjured(ped) and (not isdead) then
			isdead = true
			nFXsrv.setDead(true,0)
			onDeadThread()
		elseif isdead and (not IsPedFatallyInjured(ped)) then
			isdead = false
		end
	end
end)

function onDeadThread()
	Citizen.CreateThread(function()
		while isdead do
			Citizen.Wait(1)
			if deathtimer > 0 then
				drawTxt(0.5,0.4,1.0,1.0,0.80,(Lang["DEATH_TIMER_RUNNING"]):format(deathtimer),255,255,255,150)
			else
				drawTxt(0.5,0.4,1.0,1.0,0.40,Lang["DEATH_TIMEOUT"],255,255,255,150)
				if IsControlJustPressed(0,38) then
					nFXsrv.onPlayerDead()
					deathtimer = default_deathtimer
					local ped = PlayerPedId()
					TransitionFromBlurred(1000)
					ClearPedBloodDamage(ped)
					DoScreenFadeOut(1000)
					SetEntityHealth(ped,cfg["player"].max_player_health)
					Citizen.Wait(1000)
					SetEntityCoords(ped,cfg["player"].first_spawn_pos.x,cfg["player"].first_spawn_pos.y,cfg["player"].first_spawn_pos.z,1,0,0,1)
					TriggerEvent('nFX:playerRespawned')
					TriggerServerEvent('nFX:playerRespawned')
					local x,y,z = table.unpack(GetEntityCoords(ped))
					NetworkResurrectLocalPlayer(x,y,z,true,true,false)
					nFXsrv.setDead(false,cfg["player"].max_player_health)
					FreezeEntityPosition(ped,true)
					SetTimeout(5000,function()
						FreezeEntityPosition(ped,false)
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
					end)
				end
			end
			BlockWeaponWheelThisFrame()
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if isdead and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
	end
end)

--==============================================================
-- OTHER
--==============================================================
function drawTxt(x,y,width,height,scale,text,r,g,b,a)
    SetTextFont(4)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end