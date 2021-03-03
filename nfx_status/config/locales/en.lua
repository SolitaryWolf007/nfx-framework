return setmetatable({
    ["PLAYER_TITLE"] = "PLAYER",
    ["PLAYER_NAME"] = "Name",
    ["PLAYER_AGE"] = "Age",
    ["PLAYER_REG"] = "Registration",
    ["PLAYER_PHONE"] = "Phone",
    ["PLAYER_WALLET"] = "Wallet",
    ["PLAYER_BANK"] = "Bank",
    ["PLAYER_JOBS"] = "JOBS",
    ["PLAYER_JOBS_IN"] = "(in service)",
    ["PLAYER_JOBS_OUT"] = "(out service)"
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})