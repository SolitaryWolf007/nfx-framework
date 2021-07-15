function nFXsrv.updateWeapons(weapons)
    local player = nFX.getPlayer(source)
    if player and weapons then
        player.updateWeapons(weapons)
    end
end