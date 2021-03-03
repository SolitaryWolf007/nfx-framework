function nFXsrv.updateWeapons(weapons,customs)
    local player = nFX.getPlayer(source)
    if player and weapons and customs then
        player.updateWeapons(weapons)
        player.updateWeaponsCustoms(customs)
    end
end