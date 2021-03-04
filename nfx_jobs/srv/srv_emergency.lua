--==============================================================
-- EMS
--==============================================================
sEMS = {}
Tunnel.bindInterface("nfx_jobs-ems",sEMS)
Proxy.addInterface("nfx_jobs-ems",sEMS)
cEMS = Tunnel.getInterface("nfx_jobs-ems")
--==============================================================
-- RE
--==============================================================
RegisterCommand('revive',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("EMS","Nurse",true) then
            local nsource = nFXcli.getNearestPlayer(source,2.0)
            if nsource then
                if nFXcli.isDead(nsource) then
                    nFXcli.LockCommands(source,true)
                    nFXcli._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
                    TriggerClientEvent("progress",source,30000,Lang["EMS_RE_RUNNING"])
                    SetTimeout(30000,function()
                        nFXcli.revivePlayer(nsource,100)
                        nFXcli._stopAnim(source,false)
                        nFXcli._LockCommands(source,false)
                        local reward = cfg["emergency"].revive_reward
                        player.giveMoney(math.random(reward.min,reward.max))
                    end)
                else
                    TriggerClientEvent("Notify",source,"info",Lang["EMS_RE_INVALID"])
                end
            end
        end
	end
end)
--==============================================================
-- TREATMENT
--==============================================================
RegisterCommand('treatment',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("EMS","Nurse",true) then
            local nsource = nFXcli.getNearestPlayer(source,2.0)
            if nsource then
                if nFXcli.isDead(nsource) then
                    cEMS._startTreatment(nsource)
                    TriggerClientEvent("Notify",source,"success",Lang["EMS_TREAT_START"],10000)
                end
            end
        end
    end
end)