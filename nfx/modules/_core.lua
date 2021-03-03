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
MySQL.prepare("nFX/getUser","SELECT * FROM users WHERE license = @license")

MySQL.prepare("nFX/getAllUserData","SELECT * FROM users_data WHERE license = @license")
MySQL.prepare("nFX/getUserData","SELECT * FROM users_data WHERE id = @id AND license = @license")

MySQL.prepare("nFX/createUser","INSERT INTO users(license,whitelisted,banned,first_login,access) VALUES(@license,@wl,@bn,@fl,@access)")
MySQL.prepare("nFX/createUserData","INSERT INTO users_data(license,name,lastname,registration,phone,age,money,position,status,groups,inventory,clothes,weapons,userdata) VALUES(@license,@name,@lastname,@reg,@phone,@age,@money,@position,@status,@groups,@inv,@clothes,@weapons,@userdata)")

MySQL.prepare("nFX/setBanned","UPDATE users SET banned = @ban WHERE license = @license")
MySQL.prepare("nFX/setWhitelisted","UPDATE users SET whitelisted = @wl WHERE license = @license")
MySQL.prepare("nFX/setLastLogin","UPDATE users SET ipv4 = @ip, last_login = @ll WHERE license = @license")

MySQL.prepare("nFX/PlayerSave","UPDATE users_data SET name = @name, lastname = @lastname, registration = @reg, phone = @phone, age = @age, money = @money, position = @position, status = @status, groups = @groups, inventory = @inventory, clothes = @clothes, weapons = @weapons, userdata = @userdata WHERE id = @id AND license = @license")
--==============================================================
-- DATA
--==============================================================
nFX.players = {}
--==============================================================
-- CONNECTING
--==============================================================
RegisterServerEvent("nFX:playerConnected")
RegisterServerEvent('nFX:playerSpawned')
RegisterServerEvent('nFX:playerLoaded')
RegisterServerEvent('nFX:playerRespawned')
RegisterServerEvent("nFX:playerDropped")
RegisterServerEvent("nFX:save")

AddEventHandler("playerConnecting",function(name, setKickReason,deferrals)
    local player = source
    deferrals.update(Lang["CONNECTING_GET_LICENSE"])
    
    for _,identifier in pairs(GetPlayerIdentifiers(player)) do
        if string.find(identifier,"license:") then

            deferrals.update(Lang["CONNECTING_GET_USER"])
            local data = MySQL.query("nFX/getUser",{ license = identifier })          
            ::recheck::
            if (not data[1]) then
                MySQL.execute("nFX/createUser",{ license = identifier, wl = cfg["core"].auto_whitelist, bn = 0, fl = os.date(cfg["core"].time_template), access = "citizen" })
                data = MySQL.query("nFX/getUser",{ license = identifier })
                goto recheck
            end
            data = data[1]

            deferrals.update(Lang["CONNECTING_GET_WL"])
            if (data.whitelisted == 1) then
                
                deferrals.update(Lang["CONNECTING_GET_BAN"])
                local banned = nFX.checkIsBanned(identifier)
                if (not banned) then
                    deferrals.update(Lang["CONNECTING_ALL_OK"])
                    TriggerEvent("nFX:playerConnected",player,license)
                    Wait(1000)
                    deferrals.done()
                    MySQL.execute("nFX/setLastLogin",{ license = identifier, ll = os.date(cfg["core"].time_template), ip = nFX.getSourceIpv4(player)  })
                else
                    deferrals.done(Lang["CONNECTING_IS_BAN"].." "..banned)
                end

            else
                deferrals.done(Lang["CONNECTING_NO_WL"].."\n"..identifier)
            end
            break

        end        
    end
end)

AddEventHandler("nFX:playerSpawned",function()
    print("nFX:playerSpawned", source)
end)

AddEventHandler('playerDropped', function (reason)
    local src = source
    local license = nFX.getSourceLicense(src)
    if nFX.players[src] then
        TriggerEvent("nFX:playerDropped",src,license,nFX.players[src].id)
        nFX.PlayerSave(src,nFX.players[src])
        nFX.players[src] = nil
    end
end)

--==============================================================
-- FUNCTIONS - SERVER
--==============================================================

function nFX.getSourceIpv4(src)
    return GetPlayerEP(src) or "0.0.0.0"
end

function nFX.getSourceLicense(src)
    for _,identifier in ipairs(GetPlayerIdentifiers(src)) do
        if string.find(identifier,"license:") then
            return identifier
        end   
    end
end

function nFX.getPlayer(src)
    return nFX.players[src]
end

function nFX.getPlayers()
    local cb = {}
    for src,data in pairs(nFX.players) do
        cb[src] = { identifier = data.identifier, id = data.id }
    end
    return cb
end

function nFX.getSourcesList()
    local cb = {}
    for src,data in pairs(nFX.players) do
        table.insert(cb,src)
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
function nFX.checkIsBanned(id)
    local data = MySQL.query("nFX/getUser",{ license = id })   
    if data[1] then
        if (data[1].banned == -1) then
            return Lang["BANNED_NEVER"]
        elseif( data[1].banned > 0) then
            local unbanh = string.format("%.2f", ((data[1].banned - os.time())/60)/60 )
            if (tonumber(unbanh) <= 0) then
                nFX.setBanned(id,0)
                return false
            else
                return unbanh.." "..Lang["BANNED_HOURS"]
            end
        end
    end
    return false
end

function nFX.setBanned(id,time)
    local data = MySQL.query("nFX/getUser",{ license = id })   
    if data[1] then
        return (MySQL.execute("nFX/setBanned",{ license = id, ban = time }) > 0)
    end
    return false               
end

--==================
-- WHITELIST SYSTEM
--==================
function nFX.checkIsWhitelisted(id)
    local data = MySQL.query("nFX/getUser",{ license = id })   
    if data[1] then
        return (data[1].whitelisted == 1)
    end
    return false
end

function nFX.setWhitelisted(id,bool)
    local data = MySQL.query("nFX/getUser",{ license = id })   
    if data[1] then
        if bool then bool = 1 else bool = 0 end
        return (MySQL.execute("nFX/setWhitelisted",{ license = id, wl = bool }) > 0)
    end
    return false               
end

--==================
-- SAVE
--==================
function _savePlayers()
	SetTimeout(cfg["core"].save_interval*1000, _savePlayers)
	TriggerEvent("nFX:save")
	for k,v in pairs(nFX.players) do
        nFX.PlayerSave(k,v)
	end
end
CreateThread(function()
	_savePlayers()
end)

--==============================================================
-- FUNCTIONS - API
--==============================================================
function nFXsrv.SettingPlayer()
    local src = source
    local license = nFX.getSourceLicense(src)
    if (not license) then
        DropPlayer(src,"GTA:V License Not Found")
        return
    end

    local menu, selected = {}, nil

    local profiles = MySQL.query("nFX/getAllUserData",{ license = license })

    local menu = { name = Lang["LOGIN_PROFILES"] }
    
    menu[Lang["LOGIN_NEW"]] = { 
        function(player, choice, next)
            if (next == 0) then
                local name = nFX.prompt(src,"Name:","")
                local lname = nFX.prompt(src,"LastName:","")
                local age = parseInt(nFX.prompt(src,"Age: (min. 18 | max. 90)",""))
                if (name == "") or (name == " ") or (lname == "") or (lname == " ") then return end
                if (age < 18) then age = 18 elseif (age > 90) then age = 90 end
                local cb = MySQL.query("nFX/createUserData",{ license = license, name = name, lastname = lname, reg = nFX.generateRegistrationNumber(), phone = nFX.generatePhoneNumber(), age = age, money = json.encode({ money = 0, bank = 0 }), position = json.encode(cfg["player"].first_spawn_pos), status = json.encode({ health = cfg["player"].max_player_health, died = false, armour = 0 }), groups = json.encode({}), inv = json.encode({ maxweight = cfg["inventory"].default_weight, inventory = {} }), clothes = json.encode(cfg["player"].default_clothes), weapons = json.encode({ weapons = {}, customs = {} }), userdata = json.encode({}) })
                if cb.insertId then
                    selected = cb.insertId
                    nFX.closeMenu(src)
                end
            end
        end,Lang["LOGIN_NEW_TXT"]
    }

    for i,info in pairs(profiles) do
        menu["ID: "..info.id] = { 
            function(player, choice, next)
                if (next == 0) then
                    selected = info.id
                    nFX.closeMenu(src)
                end
            end,"<b>"..Lang["LOGIN_NAME"].."</b> "..info.name.." "..info.lastname.."<br><b>"..Lang["LOGIN_REG"].."</b> "..info.registration
        }
    end

    menu.onclose = function()
        if (not selected) then
            nFX.openMenu(src,menu)
        end
    end
 
    Wait(5000) -- wait tunnel delay
    nFX.openMenu(src,menu)

    while (not selected) do
        Wait(100)
    end

    local info = MySQL.query("nFX/getUser",{ license = license })
    local data = MySQL.query("nFX/getUserData",{ license = license, id = selected })
    if (not info[1]) or (not data[1]) then
        DropPlayer(src,"nFX profile Not Found")
        return
    end

    data[1].license = info[1].license
    data[1].access = info[1].access

    local player = nFX.PlayerNew(src, data[1])
    nFX.players[src] = player
    nFXcli._SpawnPlayer(src,player)
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
AddEventHandler("nFX:SRV:SyncDelVeh",function(net)
    TriggerClientEvent("nFX:CLI:SyncDelVeh",-1,net)
end)

RegisterServerEvent("nFX:SRV:SyncFixVeh")
AddEventHandler("nFX:SRV:SyncFixVeh",function(net)
    TriggerClientEvent("nFX:CLI:SyncFixVeh",-1,net)
end)