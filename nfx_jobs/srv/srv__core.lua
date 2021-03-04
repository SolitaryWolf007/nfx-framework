--==============================================================
-- MODULES
--==============================================================
Tunnel = module("nfx","shared/Tunnel")
Proxy = module("nfx","shared/Proxy")
Tools = module("nfx","shared/Tools")
MySQL = module("nfx","shared/GHMattiMySQL")
--==============================================================
-- nFX
--==============================================================
nFX = Proxy.getInterface("nFX")
nFXcli = Tunnel.getInterface("nFX")
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["core"] = module("nfx_jobs","config/_core")
cfg["police"] = module("nfx_jobs","config/police")
cfg["emergency"] = module("nfx_jobs","config/emergency")
cfg["player"] = module("nfx","config/player")

Lang = module("nfx_jobs","config/locales/"..cfg["core"].locale)
--==============================================================
-- TOOGLE SERVICES
--==============================================================
RegisterCommand('toogle',function(source,args,rawCMD)
    if args[1] then
        local player = nFX.getPlayer(source)
        if player then
            if player.isInGroup(args[1]) then
                local newstatus = not player.isGroupActive(args[1])
                player.setGroupActive(args[1],newstatus)
                if newstatus then
                    TriggerClientEvent("Notify",source,"success","<b>"..args[1].."</b> | "..Lang["TOGGLE_ENTER"] )
                else
                    player.setGroupBusy(args[1],false)
                    TriggerClientEvent("Notify",source,"success","<b>"..args[1].."</b> | "..Lang["TOGGLE_EXIT"] )
                end
            end
        end
    end
end, false)
--==============================================================
-- TOOGLE BUSY
--==============================================================
RegisterCommand('tbusy',function(source,args,rawCMD)
    if args[1] then
        local player = nFX.getPlayer(source)
        if player then
            if player.isInGroup(args[1]) then
                local newstatus = not player.isGroupBusy(args[1])
                player.setGroupBusy(args[1],newstatus)
                if newstatus then
                    TriggerClientEvent("Notify",source,"success","<b>"..args[1].."</b> | "..Lang["BUSY_ENTER"] )
                else
                    TriggerClientEvent("Notify",source,"success","<b>"..args[1].."</b> | "..Lang["BUSY_EXIT"] )
                end
            end
        end
    end
end, false)
--==============================================================
-- CALL
--==============================================================
local callids = Tools.newIDGenerator()
local cblips = {}
RegisterCommand('call',function(source,args,rawCMD)
    if args[1] then
        local player = nFX.getPlayer(source)
        if player then
            if cfg["core"].call_groups[args[1]] then          
                local desc = nFX.prompt(source,"Descrição:","")
                if desc == "" then
                    return
                end
                local response = false
                local pCDS = nFXcli.getPosition(source)
                local srcids = nFX.getPlayersByGroups(cfg["core"].call_groups[args[1]],true,true)
                for osrc,pid in pairs(srcids) do
                    if osrc ~= source  then
                        async(function()
                            nFXcli.playSound(osrc,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
                            TriggerClientEvent('chatMessage',osrc, (Lang["CALL_TARGET"]):format(string.upper(args[1])) ,{19,197,43}, (Lang["CALL_TARGET_MSG"]):format(player.getName(),player.getLastname(),source,desc) )    
                            local ok = nFX.request(osrc, (Lang["CALL_TARGET_ACCEPT"]):format(player.getName(),player.getLastname()) ,30)
                            if ok then
                                local oplayer = nFX.getPlayer(osrc)
                                if not response and oplayer then
                                    response = true
                                    TriggerClientEvent("Notify",source,"info",(Lang["CALL_ACCEPTED"]):format(oplayer.getName(),oplayer.getLastname()))
                                    nFXcli.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
                                    nFXcli._setGPS(osrc,pCDS.x,pCDS.y)
                                else
                                    TriggerClientEvent("Notify",osrc,"info", Lang["CALL_IS_ACCEPTED"] )
                                    nFXcli.playSound(osrc,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
                                end
                            end
                        end)  
                        local id = callids:gen()
                        cblips[id] = nFXcli.addBlip(osrc,pCDS.x,pCDS.y,pCDS.z,358,71, (Lang["CALL_BLIP"]):format(string.upper(args[1])) ,0.6,false)
                        SetTimeout(300000,function() nFXcli.removeBlip(osrc,cblips[id]) callids:free(id) end)
                    end
                end
            elseif string.lower(args[1]) == "suport" then
                
                local desc = nFX.prompt(source,"Descrição:","")
                if desc == "" then
                    return
                end
                local response = false
                local pCDS = nFXcli.getPosition(source)
                
                local players = nFX.getPlayers()
                for osrc,_ in pairs(players) do
                    if osrc ~= source then
                        local oplayer = nFX.getPlayer(osrc)
                        if oplayer and oplayer.haveAccessLevel("suport") then
                            async(function()
                                nFXcli.playSound(osrc,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
                                TriggerClientEvent('chatMessage',osrc, (Lang["CALL_TARGET"]):format(string.upper(args[1])) ,{19,197,43}, (Lang["CALL_TARGET_MSG"]):format(player.getName(),player.getLastname(),source,desc) )    
                                local ok = nFX.request(osrc, (Lang["CALL_TARGET_ACCEPT"]):format(player.getName(),player.getLastname()) ,30)
                                if ok then
                                    if not response then
                                        response = true
                                        TriggerClientEvent("Notify",source,"info",(Lang["CALL_ACCEPTED"]):format(oplayer.getName(),oplayer.getLastname()))
                                        nFXcli.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
                                        nFXcli._setGPS(osrc,pCDS.x,pCDS.y)
                                    else
                                        TriggerClientEvent("Notify",osrc,"info", Lang["CALL_IS_ACCEPTED"] )
                                        nFXcli.playSound(osrc,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
                                    end
                                end
                            end)  
                            local id = callids:gen()
                            cblips[id] = nFXcli.addBlip(osrc,pCDS.x,pCDS.y,pCDS.z,358,71, (Lang["CALL_BLIP"]):format(string.upper(args[1])) ,0.6,false)
                            SetTimeout(300000,function() nFXcli.removeBlip(osrc,cblips[id]) callids:free(id) end)
                        end
                    end
                end
            end
        end
    end
end, false)
--==============================================================
-- PRESET
--==============================================================
local roupas = {
    ["mec"] = {
        _groups = nil,
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 12,0 },
			[4] = { 39,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 109,0 },
			[8] = { 89,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 66,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 38,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 2,0 },
			[8] = { 56,0 },
			[9] = { 35,0 },
			[10] = { -1,0 },
			[11] = { 59,0 }
		}
	},
	["patient"] = {
        _groups = nil,
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 61,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },			
			[8] = { 15,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 104,0 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 57,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },		
			[8] = { 7,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 105,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["patient2"] = {
        _groups = nil,
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 4,0 },
			[4] = { 84,9 },
			[5] = { -1,0 },
			[6] = { 13,0 },
			[7] = { -1,0 },			
			[8] = { -1,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 186,9 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 10,0 },
			[4] = { 86,9 },
			[5] = { -1,0 },
			[6] = { 12,0 },
			[7] = { 0,0 },		
			[8] = { 8,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 188,9 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
}

RegisterCommand('preset',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.getHealth() > 101 then
		if not nFXcli.isHandcuffed(source) then
            if args[1] then
                
                local custom = roupas[tostring(args[1])]

                if custom then 
                    if custom._groups then
                        for i,gp in pairs(custom._groups) do
                            if player.isInGroup(gp,true) then

                                local old_clothes = nFXcli.getClothes(source)
                                
                                local clothes = player.getData("save_clothes")
                                if (clothes == "") then
                                    player.setData("save_clothes",json.encode(old_clothes))
                                end
                
                                for l,w in pairs(custom[old_clothes.modelhash]) do
                                    old_clothes[l] = w
                                end
                                old_clothes.modelhash = nil
                                
                                nFXcli._playAnim(source,true,{{"clothingshirt","try_shirt_positive_d"}},false)
                                Citizen.Wait(2500)
                                nFXcli._stopAnim(source,true)

                                nFXcli._setClothes(source,old_clothes)

                                break
                            end
                        end
                    else

                        local old_clothes = nFXcli.getClothes(source)
                                
                        local clothes = player.getData("save_clothes")
                        if (clothes == "") then
                            player.setData("save_clothes",json.encode(old_clothes))
                        end

                        for l,w in pairs(custom[old_clothes.modelhash]) do
                            old_clothes[l] = w
                        end
                        old_clothes.modelhash = nil

                        nFXcli._playAnim(source,true,{{"clothingshirt","try_shirt_positive_d"}},false)
                        Citizen.Wait(2500)
                        nFXcli._stopAnim(source,true)

                        nFXcli._setClothes(source,old_clothes)

                    end
                end
            else
                local clothes = player.getData("save_clothes")
                if (clothes ~= "") then
                    nFXcli._playAnim(source,true,{{"clothingshirt","try_shirt_positive_d"}},false)
                    Citizen.Wait(2500)
                    nFXcli._stopAnim(source,true)
                    nFXcli.setClothes(source,json.decode(clothes))
                    player.setData("save_clothes",nil)
                end
            end
		end
	end
end)
--==============================================================
-- ...
--==============================================================