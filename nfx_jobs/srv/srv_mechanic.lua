--==============================================================
-- EMS
--==============================================================
sMEC = {}
Tunnel.bindInterface("nfx_jobs-mechanic",sMEC)
Proxy.addInterface("nfx_jobs-mechanic",sMEC)
cMEC = Tunnel.getInterface("nfx_jobs-mechanic")
--==============================================================
-- IS MECHANIC
--==============================================================
function sMEC.isMechanic()
    local player = nFX.getPlayer(source)
    if player then
        if player.haveGroupLevel("Mechanic","Novice") then
            return true
        end
    end
end
--==============================================================
-- REPAIR
--==============================================================
RegisterCommand('repair',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
    if player then
        if player.haveAccessLevel("moderator") or player.haveGroupLevel("Mechanic","Novice",true) then
           
            local veh,vnet,model,data,plate,lock,trunk,vCDS = nFXcli.getNearestVehicle(source,3.0,true)	
            nFXcli.LockCommands(source,true)
            nFXcli._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
            TriggerClientEvent("progress",source,20000,Lang["MEC_REPAIRING"].." ("..data.name..")")
            SetTimeout(20000,function()
                nFXcli.LockCommands(source,false)
                TriggerEvent('nFX:SRV:SyncFixVeh',vnet)
                nFXcli._stopAnim(source,false)
            end)

        elseif player.getInventoryItem("repairkit",1) then
            
            local veh,vnet,model,data,plate,lock,trunk,vCDS = nFXcli.getNearestVehicle(source,3.0,true)
            nFXcli.LockCommands(source,true)
            nFXcli._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
            TriggerClientEvent("progress",source,30000,Lang["MEC_REPAIRING"])
            SetTimeout(30000,function()
                nFXcli.LockCommands(source,false)
                TriggerEvent('nFX:SRV:SyncFixVeh',vnet)
                nFXcli._stopAnim(source,false)
            end)
            
        end
    end
end)