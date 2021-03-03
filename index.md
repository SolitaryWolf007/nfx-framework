# Welcome to nFX docs.

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

## Server Functions

```lua

    
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

NOTE: Tunnel and Proxy are blocking calls in the current coroutine until the values are returned, to bypass this behaviour, especially for the Tunnel to optimize speed (ping latency of each call), use ` _ ` as prefix for the function name (Proxy/Tunnel interfaces should not have functions starting with ` _ `). This will discard the returned values, but if you still need them, you can make normal calls in a new Citizen thread with `Citizen.CreateThreadNow` or `async` to have non-blocking code.

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
