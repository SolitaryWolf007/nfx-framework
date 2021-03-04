# nFX Documentation.

nFX It is a framework for fivem that I started to develop with free time, therefore, many things can still change. Here is the list of functions and events and how to use them.

## Client Events

```lua
    -- called on the player's first spawn.
    AddEventHandler("nFX:playerSpawned",function() end)
    
    -- called when the player respawns.
    AddEventHandler("nFX:playerRespawned",function() end)
```

## Server Events

```lua
    -- called when the player is readable to connect to the server. (S->S)
    AddEventHandler("nFX:playerConnected",function(source,license) end)

    -- called on the player's first spawn. (C->S)
    AddEventHandler("nFX:playerSpawned",function() end)

    -- called when the player respawns. (C->S)
    AddEventHandler("nFX:playerRespawned",function() end)

    -- called when the player disconnects from the server. (S->S)
    AddEventHandler("nFX:playerDropped",function(source,license,id) end)

    -- called when the data will be saved. (S->S)
    AddEventHandler("nFX:save",function() end)

    -- call this event to delete an object synchronously.
    -- netobj: ObjToNet(object--[[entity]])
    TriggerEvent("nFX:SRV:SyncDelObj",netobj)
    TriggerServerEvent("nFX:SRV:SyncDelObj",netobj)
    
    -- call this event to delete a ped synchronously,
    -- netped: PedToNet(object--[[entity]])
    TriggerEvent("nFX:SRV:SyncDelPed",netped)
    TriggerServerEvent("nFX:SRV:SyncDelPed",netped)

    -- call this event to delete a vehicle synchronously.
    -- netveh: VehToNet(vehicle--[[entity]])
    TriggerEvent("nFX:SRV:SyncDelVeh",netveh)
    TriggerServerEvent("nFX:SRV:SyncDelVeh",netveh)

    -- call this event to fix a vehicle synchronously.
    -- netveh: VehToNet(vehicle--[[entity]])
    TriggerEvent("nFX:SRV:SyncFixVeh",netveh)
    TriggerServerEvent("nFX:SRV:SyncFixVeh",netveh)
```

## Client Functions

### _core.lua
```lua
    -- returns a table with player definitions.
    --{ source, id, identifier, access, registration, phone }
    nFXcli.getPlayerDef()
    
    -- triggers the ScreenFade effect.
    -- bool: true(out)/false(in)
    -- time: integer (ms)
    nFXcli.ScreenFade(bool,time)
    
    -- function that spawns the player with the data, used internally by nFX.
    -- should not be used by other scripts.
    nFXcli.SpawnPlayer(data)
```
### gui.lua
```lua
    -- closes the open menu.
    nFXcli.closeMenu()
    
    -- returns a table about the status of the menu.
    --{ opened, name }
    nFXcli.getMenuState()
    
    -- set a div
    -- css: plain global css, the div class is ".div_nameofthediv"
    -- content: html content of the div
    nFXcli.setDiv(name,css,content)

    -- set the div content
    nFXcli.setDivContent(name,content)
    
    -- remove the div
    nFXcli.removeDiv(name)
```
### map.lua
```lua
    -- teleport player.
    -- x: positionX/vector
    -- y: positionY/nil
    -- z: positionZ/nil
    nFXcli.teleport(x,y,z)
    nFXcli.teleport(vector3(x,y,z))
    
    -- returns a position vector.
    nFXcli.getPosition()
    
    -- set the player's heading.
    -- h: heading
    nFXcli.setHeading(h)
    
    -- returns the player's heading
    nFXcli.getHeading()
    
    -- add a blip to the map, return the blip ID
    nFXcli.addBlip(x,y,z,idtype,idcolor,text,scale,route)
    
    -- removes a blip by ID.
    -- id: Blip ID
    nFXcli.removeBlip(id)
    
    -- marks a point on the GPS
    -- x: positionX
    -- y: positionY
    nFXcli.setGPS(x,y)
```
### player.lua
```lua
    -- Total of drawables, return number of drawables.
    -- part: part
    nFXcli.getDrawables(part)
    
    -- Drawable textures, return number of textures.
    -- part: part
    -- drawable: drawable
    nFXcli.getDrawableTextures(part,drawable)
    
    -- returns table with data of the player's clothes.
    nFXcli.getClothes()
    
    -- set player clothes.
    -- custom: table of customs
    nFXcli.setClothes(custom)
    
    -- returns a table with the next players. (player -> radius)
    -- radius: integer
    nFXcli.getNearestPlayers(radius)
    
    -- returns the source of the next player.
    -- radius: integer
    nFXcli.getNearestPlayer(radius)
     
    -- play animation.
    -- animations dict/name: see http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm
    -- upper: true, only upper body, false, full animation
    -- seq: list of animations as {dict,anim_name,loops} (loops is the number of loops, default 1)
    -- looping: if true, will infinitely loop the first element of the sequence until stopAnim is called
    nFXcli.playAnim(upper, seq, looping)
    
    -- stop animation.
    -- upper: true, stop the upper animation, false, stop full animations
    nFXcli.stopAnim(upper)
    
    -- player animation with object.
    -- return anim id (use in next function)
    nFXcli.playAnimWithObj(dict,anim,prop,flag,hand,pos1,pos2,pos3,pos4,pos5,pos6)
    
    -- delete the animation object.
    -- id: integer
    nFXcli.DelAnimObject(id)
    
    -- play sound.
    nFXcli.playSound(dict,name)
    
    -- play a screen effect.
    -- name, see https://wiki.fivem.net/wiki/Screen_Effects
    -- duration: in seconds, if -1, will play until stopScreenEffect is called
    nFXcli.playScreenEffect(name, duration)
    
    -- toggle Handcuff.
    nFXcli.toggleHandcuff()
    
    -- set Handcuff status.
    -- flag: bool
    nFXcli.setHandcuffed(flag)
    
    -- return handcuff status, true or false.
    nFXcli.isHandcuffed()
    
    -- toogle the hood on the player.
    nFXcli.togglePedHood()
    
    -- set Ped Hood status.
    -- flag: bool
    nFXcli.setPedHood(flag)
    
    -- return ped hood status, true or false.
    nFXcli.isPedHood()
    
    -- blocks some player keys.
    -- bool: true or false
    nFXcli.LockCommands(bool)
```
### survival.lua
```lua
    -- return the player health.
    nFXcli.getHealth()
    
    -- set player health.
    -- health: integer
    nFXcli.setHealth(health)
    
    -- returns if the player is dead.
    nFXcli.isDead()
    
    -- revive player, and set health.
    -- health: integer, or nil
    nFXcli.revivePlayer(health)
    
    -- revive player, used in the prison.
    nFXcli.PrisionGod()
    
    -- return the player armour.
    nFXcli.getArmour()
    
    -- set player armour.
    -- armour: integer
    nFXcli.setArmour(armour)
```
### vehicles.lua
```lua
    -- return table with vehicles loaded in the world.
    nFXcli.getAllVehicles()
    
    -- returns a table with the vehicles nearby. (vehicle->dist)
    nFXcli.getNearestVehicles(radius)
    
    -- returns the vehicle, or vehicle withdata.
    -- return veh,vehnet or veh,vehnet,model,data,plate,lock,trunk,coords
    -- radius: integer 
    -- withdata: bool
    nFXcli.getNearestVehicle(radius,withdata)
    
    -- returns the vehicle between two coordinates
    -- coordsfrom: vector3
    -- coordsto: vector3
    nFXcli.getVehicleInDirection(coordsfrom,coordsto)
    
    -- spawn a vehicle.
    -- model: model
    -- coords: vector3
    -- heading: integer
    -- setin: bool, inside veh
    -- plate: string
    nFXcli.spawnVehicle(model,coords,heading,setin,plate) 
    
    -- ejects the player from the vehicle.
    nFXcli.ejectVehicle()
    
    -- returns if the player is inside a vehicle.
    nFXcli.isInVehicle()
    
    -- put player in the next vehicle.
    -- radius: integer
    -- seat: integer/nil
    nFXcli.putInNearestVehicle(radius,seat)
```
### weapons.lua
```lua
    -- returns a table with the weapons obtained through the nFX methods.
    nFXcli.getWeaponsGived()
    
    -- checks if the weapons in weapon are the same as those given by nFX.
    -- weapon: table
    nFXcli.legalWeaponsChecker(weapon)
    
    -- returns a table with the player's weapons.
    nFXcli.getWeapons()
    
    -- replaces the player's weapons. and returns the old weapons.
    -- weapons: table
    nFXcli.replaceWeapons(weapons)
    
    -- give the player a weapon.
    -- weapons: table
    -- clear_before: bool - if true, clear before.
    nFXcli.giveWeapons(weapons,clear_before)
    
    -- removes all weapons from the player.
    nFXcli.clearWeapons()
    
    -- applies weapon customization to the player.
    -- customs: table
    nFXcli.GiveWeaponsCustomizations(customs)
    
    -- get the weapons customizations.
    -- weap: table
    nFXcli.GetWeaponsCustomizations(weap)
    
    -- seeks the components of a weapon.
    -- weapon: string/weapon
    nFXcli.GetWeaponComponents(weapon)
```

## Server Functions

### _core.lua
```lua
    -- returns the source's IP address.
    -- source: source
    nFX.getSourceIpv4(source)

    -- returns the license of the source.
    -- source: source
    nFX.getSourceLicense(source)

    -- returns the player's object, through the source.
    -- source: source
    nFX.getPlayer(source)

    -- returns a table with all players, indexed by source, with license and player id.
    nFX.getPlayers()

    -- returns a table containing the players' source.
    nFX.getSourcesList()

    -- returns a generated string.
    -- format: string (D: Number, L: Letter)
    nFX.generateStringNumber(format)

    -- returns if the license is banned.
    -- license: license
    nFX.checkIsBanned(license)

    -- set license as banned.
    -- license: license
    -- time: os.time() + seconds of ban. or -1
    nFX.setBanned(license,time)

    -- returns if the license is whitelisted.
    -- license: license
    nFX.checkIsWhitelisted(license)

    -- set license as banned.
    -- license: license
    -- bool: true, whitelisted, false, not whitelisted
    nFX.setWhitelisted(license,bool)    
```
### groups.lua
```lua
    -- returns a table with source and character id with group.
    -- group: groupname
    -- level: levelname
    -- activeonly: bool, only active players
    -- notbusy: bool, only not busy players
    nFX.getPlayersByGroupLevel(group,level,activeonly,notbusy)

    -- returns a table with source and character id with group.
    -- group: groupname
    -- activeonly: bool, only active players
    -- notbusy: bool, only not busy players
    nFX.getPlayersByGroup(group,activeonly,notbusy)

    -- returns a table with source and character id with groups.
    -- groups: table ({ "FireDepartment", { name = "EMS", level = "Paramedic" } })
    -- activeonly: bool, only active players
    -- notbusy: bool, only not busy players
    nFX.getPlayersByGroups(groups,activeonly,notbusy)
```
### gui.lua
```lua
    -- opens the menu with settings.
    -- source: source
    -- menudef: table with definitions
    nFX.openMenu(source,menudef)

    -- close an active menu.
    -- source: source
    nFX.closeMenu(source)

    -- returns the input string when the menu is closed.
    -- source: source
    -- title: string
    -- default_text: string
    nFX.prompt(source,title,default_text)

    -- returns a boolean when the request is completed.
    -- source: source
    -- text: string
    -- time: integer/seconds
    nFX.request(source,text,time)
```
### inventory.lua
```lua
    -- register an item in the table.
    -- itemid: string/item id
    -- name: string/item name
    -- index: string/item index
    -- weight: float/item weight
    -- type: string/item type
    nFX.registerInvItem(itemid,name,index,weight,type)

    -- unregister an item in the table.
    -- itemid: string/item id
    nFX.unregisterInvItem(itemid)

    -- calculates the total weight of the inventory
    -- inv: invetory table
    nFX.calcInvWeight(inv)

    -- returns a table with all items.
    nFX.getInvItems()

    -- returns the name of the item.
    -- itemid: string/item id
    nFX.getInvItemName(itemid)

    -- returns the index of the item.
    -- itemid: string/item id
    nFX.getInvItemIndex(itemid)

    -- returns the type of the item.
    -- itemid: string/item id
    nFX.getInvItemType(itemid)

    -- returns the weight of the item.
    -- itemid: string/item id
    nFX.getInvItemWeight(itemid)

    -- returns the table of the item.
    -- itemid: string/item id
    nFX.getInvItemData(itemid)

    -- returns the size of the trunk.
    -- model: vehicle/model
    nFX.getTrunkWight(model)
```
### player.lua
```lua
    -- returns a data table with identity data.
    --{ name, lastname, registration, phone, age }
    -- id: character id
    nFX.getPlayerIdentity(id)

    -- returns the character id and the license through the registration
    -- registration: string
    nFX.getPlayerByRegistration(registration)

    -- returns a string from an RG not saved in the database.
    nFX.generateRegistrationNumber()

    -- returns the character id and the license through the phone
    -- phone: string
    nFX.getPlayerByPhone(phone)

    -- returns a string from a phone number not saved in the database.
    nFX.generatePhoneNumber()
```
### Player Object
Through the player's object, it is possible to do all the management of it, here is the list of functions of the object.
```lua
    local player = nFX.getPlayer(source)

    -- calls an event on the client, with parameters.
    -- eventname: name of event
    -- ...: args
    player.triggerEvent(eventname,...)

    -- calls a function on the client, with parameters.
    -- funcname: name of function
    -- ...: args
    player.CallTunnel(funcname,...)

    -- returns the character id
    player.getDataId()

    -- returns the player's source.
    player.getSource()

    -- returns the player's license.
    player.getLicense()

    -- returns if the player has indicated access level.
    -- level: nameoflevel
    player.haveAccessLevel(level)

    -- kicks the player from the server, and may pass reason.
    -- reason: string
    player.kick(reason)

    -- set on the server if the player is dead, it is not recommended to use this.
    -- isdead: bool
    player.setDead(isdead)

    -- returns if the player is dead.
    player.getDead()

    -- returns the player's health.
    player.getHealth()

    -- set the player's health.
    -- val: integer
    player.setHealth(val)

    -- returns the player's armour.
    player.getArmour()

    -- set the player's armour.
    -- val: integer
    player.setArmour(val)

    ...

```
## Shared ( created by [ImagicTheCat](https://github.com/ImagicTheCat/vRP/tree/1.0) )

### utils

```lua
-- load a lua resource file as module
-- rsc: resource name
-- path: lua file path without extension
module(rsc, path)

-- create an async returner (require a Citizen thread) (also alias for Citizen.CreateThreadNow)
-- return returner (r:wait(), r(...))
async()

-- CLIENT and SERVER globals
-- booleans to known the side of the script
----
```
WARNING: Any function making usage of `async()` require a Citizen thread if not already in one. Citizen will throw an error if you're not in one.

### Proxy

The proxy lib is used to call other resources functions through a proxy event.

* resource1.lua

```lua
----
local Proxy = module("nfx", "shared/Proxy")

Resource1 = {}
Proxy.addInterface("resource1",Resource1) -- add functions to resource1 interface (can be called multiple times if multiple files declare different functions for the same interface)

function Resource1.test(a,b)
  print("resource1 TEST "..a..","..b)
  return a+b,a*b -- return two values
end
----
```

* resource2.lua

```lua
----
local Proxy = module("nfx", "shared/Proxy")

Resource1 = Proxy.getInterface("resource1")

local rvalue1, rvalue2 = Resource1.test(13,42)
print("resource2 TEST rvalues = "..rvalue1..","..rvalue2)
----
```

The notation is `Interface.function(...)`.

OBS: Good practice is to get the interface once and set it as a global, but if you want to get multiple times the same interface from the same resource, you need to specify a unique identifier (the name of the resource + a unique id for each one). 

### Tunnel

The idea behind tunnels is to easily access any declared server function from any client resource, and to access any declared client function from any server resource.

Example of two-way resource communication

* Client-side myrsc:

```lua
----
local Tunnel = module("nfx", "shared/Tunnel")

-- build the server-side interface
clientdef = {} -- you can add function to serverdef later in other server scripts
Tunnel.bindInterface("myrsc",clientdef)

-- get the client-side access of myrsc
server = Tunnel.getInterface("myrsc")

function clientdef.clitest(msg)
  print("msg "..msg.." received from server.")
  return true
end

-- call the function on the server, passing parameters.
server.test("Hello Server!")
----
```

* Server-side myrsc:

```lua
----
local Tunnel = module("nfx", "shared/Tunnel")

-- build the server-side interface
serverdef = {} -- you can add function to serverdef later in other server scripts
Tunnel.bindInterface("myrsc",serverdef)

-- get the client-side access of myrsc
client = Tunnel.getInterface("myrsc")

function serverdef.test(msg)
  print("msg "..msg.." received from "..source)
  return 42
end

-- call the function in the [source], passing parameters.
client.clitest(source,"Hello User!")
----
```

This way resources can easily use other resources client/server API.

The notation is `Interface.function(dest, ...)`.

OBS: Good practice is to get the interface once and set it as a global, but if you want to get multiple times the same interface from the same resource, you need to specify a unique identifier (the name of the resource + a unique id for each one). 

NOTE: Tunnel and Proxy are blocking calls in the current coroutine until the values are returned, to bypass this behaviour, especially for the Tunnel to optimize speed (ping latency of each call), use `_` as prefix for the function name (Proxy/Tunnel interfaces should not have functions starting with `_`). This will discard the returned values, but if you still need them, you can make normal calls in a new Citizen thread with `Citizen.CreateThreadNow` or `async` to have non-blocking code.

WARNING: Also remember that Citizen event handlers (used by Proxy and Tunnel) seem to not work while loading the resource, to use the Proxy at loading time, you will need to delay it with `Citizen.CreateThread` or a `SetTimeout`.

### GHMattiMySQL

Used to perform operations on the database, it can be loaded only by the server.

```lua
----
-- load module
MySQL = module("nfx","shared/GHMattiMySQL")

-- prepares a query
MySQL.prepare("queryname","SELECT * FROM users WHERE user = @user")
MySQL.prepare("executename","UPDATE users SET age = @age WHERE user = @user")

-- run query
local rows, totalrows = MySQL.query("queryname",{ user = "examaple" })

-- run execute
local affected = MySQL.execute("executename",{ user = "examaple", age = 16 })

-- run scalar query
local row = MySQL.scalar("queryname",{ user = "examaple" })
----
```

OBS: It is not necessary to pass the parameter table during the query, as long as the query does not require any external value.
