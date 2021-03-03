## Welcome to nFX docs.

nFX It is a framework for fivem that I started to develop with free time, therefore, many things can still change. Here is the list of functions and events and how to use them.

### Server Events

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

### Client Events

```lua
    -- called on the player's first spawn.
    AddEventHandler("nFX:playerSpawned",function() end)
    
    -- called when the player respawns.
    AddEventHandler("nFX:playerRespawned",function() end)
```
