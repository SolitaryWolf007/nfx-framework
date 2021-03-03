--==============================================================
-- HEALTH
--==============================================================
function nFXsrv.updateHealth(val)
    local player = nFX.getPlayer(source)
    if player and (val >= 0) then
        player.updateHealth(val)
    end
end
--==============================================================
-- ARMOUR
--==============================================================
function nFXsrv.updateArmour(val)
    local player = nFX.getPlayer(source)
    if player and (val >= 0) then
        player.updateArmour(val)
    end
end
--==============================================================
-- DEAD
--==============================================================
function nFXsrv.setDead(bool,health)
    local player = nFX.getPlayer(source)
    if player then
        player.setDead(bool)
        if health and (health >= 0) then
            player.updateHealth(health)
        end
    end
end
function nFXsrv.onPlayerDead()
    local player = nFX.getPlayer(source)
    if player then
        player.setMoney(0)
        player.resetInventory()
        nFXcli.clearWeapons(source)
    end
end