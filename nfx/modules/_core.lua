--==============================================================
-- MODULES
--==============================================================
Tunnel = module("nfx","shared/Tunnel")
Proxy = module("nfx","shared/Proxy")
Tools = module("nfx","shared/Tools")
MySQL = module("nfx","shared/GHMattiMySQL")
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["core"] = module("nfx","config/_core")
cfg["clothingstore"] = module("nfx","config/clothingstore")
cfg["groups"] = module("nfx","config/groups")
cfg["inventory"] = module("nfx","config/inventory")
cfg["player"] = module("nfx","config/player")
cfg["vehicles"] = module("nfx","config/vehicles")
cfg["weapons"] = module("nfx","config/weapons")

Lang = module("nfx","config/locales/"..cfg["core"].locale)
--==============================================================
-- PROXY AND TUNNEL
--==============================================================
nFX = {}
Proxy.addInterface("nFX",nFX)
nFXcli = Tunnel.getInterface("nFX")
-- nFX API server;
nFXsrv = {}
Tunnel.bindInterface("nFX-API",nFXsrv)
--==============================================================
-- MYSQL PREPARES
--==============================================================
MySQL.prepare("nFX/getUser","SELECT * FROM nfx_users WHERE player_id = @player_id")
MySQL.prepare("nFX/getByLicense","SELECT player_id FROM nfx_users_ids WHERE identifier = @identifier")
MySQL.prepare("nFX/insertLicense","INSERT INTO nfx_users_ids(identifier,player_id) VALUES(@identifier,@player_id)")

MySQL.prepare("nFX/getUserData","SELECT * FROM nfx_users_data WHERE player_id = @player_id")

MySQL.prepare("nFX/createUser","INSERT INTO nfx_users(whitelisted,banned,first_login,access) VALUES(@wl,@bn,@fl,@access)")
MySQL.prepare("nFX/createUserData","INSERT INTO nfx_users_data(player_id,name,lastname,registration,phone,age,status,money,bank,position,groups,inventory,clothes,weapons,userdata) VALUES(@player_id,@name,@lastname,@reg,@phone,@age,@status,@money,@bank,@position,@groups,@inv,@clothes,@weapons,@userdata)")

MySQL.prepare("nFX/setBanned","UPDATE nfx_users SET banned = @ban WHERE player_id = @player_id")
MySQL.prepare("nFX/setWhitelisted","UPDATE nfx_users SET whitelisted = @wl WHERE player_id = @player_id")
MySQL.prepare("nFX/setLastLogin","UPDATE nfx_users SET ipv4 = @ip, last_login = @ll WHERE player_id = @player_id")

MySQL.prepare("nFX/PlayerSave","UPDATE nfx_users_data SET name = @name, lastname = @lastname, registration = @reg, phone = @phone, age = @age, status = @status, money = @money, bank = @bank, position = @position, groups = @groups, inventory = @inventory, clothes = @clothes, weapons = @weapons, userdata = @userdata WHERE player_id = @player_id")
--==============================================================
-- DATA
--==============================================================
nFX.players = {}
--==============================================================
-- CONNECTING
--==============================================================
RegisterServerEvent("nFX:playerConnected")
RegisterServerEvent('nFX:playerSpawned')
RegisterServerEvent('nFX:playerRespawned')
RegisterServerEvent("nFX:playerDropped")
RegisterServerEvent("nFX:save")

AddEventHandler("playerConnecting",function(name, setKickReason,deferrals)
    local source = source
    deferrals.update(Lang["CONNECTING_GET_LICENSE"])
    local player_id = nFX.getPlayerByIdentifiers(GetPlayerIdentifiers(source),true)
    if player_id then
        deferrals.update(Lang["CONNECTING_GET_USER"])      
        local data = MySQL.query("nFX/getUser",{ player_id = player_id })[1]          
        deferrals.update(Lang["CONNECTING_GET_WL"])
        if (data.whitelisted == 1) then       
            deferrals.update(Lang["CONNECTING_GET_BAN"])
            local banned = nFX.checkIsBanned(player_id)
            if (not banned) then
                deferrals.update(Lang["CONNECTING_ALL_OK"])
                TriggerEvent("nFX:playerConnected",source,player_id)
                Wait(1000)
                deferrals.done()
                MySQL.execute("nFX/setLastLogin",{ player_id = player_id, ll = os.date(cfg["core"].time_template), ip = nFX.getSourceIpv4(source)  })
            else
                deferrals.done(Lang["CONNECTING_IS_BAN"].." "..banned)
            end
        else
            deferrals.done(Lang["CONNECTING_NO_WL"].."\n"..player_id)
        end
    else
        deferrals.done(Lang["CONNECTING_FATAL"])
    end
end)

AddEventHandler("nFX:playerSpawned",function()
    --print("nFX:playerSpawned", source)
end)

AddEventHandler('playerDropped',function(reason)
    local src = source
    if nFX.players[src] then
        TriggerEvent("nFX:playerDropped",src,nFX.players[src].player_id)
        nFX.PlayerSave(nFX.players[src])
        nFX.players[src] = nil
    end
end)
--==============================================================
-- FUNCTIONS - SERVER
--==============================================================
function nFX.getPlayerByIdentifiers(ids,create)
	if ids and #ids then
		for i=1,#ids do
			if (string.find(ids[i],"ip:") == nil) then
				local rows = MySQL.query("nFX/getByLicense",{ identifier = ids[i] })
				if #rows > 0 then
					return rows[1].player_id
				end
			end
		end
	end
    if create then
        local rows = MySQL.execute("nFX/createUser",{ wl = cfg["core"].auto_whitelist, bn = 0, fl = os.date(cfg["core"].time_template), access = "citizen" })
        local player_id = rows.insertId
        if player_id then     
            for i=1,#ids do
                if (string.find(ids[i],"ip:") == nil) then
                    MySQL.execute("nFX/insertLicense",{ player_id = player_id, identifier = ids[i] })
                end
            end
            return player_id
        end
    end
end

function nFX.getSourceIpv4(src)
    return GetPlayerEP(src) or "0.0.0.0"
end

function nFX.getSourceById(player_id)
    for src,data in pairs(nFX.players) do
        if (data.player_id == player_id) then
            return src
        end
    end
end

function nFX.getPlayer(src)
    return nFX.players[src]
end

function nFX.getPlayerById(player_id)
    for src,data in pairs(nFX.players) do
        if (data.player_id == player_id) then
            return nFX.players[src]
        end
    end
end

function nFX.getPlayers()
    local cb = {}
    for src,data in pairs(nFX.players) do
        cb[src] = data.player_id
    end
    return cb
end

function nFX.generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
    for i=1,#format do
        Wait(1)
		local char = string.sub(format,i,i)
    	if char == "D" then number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
	return number
end
--==================
-- BAN SYSTEM
--==================
function nFX.checkIsBanned(player_id)
    local data = MySQL.query("nFX/getUser",{ player_id = player_id })   
    if data[1] then
        if (data[1].banned == -1) then
            return Lang["BANNED_NEVER"]
        elseif(data[1].banned > 0) then
            local unbanh = string.format("%.2f",((data[1].banned - os.time())/60)/60)
            if (tonumber(unbanh) <= 0) then
                nFX.setBanned(player_id,0)
                return false
            else
                return unbanh.." "..Lang["BANNED_HOURS"]
            end
        end
    end
    return false
end

function nFX.setBanned(player_id,time)
    local data = MySQL.query("nFX/getUser",{ player_id = player_id })   
    if data[1] then
        local rows = MySQL.execute("nFX/setBanned",{ player_id = player_id, ban = time })
        return (rows.affectedRows > 0)
    end
    return false               
end
--==================
-- WHITELIST SYSTEM
--==================
function nFX.checkIsWhitelisted(player_id)
    local data = MySQL.query("nFX/getUser",{ player_id = player_id })   
    if data[1] then
        return (data[1].whitelisted == 1)
    end
    return false
end

function nFX.setWhitelisted(player_id,bool)
    local data = MySQL.query("nFX/getUser",{ player_id = player_id })   
    if data[1] then
        if bool then bool = 1; else bool = 0; end
        local rows = MySQL.execute("nFX/setWhitelisted",{ player_id = player_id, wl = bool })
        return (rows.affectedRows > 0)
    end
    return false               
end
--==============================================================
-- FUNCTIONS - API
--==============================================================
function nFXsrv.SettingPlayer()
    local src = source
    local player_id = nFX.getPlayerByIdentifiers(GetPlayerIdentifiers(src),false)
    if (not player_id) then
        DropPlayer(src,"ID Not Found")
        return
    end
    local info = MySQL.query("nFX/getUser",{ player_id = player_id })[1]  
    if info then
        local profile = MySQL.query("nFX/getUserData",{ player_id = player_id })[1]
        if (not profile) then
            MySQL.execute("nFX/createUserData",{ player_id = player_id, name = cfg["player"].default_name, lastname = cfg["player"].default_lname, reg = nFX.generateRegistrationNumber(), phone = nFX.generatePhoneNumber(), age = cfg["player"].default_age, money = cfg["player"].default_money.money, bank = cfg["player"].default_money.bank, position = json.encode(cfg["player"].first_spawn_pos), status = json.encode({ health = cfg["player"].max_player_health, died = false, armour = 0 }), groups = json.encode({}), inv = json.encode({ maxweight = cfg["inventory"].default_weight, inventory = {} }), clothes = json.encode(cfg["player"].default_clothes), weapons = json.encode({}), userdata = json.encode({}) })
            profile = MySQL.query("nFX/getUserData",{ player_id = player_id })[1]
        end        
        if (not profile) then
            DropPlayer(src,"nFX profile Not Found")
            return
        end   
        profile.access = info.access
        local player = nFX.PlayerNew(src, profile)
        nFX.players[src] = player
        nFXcli._SpawnPlayer(src,player)
    end
end

function nFXsrv.getSourcesList(tb)
    local cb = {}
    for src,data in pairs(nFX.players) do
        table.insert(cb,src)
    end
    return cb
end
--==============================================================
-- SYNC DELETES
--==============================================================
RegisterServerEvent("nFX:SRV:SyncDelObj")
AddEventHandler("nFX:SRV:SyncDelObj",function(net)
    TriggerClientEvent("nFX:CLI:SyncDelObj",-1,net)
end)

RegisterServerEvent("nFX:SRV:SyncDelPed")
AddEventHandler("nFX:SRV:SyncDelPed",function(net)
    TriggerClientEvent("nFX:CLI:SyncDelPed",-1,net)
end)

RegisterServerEvent("nFX:SRV:SyncDelVeh")
RegisterServerEvent("nFX:onVehicleDelete")
AddEventHandler("nFX:SRV:SyncDelVeh",function(net)
    TriggerClientEvent("nFX:CLI:SyncDelVeh",-1,net)
    TriggerEvent("nFX:onVehicleDelete",net)
end)

RegisterServerEvent("nFX:SRV:SyncFixVeh")
AddEventHandler("nFX:SRV:SyncFixVeh",function(net)
    TriggerClientEvent("nFX:CLI:SyncFixVeh",-1,net)
end)