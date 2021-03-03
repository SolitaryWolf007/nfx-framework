--==============================================================
-- POLICE
--==============================================================
sPOLICE = {}
Tunnel.bindInterface("nfx_jobs-police",sPOLICE)
Proxy.addInterface("nfx_jobs-police",sPOLICE)
cPOLICE = Tunnel.getInterface("nfx_jobs-police")
--==============================================================
-- CARRY
--==============================================================
function sPOLICE.TryToogleCarry()
    local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("Police","Recruit",true) or player.haveGroupLevel("EMS","Nurse",true) then
            local nsource = nFXcli.getNearestPlayer(source,5.0)
            if nsource then
                cPOLICE.ToogleCarry(nsource,source)
            end
        end
    end
end
--==============================================================
-- HANDCUFF
--==============================================================
function sPOLICE.TryToogleHandcuff()
	local player = nFX.getPlayer(source)
    if player then
        local nsource = nFXcli.getNearestPlayer(source,5.0)
        if nsource then
            if player.getInventoryItemAmount("handcuffs") >= 1 then
                
                if nFXcli.isHandcuffed(nsource) then
                    nFXcli.toggleHandcuff(nsource)
                    TriggerClientEvent("nfx_sound:source",source,'uncuff',0.1)
                    TriggerClientEvent("nfx_sound:source",nsource,'uncuff',0.1)
                else
                    nFXcli._LockCommands(source,true)
                    nFXcli._LockCommands(nsource,true)
                    cPOLICE.ToogleCarry(nsource,source)
                    nFXcli._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
                    nFXcli._playAnim(nsource,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
                    SetTimeout(3500,function()
                        nFXcli._stopAnim(source,false)
                        nFXcli.toggleHandcuff(nsource)
                        cPOLICE.ToogleCarry(nsource,source)
                        nFXcli._LockCommands(source,false)
                        nFXcli._LockCommands(nsource,false)
                        TriggerClientEvent("nfx_sound:source",source,'cuff',0.1)
                        TriggerClientEvent("nfx_sound:source",nsource,'cuff',0.1)
                    end)
                end

            else
                if player.haveAccessLevel("moderator") or player.haveGroupLevel("Police","Recruit",true) then
                    if nFXcli.isHandcuffed(nsource) then
                        nFXcli.toggleHandcuff(nsource)
                        TriggerClientEvent("nfx_sound:source",source,'uncuff',0.1)
                        TriggerClientEvent("nfx_sound:source",nsource,'uncuff',0.1)
                    else
                        nFXcli._LockCommands(source,true)
                        nFXcli._LockCommands(nsource,true)
                        cPOLICE.ToogleCarry(nsource,source)
                        nFXcli._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
                        nFXcli._playAnim(nsource,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
                        SetTimeout(3500,function()
                            nFXcli._stopAnim(source,false)
                            nFXcli.toggleHandcuff(nsource)
                            cPOLICE.ToogleCarry(nsource,source)
                            nFXcli._LockCommands(source,false)
                            nFXcli._LockCommands(nsource,false)
                            TriggerClientEvent("nfx_sound:source",source,'cuff',0.1)
                            TriggerClientEvent("nfx_sound:source",nsource,'cuff',0.1)
                        end)
                    end
                end
            end
        end
    end
end
--==============================================================
-- CONE
--==============================================================
RegisterCommand('cone',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("Police","Recruit",true) then
            cPOLICE.ConeManager(source,(args[1] == "del"))
        end
    end
end)
--==============================================================
-- BARRIER
--==============================================================
RegisterCommand('barrier',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("Police","Recruit",true) then
            cPOLICE.BarrierManager(source,(args[1] ~= "del"))
        end
    end
end)
--==============================================================
-- SHOTS
--==============================================================
function sPOLICE.PlayerShooting()
	local player = nFX.getPlayer(source)
    if player then
		if (not player.haveGroupLevel("Police","Recruit")) then
			local cops = nFX.getPlayersByGroupLevel("Police","Recruit",true)
            local coords = nFXcli.getPosition(source)
            for osrc,dataids in pairs(cops) do
                cPOLICE.AddShotBlip(osrc,coords,3000.00,source)
			end
		end
	end
end
--==============================================================
-- PRISON
--==============================================================
RegisterCommand('prison',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player and player.haveAccessLevel("moderator") or player.haveGroupLevel("Police","Official",true) then
        local tsource = parseInt(args[1])
        local tplayer = nFX.getPlayer(tsource)
        if tplayer then
            local time = parseInt(nFX.prompt(source,"Time",""))
            if time > 0 then
                tplayer.setData("nFX:prison",json.encode(time))
                cPOLICE.setPrisoner(tsource,true)
                nFXcli.setHandcuffed(tsource,false)
                nFXcli.teleport(tsource,cfg["police"].prison_coords)
                prison_lock(tsource)
            end
        end
	end
end)
function prison_lock(src)
    local player = nFX.getPlayer(src)
	if player then
		SetTimeout(60000,function()
            local value = player.getData("nFX:prison")
			local time = json.decode(value) or 0
			if parseInt(time) >= 1 then
                
                TriggerClientEvent("Notify",src,"info", (Lang["POLICE_PRISON_RUNNING"]):format(time) )
                player.setData("nFX:prison",json.encode(parseInt(time)-1))
                prison_lock(src)
                
			elseif parseInt(time) == 0 then      
                
                cPOLICE.setPrisoner(src,false)
				nFXcli.teleport(src,cfg["police"].prison_outside)
				player.setData("nFX:prison",json.encode(-1))
                
                TriggerClientEvent("Notify",src,"info",Lang["POLICE_PRISON_END"])
			end
			nFXcli.PrisionGod(src)
		end)
	end
end
RegisterServerEvent('nFX:playerSpawned')
AddEventHandler("nFX:playerSpawned",function()
    local source = source
    local player = nFX.getPlayer(source)
	if player then
		SetTimeout(5000,function()
			local value = player.getData("nFX:prison")
			local time = json.decode(value) or -1
			if time == -1 then
				return
			end
			if time > 0 then
                cPOLICE.setPrisoner(source,true)
                nFXcli.teleport(source,cfg["police"].prison_coords)
                TriggerClientEvent("Notify",source, (Lang["POLICE_PRISON_RUNNING"]):format(time) )
				prison_lock(source)
			end
		end)
	end
end)
--==============================================================
-- PV --- PUT VEHICLE
--==============================================================
RegisterCommand('pv',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("Police","Recruit",true) then
            local nplayer = nFXcli.getNearestPlayer(source,5.0)
            if nplayer then
                nFXcli.putInNearestVehicle(nplayer,5.0)
            end
        end
    end
end)
--==============================================================
-- RV --- REMOVE VEHICLE
--==============================================================
RegisterCommand('rv',function(source,args,rawCommand)   
    local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("Police","Recruit",true) then
            local nplayer = nFXcli.getNearestPlayer(source,5.0)
            if nplayer then
                nFXcli.ejectVehicle(nplayer)
            end
        end
    end
end)
--==============================================================
-- REG
--==============================================================
RegisterCommand('reg',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("suport") or player.haveGroupLevel("Police","Recruit",true) then
            if args[1] then
                local tsource = parseInt(args[1])
                local tplayer = nFX.getPlayer(tsource)
                if (not tplayer) then
                    TriggerClientEvent("Notify",source,"warn", (Lang["POLICE_REG_NOTFOUND"]):format(tsource) )
                    return
                end
                nFXcli.setDiv(source,"polreg",cfg["police"].regcss,"<center><b>"..Lang["REG_TITLE"].."</b></center><b>Source:</b> "..tsource.."<br><b>"..Lang["PLAYER_NAME"]..":</b> "..tplayer.getName().." "..tplayer.getLastname().."<br><b>"..Lang["PLAYER_AGE"]..":</b> "..tplayer.getAge().."<br><b>"..Lang["PLAYER_REG"]..":</b> "..tplayer.getRegistration().."<br><b>"..Lang["PLAYER_PHONE"]..":</b> "..tplayer.getPhoneNumber().."<br><b>"..Lang["PLAYER_WALLET"]..":</b> $"..tplayer.getMoney())
			    nFX.request(source,"Você deseja fechar o registro geral?",1000)
                nFXcli.removeDiv(source,"polreg")
            else
                local nsource = nFXcli.getNearestPlayer(source,2.0)
                local tplayer = nFX.getPlayer(nsource)
                if tplayer then
                    nFXcli.setDiv(source,"polreg",cfg["police"].regcss,"<center><b>"..Lang["REG_TITLE"].."</b></center><b>Source:</b> "..tplayer.."<br><b>"..Lang["PLAYER_NAME"]..":</b> "..tplayer.getName().." "..tplayer.getLastname().."<br><b>"..Lang["PLAYER_AGE"]..":</b> "..tplayer.getAge().."<br><b>"..Lang["PLAYER_REG"]..":</b> "..tplayer.getRegistration().."<br><b>"..Lang["PLAYER_PHONE"]..":</b> "..tplayer.getPhoneNumber().."<br><b>"..Lang["PLAYER_WALLET"]..":</b> $"..tplayer.getMoney())
                    nFX.request(source,"Você deseja fechar o registro geral?",1000)
                    nFXcli.removeDiv(source,"polreg")
                end
            end
        end
	end
end)