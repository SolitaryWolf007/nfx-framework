--==============================================================
-- COORDS
--==============================================================
function nFXcli.teleport(x,y,z)
    if x and (not y) and (not y) then
        x,y,z = table.unpack(x)
    end
    SetEntityCoords(PlayerPedId(),x+0.0001,y+0.0001,z+0.0001,1,0,0,1)
end

function nFXcli.getPosition()
    return GetEntityCoords(PlayerPedId())
end
--==============================================================
-- HEADING
--==============================================================
function nFXcli.setHeading(h)
    SetEntityHeading(PlayerPedId(),h)
end

function nFXcli.getHeading()
    return GetEntityHeading(PlayerPedId())
end
--==============================================================
-- BLIPS
--==============================================================
function nFXcli.addBlip(x,y,z,idtype,idcolor,text,scale,route)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,idtype)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip,scale)

	if route then
		SetBlipRoute(blip,true)
	end

	if text then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

function nFXcli.removeBlip(id)
	RemoveBlip(id)
end

function nFXcli.setGPS(x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end