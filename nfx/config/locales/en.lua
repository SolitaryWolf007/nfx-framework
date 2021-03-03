return setmetatable({
    ["CONNECTING_GET_LICENSE"] = "Loading User Licenses..",
    ["CONNECTING_GET_USER"] = "Loading User..",
    
    ["CONNECTING_GET_WL"] = "Checking Whitelist..",
    ["CONNECTING_NO_WL"] = "You're out of Whitelist!\nVisit our discord: discord.gg/YOURSERVER\nYour license:",
    
    ["CONNECTING_GET_BAN"] = "Checking Bans..",
    ["CONNECTING_IS_BAN"] = "You're banned!\nHelp: discord.gg/YOURSERVER\nUnban Automatic in:",
    ["BANNED_NEVER"] = "Never :(",
    ["BANNED_HOURS"] = "Hours",
    
    ["CONNECTING_ALL_OK"] = "Completing Loading..",

    ["LOGIN_PROFILES"] = "Characters",
    ["LOGIN_NEW"] = "-> New",
    ["LOGIN_NEW_TXT"] = "Create New Character",
    ["LOGIN_NAME"] = "Name:",
    ["LOGIN_REG"] = "Reg.:",

    ["DEATH_TIMER_RUNNING"] = "YOU HAVE ~r~%s ~w~SECONDS OF LIFE",
    ["DEATH_TIMEOUT"] = "PRESS ~g~E ~w~TO RETURN TO THE HOSPITAL OR WAIT FOR A PARAMEDIC"   
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})