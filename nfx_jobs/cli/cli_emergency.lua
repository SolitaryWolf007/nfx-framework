--==============================================================
-- EMS
--==============================================================
cEMS = {}
Tunnel.bindInterface("nfx_jobs-ems",cEMS)
Proxy.addInterface("nfx_jobs-ems",cEMS)
sEMS = Tunnel.getInterface("nfx_jobs-ems")
--==============================================================
-- TREATMENT
--==============================================================
local intreatment = false
function cEMS.startTreatment()
    local ped = PlayerPedId()
    if intreatment then return end
    intreatment = true
    TriggerEvent("Notify","success",Lang["EMS_TREAT_START_2"],8000)
    repeat
        Citizen.Wait(1000)
        if (not nFXcli.isDead()) then
            SetEntityHealth(ped,GetEntityHealth(ped)+20)
        end
    until (GetEntityHealth(ped) >= cfg["player"].max_player_health) and (GetEntityHealth(ped) > 0)

    TriggerEvent("Notify","success",Lang["EMS_TREAT_END"],8000)
    intreatment = false
end
function cEMS.inTreatment()
    return intreatment
end