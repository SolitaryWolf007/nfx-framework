function nFX.PlayerNew(src, data)
    
    local obj = {}

    obj.source      =   src
    obj.player_id   =   data.player_id
    obj.access      =   data.access

    obj.name        =   data.name
    obj.lastname    =   data.lastname
    obj.reg         =   data.registration
    obj.age         =   data.age
    obj.phone       =   data.phone
    obj.pos         =   json.decode(data.position)    
    
    obj.money       =   data.money
    obj.bank        =   data.bank

    local status    =   json.decode(data.status)
    obj.health      =   status.health
    obj.armour      =   status.armour
    obj.died        =   status.died 

    local clothes   =   json.decode(data.clothes)
    if (type(clothes) == "table") then
        obj.clothes =   clothes
    else
        obj.clothes =   cfg["player"].default_clothes
    end

    local weapon    =   json.decode(data.weapons)
    obj.weapons     =   weapon.weapons
    obj.w_customs   =   weapon.customs

    obj.groups      =   json.decode(data.groups)

    obj.invdata     =   json.decode(data.inventory)

    obj.userdata    =   json.decode(data.userdata)
    
    --==============================================================
    -- CORE
    --==============================================================

	obj.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, obj.source, ...)
    end

    obj.CallTunnel = function(tunnelFunc, ...)
        return nFXcli[tunnelFunc](obj.source, ...)
    end

    obj.getPlayerId = function()
		return obj.player_id
    end

    obj.getSource = function()
		return obj.source
    end

    obj.haveAccessLevel = function(level)
        local access = obj.access
        if access == level then
            return true
        else
            local target_lvl = cfg["core"].access_levels[level]
            local player_lvl = cfg["core"].access_levels[access]
            if player_lvl >= target_lvl then
                return true
            end
        end
        return false
    end

    obj.kick = function(reason)
        DropPlayer(obj.source,reason or "")
    end

    obj.setData = function(key,value)
        local data = value
        if (type(key) ~= "string") then return end
        if value and (type(value) ~= "string") then return end
        obj.userdata[key] = value
        return true
    end

    obj.getData = function(key)
        return obj.userdata[key] or ""
    end

    --==============================================================
    -- MAP
    --==============================================================

    obj.updatePosition = function(vec,h) 
        obj.pos.x = shortenNum(vec.x)
        obj.pos.y = shortenNum(vec.y)
        obj.pos.z = shortenNum(vec.z) 
        obj.pos.h = shortenNum(h) 
    end

    --==============================================================
    -- PLAYER
    --==============================================================

    obj.updateClothes = function(tab) 
        obj.clothes = tab
    end
    
    --==============================================================
    -- SURVIVAL
    --==============================================================
    -- HEALTH
    obj.setDead = function(bool) 
        obj.died = bool
    end

    obj.getDead = function() 
        return obj.died
    end

    obj.getHealth = function()
        obj.health = nFXcli.getHealth(obj.source)
        return obj.health
    end

    obj.setHealth = function(val) 
        nFXcli.setHealth(obj.source,val)
        obj.health = parseInt(val)
    end

    obj.updateHealth = function(val) 
        obj.health = parseInt(val)
    end

    -- ARMOUR
    obj.getArmour = function()
        obj.armour = nFXcli.getArmour(obj.source)
        return obj.armour
    end

    obj.setArmour = function(val) 
        nFXcli.setArmour(obj.source,val)
        obj.armour = parseInt(val)
    end

    obj.updateArmour = function(val) 
        obj.armour = parseInt(val)
    end

    --==============================================================
    -- MONEY
    --==============================================================
    -- WALLET
    obj.getMoney = function()
		return obj.money
    end

    obj.setMoney = function(val)
        obj.money = val
    end

    obj.giveMoney = function(val)
        if val >= 0 then
            local money = obj.getMoney()
            obj.setMoney(money+val)
        end
    end

    obj.tryPayment = function(val)
		if val >= 0 then
            local money = obj.getMoney()
            if val >= 0 and money >= val then
                obj.setMoney(money-val)
                return true
            end
        end
        return false
    end

    -- BANK
    obj.getBankMoney = function()
		return obj.bank
    end

    obj.setBankMoney = function(val)
        obj.bank = val	
    end

    obj.giveBankMoney = function(val)
        if val >= 0 then
            local money = obj.getBankMoney()
            obj.setBankMoney(money+val)
        end
    end

    
    obj.tryBankPayment = function(val)
		if val >= 0 then
            local money = obj.getBankMoney()
            if val >= 0 and money >= val then
                obj.setBankMoney(money-val)
                return true
            end
        end
        return false
    end

    -- WITHDRAW
    obj.tryWithdraw = function(val)
        local money = obj.getBankMoney()
        if val >= 0 and money >= val then
            obj.setBankMoney(money-val)
            obj.giveMoney(val)
            return true  
        end
        return false
    end

    -- DEPOSIT
    obj.tryDeposit = function(val)
        if val >= 0 and obj.tryPayment(val) then
            obj.giveBankMoney(val)
            return true
        end
        return false
    end

    -- FULL PAYMENT
    obj.tryFullPayment = function(val)
        if val >= 0 then
            local money = obj.getMoney()
            if money >= val then
                return obj.tryPayment(val)
            else
                if obj.tryWithdraw(val-money) then
                    return obj.tryPayment(val)
                end
            end
        end
        return false
    end

    --==============================================================
    -- IDENTITY 
    --==============================================================
    -- NAME
    obj.getName = function() 
        return obj.name
    end

    obj.setName = function(name)
        if (type(name) == "string") and (string.len(name) >= 2) then
            obj.name = name
            return true
        end
        return false
    end

    -- LASTNAME
    obj.getLastname = function() 
        return obj.lastname
    end

    obj.setLastname = function(lname)
        if (type(lname) == "string") and (string.len(lname) >= 2) then
            obj.lastname = lname
            return true
        end
        return false
    end

    -- AGE
    obj.getAge = function() 
        return obj.age
    end

    obj.setAge = function(age)
        if (type(age) == "number") then
            obj.age = parseInt(age)
            return true
        end
        return false
    end

    -- REGISTRATION
    obj.getRegistration = function() 
        return obj.reg
    end

    obj.setRegistration = function(regist)
        if (type(regist) == "string") and (string.len(regist) >= 2) then
            obj.reg = regist
            return true
        end
        return false
    end

    obj.getPhoneNumber = function() 
        return obj.phone
    end

    obj.setPhoneNumber = function(phon)
        if (type(regist) == "string") then
            obj.phone = phon
            return true
        end
        return false
    end

    --==============================================================
    -- WEAPONS
    --==============================================================

    obj.updateWeapons = function(tab)
        obj.weapons = tab
    end

    --==============================================================
    -- GROUPS
    --==============================================================

    obj.getGroups = function()
        return obj.groups
    end
    
    obj.isInGroup = function(group,activeonly)
        if activeonly then
            return ((obj.groups[group] ~= nil) and obj.groups[group].active)
        else
            return (obj.groups[group] ~= nil)
        end
    end

    obj.isGroupActive = function(group)
        if obj.groups[group] then
            return obj.groups[group].active
        end
        return false
    end
    
    obj.setGroupActive = function(group,actv)
        if obj.groups[group] then
            obj.groups[group].active = (actv == true)
            return true
        end
        return false
    end

    obj.isGroupBusy = function(group)
        if obj.groups[group] then
            return obj.groups[group].busy
        end
        return false
    end
    
    obj.setGroupBusy = function(group,occ)
        if obj.groups[group] then
            obj.groups[group].busy = (occ == true)
            return true
        end
        return false
    end

    obj.haveGroupLevel = function(group,level,activeonly)
        if obj.groups[group] then
            local def = cfg["groups"].groups[group]
            if activeonly and (not obj.groups[group].active) then
                return false
            end
            if def then
                local player_lvl = def[obj.groups[group].level].level
                if def[level] then
                    local target_lvl =  def[level].level
                    if player_lvl >= target_lvl then
                        return true
                    end
                end
            end
        end
        return false
    end

    obj.getGroup = function(group)
        if obj.groups[group] then
            local def = cfg["groups"].groups[group]
            if def then
                local data = def[obj.groups[group].level]
                if data then
                    return { name = obj.groups[group].level, salary = data.salary, level = data.level, active = obj.groups[group].active }
                end
            end
        end
        return nil
    end
    
    obj.setGroup = function(group,level,actv)
        if group and level then
            local def = cfg["groups"].groups[group]
            if def then
                if def[level] then
                    if def._config and def._config.single and def._config.type then
                        for name,data in pairs(obj.groups) do
                            local defg = cfg["groups"].groups[name]
                            if defg then
                                if defg._config and defg._config.type and (defg._config.type == def._config.type) then
                                    obj.removeGroup(name)
                                end
                            else
                                obj.removeGroup(name)
                            end
                        end
                        obj.groups[group] = { level = level, active = actv, busy = false }
                    else
                        obj.groups[group] = { level = level, active = actv, busy = false }
                    end    
                    return true
                end
            end
        end
        return false
    end

    obj.removeGroup = function(group)
        if obj.groups[group] then
            obj.groups[group] = nil
            return true
        end
        return false
    end

    --==============================================================
    -- INVENTORY
    --==============================================================

    obj.getInventoryMaxWeight = function()
        return obj.invdata.maxweight
    end

    obj.varyInventoryMaxWeight = function(var)
        if (type(var) == "number") then
            obj.invdata.maxweight = (obj.invdata.maxweight+var)
            return true
        end
        return false
    end

    obj.setInventoryMaxWeight = function(var)
        if (type(var) == "number") then
            obj.invdata.maxweight = var
            return true
        end
    end

    obj.getInventory = function()
        return obj.invdata.inventory, obj.invdata.maxweight
    end

    obj.resetInventory = function()
        obj.invdata.inventory = {}
        obj.invdata.maxweight = cfg["inventory"].default_weight
    end


    obj.giveInventoryItem = function(item,amount,ignweight)
        local amount = parseInt(amount)
        local inv, maxweight = obj.getInventory()
        local itemdata = nFX.getInvItemData(item)
        if itemdata and (amount > 0) then     
            if (not ignweight) and (maxweight < (nFX.calcInvWeight(inv)+(itemdata.weight*amount))) then
                return false
            end
            if inv[item] then
                inv[item] = inv[item] + amount
                return true
            else
                inv[item] = amount
                return true
            end
        end
        return false
    end

    obj.getInventoryItem = function(item,amount)
        local amount = parseInt(amount)
        local inv, maxweight = obj.getInventory()
        local itemdata = nFX.getInvItemData(item)
        if itemdata and (amount > 0) then
            if inv[item] then
                if inv[item] >= amount then
                    inv[item] = inv[item] - amount
                    if inv[item] <= 0 then
                        inv[item] = nil
                    end
                    return true
                end             
            end
        end
        return false
    end

    obj.getInventoryItemAmount = function(item)
        local inv, maxweight = obj.getInventory()
        if inv[item] then
            return inv[item]     
        end
        return 0
    end

    return obj
end

function nFX.PlayerSave(data)
    if data and data.player_id then 
        local position  =    json.encode(data.pos)
        local status    =    json.encode({ health = data.health, armour = data.armour, died = data.died })
        local clothes   =    json.encode(data.clothes)
        local weapons   =    json.encode(data.weapons)
        local groups    =    json.encode(data.groups)
        local inventory =    json.encode(data.invdata)
        local userdata  =    json.encode(data.userdata)
        MySQL.execute("nFX/PlayerSave",{ player_id = data.player_id, name = data.name, lastname = data.lastname, reg = data.reg, phone = data.phone, age = data.age, money = data.money, bank = data.bank, position = position, status = status, groups = groups, inventory = inventory, clothes = clothes, weapons = weapons, userdata = userdata })
    end
end
--==================
-- SAVE THREAD
--==================
function _savePlayers()
	SetTimeout(cfg["core"].save_interval*1000, _savePlayers)
	TriggerEvent("nFX:save")
	for k,v in pairs(nFX.players) do
        nFX.PlayerSave(v)
	end
end
CreateThread(function()
	_savePlayers()
end)
--==============================================================
-- CLOTHES
--==============================================================

function nFXsrv.updateClothes(tab)
    local player = nFX.getPlayer(source)
    if player and tab then
        player.updateClothes(tab)
    end
end

--==============================================================
-- IDENTITY
--==============================================================

MySQL.prepare("nFX/get_player_reg","SELECT name, lastname, registration, phone, age FROM nfx_users_data WHERE player_id = @player_id")
MySQL.prepare("nFX/get_player_byreg","SELECT player_id FROM nfx_users_data WHERE registration = @reg")
MySQL.prepare("nFX/get_player_phone","SELECT player_id FROM nfx_users_data WHERE phone = @phone")

function nFX.getPlayerIdentity(player_id)
	local rows = MySQL.query("nFX/get_player_reg",{ player_id = player_id })
	if rows[1] then
		return rows[1]
	end
	return nil
end

-- REGISTRATION
function nFX.getPlayerByRegistration(registration)
	local rows = MySQL.query("nFX/get_player_byreg",{ registration = registration or "" })
	if #rows > 0 then
		return rows[1].player_id
	end
end

function nFX.generateRegistrationNumber()
	local id = nil
	local registration = ""
	repeat
		registration = nFX.generateStringNumber(cfg["player"].reg_format)
		id = nFX.getPlayerByRegistration(registration)
	until not id
	return registration
end

-- PHONE
function nFX.getPlayerByPhone(phone)
	local rows = MySQL.query("nFX/get_player_phone",{ phone = phone or "" })
	if #rows > 0 then
		return rows[1].player_id
	end
end

function nFX.generatePhoneNumber()
	local id = nil
	local phone = ""
	repeat
		phone = nFX.generateStringNumber(cfg["player"].phone_format)
		id = nFX.getPlayerByPhone(phone)
	until not id
	return phone
end