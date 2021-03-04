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
-- ...
--==============================================================