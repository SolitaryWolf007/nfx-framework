return setmetatable({
    ["LICENSE"] = "License",
    ["PLAYER_NOTFOUND"] = "Player <b>%s</b> not found.",
    ["BAN_PROMPT"] = "-1 = Permanent Ban | 0 = No Ban | 1 or greater = Temp Ban (hours)",
    ["COORDS_PROMPT"] = "Coords:",
    ["GROUP_SET_OK"] = "Player <b>%s</b> set as <b>%s - %s</b>.",
    ["GROUP_SET_ERR"] = "Incorrect command, Group or Level invalid!",
    ["GROUP_REM_OK"] = "Group <b>%s</b> removed of Player %s!",
    ["GROUP_REM_ERR"] = "Incorrect command, the player is not in the <b>%s</b> group!",
    ["PON_ONLINE"] = "ONLINE:",
    ["PON_SRCS"] = "ONLINE SOURCES:",
    ["KICK_REASON"] = "Kick Reason:",
    ["KICK_MSG"] = "You got kicked.\nReason: %s",
    ["KICKALL_REASON"] = "Kick Reason:",
    ["KICKALL_MSG"] = "All players kicked.\nReason: %s",
    ["CAR_SPAWN_OK"] = "Vehicle <b>%s</b> spawned!",
    ["CAR_SPAWN_ERR"] = "Vehicle <b>%s</b> not found! Or not cached?",
    ["CAR_VINFOS"] = "Vehicle: <b>%s</b><br>Model: <b>%s ( %s )</b><br>Plate: <b>%s</b><br>Price: <b>%s</b>",
    ["ITEM_GIVED"] = "Gived: <b>%s</b><br>Amount:  <b>%sx</b>",
    ["CHANM_NAME"] = "New Name:",
    ["CHANM_LASTNAME"] = "New Lastname:",
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})