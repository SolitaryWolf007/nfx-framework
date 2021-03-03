--==============================================================
-- COORDS
--==============================================================
function nFXsrv.updatePosition(vec,h)
    local player = nFX.getPlayer(source)
    if player and vec then
        player.updatePosition(vec,h)
    end
end