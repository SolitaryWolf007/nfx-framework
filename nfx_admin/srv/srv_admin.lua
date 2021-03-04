--==============================================================
-- MODULES
--==============================================================
local Tunnel = module("nfx","shared/Tunnel")
local Proxy = module("nfx","shared/Proxy")
nFX = Proxy.getInterface("nFX")
nFXcli = Tunnel.getInterface("nFX")
--==============================================================
-- nFX
--==============================================================
sFX = {}
Tunnel.bindInterface("nfx_admin",sFX)
cFX = Tunnel.getInterface("nfx_admin")
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["main"] = module("nfx_admin","config/admin")
Lang = module("nfx_admin","config/locales/"..cfg["main"].locale)

--===========================================================
-- WHITELIST
--===========================================================
RegisterCommand("wl", function(source,args,rawCMD)
    if args[1] then
        local player = nFX.getPlayer(source)
        if player and player.haveAccessLevel(cfg["main"].cmd_access["wl"]) then
            local license = nFX.prompt(source,Lang["LICENSE"],"")
            nFX.setWhitelisted(license,true)
        end   
    end 
end, false)
RegisterCommand("unwl", function(source,args,rawCMD)
    if args[1] then
        local player = nFX.getPlayer(source)
        if player and player.haveAccessLevel(cfg["main"].cmd_access["wl"]) then
            local license = nFX.prompt(source,Lang["LICENSE"],"")
            nFX.setWhitelisted(license,false)
        end   
    end 
end, false)
--===========================================================
-- BAN
--===========================================================
RegisterCommand("ban", function(source,args,rawCMD)
    if args[1] then
        local player = nFX.getPlayer(source)
        if player and player.haveAccessLevel(cfg["main"].cmd_access["ban"]) then
            local tplayer = nFX.getPlayer(parseInt(args[1]))
            if tplayer then
                local license = tplayer.identifier
                local time = parseInt(nFX.prompt(source,Lang["BAN_PROMPT"],""))
                if time == -1 then
                    nFX.setBanned(license,-1)
                    tplayer.kick("Banned")
                elseif time > 0 then
                    local expires = os.time() + (time*60*60)
                    nFX.setBanned(license,expires)
                    tplayer.kick("Banned")
                elseif time == 0 then
                    nFX.setBanned(license,0)
                end
            end
        end   
    else
        local player = nFX.getPlayer(source)
        if player and player.haveAccessLevel(cfg["main"].cmd_access["ban"]) then
            local license = nFX.prompt(source,Lang["LICENSE"],"")
            local time = parseInt(nFX.prompt(source,Lang["BAN_PROMPT"],""))
            if time == -1 then
                nFX.setBanned(license,-1)
            elseif time > 0 then
                local expires = os.time() + (time*60*60)
                nFX.setBanned(license,expires)
            elseif time == 0 then
                nFX.setBanned(license,0)
            end
        end   
    end 
end, false)
--===========================================================
-- NOCLIP
--===========================================================
RegisterCommand("nc", function(source,args,rawCMD)
    local player = nFX.getPlayer(source)
    if player and player.haveAccessLevel(cfg["main"].cmd_access["nc"]) then
        cFX.Noclip(source)
    end   
end, false)
--===========================================================
-- MONEY
--===========================================================
RegisterCommand("money", function(source,args,rawCMD)
    if args[1] and parseInt(args[1]) > 0 then
        local player = nFX.getPlayer(source)
        if player and player.haveAccessLevel(cfg["main"].cmd_access["money"]) then
            player.giveMoney(parseInt(args[1]))
        end   
    end
end, false)
--===========================================================
-- TPWAY
--===========================================================
RegisterCommand('tpway',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
    if player.haveAccessLevel(cfg["main"].cmd_access["tpway"]) then
        cFX.TpWay(source)
	end
end)
--===========================================================
-- TPCDS
--===========================================================
RegisterCommand('tpcds',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["tpcds"]) then
		local fcoords = nFX.prompt(source,Lang["COORDS_PROMPT"],"")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		nFXcli.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
--===========================================================
-- TPTOME
--===========================================================
RegisterCommand('tptome',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["tptome"]) then
		if args[1] then
			local tplayer = nFX.getPlayer(parseInt(args[1]))
            if tplayer then
                local vec = nFXcli.getPosition(source)
				nFXcli.teleport(tplayer.getSource(),vec)
			end
		end
	end
end)
--===========================================================
-- TPTO
--===========================================================
RegisterCommand('tpto',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["tpto"]) then
		if args[1] then
			local tplayer = nFX.getPlayer(parseInt(args[1]))
            if tplayer then
                local vec = nFXcli.getPosition(tplayer.getSource())
                nFXcli.teleport(source,vec.x,vec.y,vec.z+1.2)
			end
		end
	end
end)
--===========================================================
-- GROUP
--===========================================================
RegisterCommand('setgroup',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["setgroup"]) then
		if args[1] and args[2] and args[3] then
            local tplayer = nFX.getPlayer(parseInt(args[1]))
            if tplayer then
                if tplayer.setGroup(args[2],args[3],true) then
                    TriggerClientEvent("Notify",source,"success", (Lang["GROUP_SET_OK"]):format(args[1],args[2],args[3]) )
                else
                    TriggerClientEvent("Notify",source,"deny",Lang["GROUP_SET_ERR"])
                end
            else
                TriggerClientEvent("Notify",source,"deny", (Lang["PLAYER_NOTFOUND"]):format(args[1]) )
            end
		end
	end
end)
--===========================================================
-- UNGROUP
--===========================================================
RegisterCommand('remgroup',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["remgroup"]) then
		if args[1] and args[2] then
            local tplayer = nFX.getPlayer(parseInt(args[1]))
            if tplayer then
                if tplayer.removeGroup(args[2],true) then
                    TriggerClientEvent("Notify",source,"success", (Lang["GROUP_REM_OK"]):format(args[2],args[1]) )
                else
                    TriggerClientEvent("Notify",source,"deny", (Lang["GROUP_REM_ERR"]):format(args[2]) )
                end
            else
                TriggerClientEvent("Notify",source,"deny",Lang["PLAYER_NOTFOUND"])
            end
		end
	end
end)
--===========================================================
-- VCLOTHES
--===========================================================
local player_customs = {}
RegisterCommand('vclothes',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["vclothes"]) then
        if player_customs[source] then
            player_customs[source] = nil
            nFXcli._removeDiv(source,"customization")
        else 
            local custom = nFXcli.getClothes(source)
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end
            player_customs[source] = true
            nFXcli._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end
end)
--===========================================================
-- WEAPON
--===========================================================
RegisterCommand('weapon',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if args[1] and player.haveAccessLevel(cfg["main"].cmd_access["weapon"]) then
		local ammo = parseInt(args[2])
		if ammo <= 0 then ammo = 200 end
		nFXcli.giveWeapons(source,{[args[1]] = { ammo = ammo }})
	end
end)
--===========================================================
-- CDS
--===========================================================
RegisterCommand('cds',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["cds"]) then
		local vec = nFXcli.getPosition(source)
		nFX.prompt(source,Lang["COORDS_PROMPT"].." 1:","['x'] = "..tD(vec.x)..", ['y'] = "..tD(vec.y)..", ['z'] = "..tD(vec.z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["cds2"]) then
		local vec = nFXcli.getPosition(source)
		nFX.prompt(source,Lang["COORDS_PROMPT"].." 2:","{ ['x'] = "..tD(vec.x)..", ['y'] = "..tD(vec.y)..", ['z'] = "..tD(vec.z).." },")
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["cds3"]) then
		local vec = nFXcli.getPosition(source)
		nFX.prompt(source,Lang["COORDS_PROMPT"].." 3:",tD(vec.x)..","..tD(vec.y)..","..tD(vec.z))
	end
end)

RegisterCommand('cds4',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["cds4"]) then
		local vec = nFXcli.getPosition(source)
		nFX.prompt(source,Lang["COORDS_PROMPT"].." 4:","{x="..tD(vec.x)..", y="..tD(vec.y)..", z="..tD(vec.z).."},")
	end
end)

RegisterCommand('cds5',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["cds5"]) then
		local vec = nFXcli.getPosition(source)
		nFX.prompt(source,Lang["COORDS_PROMPT"].." 5:","{"..tD(vec.x)..", "..tD(vec.y)..", "..tD(vec.z).."},")
	end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
--===========================================================
-- PLAYERS ON
--===========================================================
RegisterCommand('pon',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["pon"]) then
        local players = nFX.getPlayers()
        local osrcs = ""
        local qtd = 0
        for k,v in pairs(players) do
            osrcs = osrcs..k..", "
            qtd = qtd + 1
        end
        TriggerClientEvent('chatMessage',source,Lang["PON_ONLINE"],{255,160,0},qtd)
        TriggerClientEvent('chatMessage',source,Lang["PON_SRCS"],{255,160,0},osrcs)
    end
end)
--===========================================================
-- KICK
--===========================================================
RegisterCommand('kick',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["kick"]) then
		if args[1] then
			local tplayer = nFX.getPlayer(parseInt(args[1]))
            if tplayer then
                local reason = nFX.prompt(source,Lang["KICK_REASON"],"")
				tplayer.kick( (Lang["KICK_MSG"]):format(reason) )
			end
		end
	end
end)
--===========================================================
-- KICK ALL
--===========================================================
RegisterCommand('kickall',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["kickall"]) then
        local players = nFX.getPlayers()
        local reason = nFX.prompt(source,Lang["KICKALL_REASON"],"")
        for k,v in pairs(players) do
            local tplayer = nFX.getPlayer(k)
            if tplayer then
                tplayer.kick( (Lang["KICKALL_MSG"]):format(reason) )
            end
        end
    end
end)
--===========================================================
-- GOD
--===========================================================
RegisterCommand('god',function(source,args,rawCommand)
    local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["god"]) then
		if args[1] then
			local tplayer = nFX.getPlayer(parseInt(args[1]))
			if tplayer then
				nFXcli.revivePlayer(tplayer.getSource())
			end
		else
			nFXcli.revivePlayer(source)
		end
	end
end)
--===========================================================
-- GOD ALL
--===========================================================
RegisterCommand('godall', function(source, args, rawCommand)
    local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["godall"]) then
       
        local players = nFX.getPlayers()
        for k,v in pairs(players) do
            local tplayer = nFX.getPlayer(k)
            if tplayer then
                if tplayer.getDead() then
                    nFXcli.revivePlayer(k)
                else
                    nFXcli.setHealth(k,200)
                end
            end
        end
    end
end)
--===========================================================
-- TUNING
--===========================================================
RegisterCommand('car',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["car"]) and args[1] then
        if nFXcli.spawnVehicle(source,args[1],nFXcli.getPosition(source),nFXcli.getHeading(source),true,player.getRegistration()) then
            TriggerClientEvent("Notify",source,"success", (Lang["CAR_SPAWN_OK"]):format(args[1]) )
        else
            TriggerClientEvent("Notify",source,"error",(Lang["CAR_SPAWN_ERR"]):format(args[1]))
        end
	end
end)
--===========================================================
-- TUNING
--===========================================================
RegisterCommand('tuning',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["tuning"]) then
		cFX.TuningVehicle(source)
	end
end)
--===========================================================
-- HASH VEH
--===========================================================
RegisterCommand('vhash',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["vhash"]) then
		nFX.prompt(source,"VEHICLE HASH:",""..cFX.HashVehicle(source))
	end
end)
--===========================================================
-- VEH INFO
--===========================================================
RegisterCommand('vinfo',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["vinfo"]) then
        local veh,vnet,model,data,plate,lock,trunk,vCDS = nFXcli.getNearestVehicle(source,10.0,true)	
        if veh then   
            local message = (Lang["CAR_VINFOS"]):format(data.name,model,data.hash,plate,data.price)
            TriggerClientEvent("Notify",source,"success",message,12000)
        end
	end
end)
--===========================================================
-- DEL VEH
--===========================================================
RegisterCommand('dv',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
    if player.haveAccessLevel(cfg["main"].cmd_access["dv"]) or player.haveGroupLevel("Police","Official") then
		TriggerClientEvent("nFX:DeleteNearVeh",source)
	end
end)
--===========================================================
-- FIX
--===========================================================
RegisterCommand('fix',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["fix"]) then
		TriggerClientEvent("nFX:RepairNearVeh",source)
	end
end)
--===========================================================
-- HEADING
--===========================================================
RegisterCommand('heading',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["heading"]) then
		nFX.prompt(source, "HEADING:",""..tD(nFXcli.getHeading(source)))
	end
end)
--===========================================================
-- ITEM
--===========================================================
RegisterCommand('item',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["item"]) and args[1] and args[2] then
        local amount = parseInt(args[2])
        if amount > 0 then
            if player.giveInventoryItem(args[1],amount) then
                TriggerClientEvent("Notify",source,"success", (Lang["ITEM_GIVED"]):format(args[1],amount) )
            end
        end
	end
end)
--===========================================================
-- KICK
--===========================================================
RegisterCommand('changename',function(source,args,rawCommand)
	local player = nFX.getPlayer(source)
	if player.haveAccessLevel(cfg["main"].cmd_access["changename"]) then
		if args[1] then
			local tplayer = nFX.getPlayer(parseInt(args[1]))
            if tplayer then
                local name = nFX.prompt(source,Lang["CHANM_NAME"],tplayer.getName())
                if name ~= "" and name ~= " " then
                    tplayer.setName(name)
                end
                local lastname = nFX.prompt(source,Lang["CHANM_LASTNAME"],tplayer.getLastname())
                if lastname ~= "" and lastname ~= " " then
                    tplayer.setLastname(lastname)
                end
			end
		end
	end
end)
--===========================================================
-- ...
--===========================================================
