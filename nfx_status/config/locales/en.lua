return setmetatable({
    ["PLAYER_TITLE"] = "PLAYER",
    ["PLAYER_NAME"] = "Name",
    ["PLAYER_AGE"] = "Age",
    ["PLAYER_REG"] = "Registration",
    ["PLAYER_PHONE"] = "Phone",
    ["PLAYER_WALLET"] = "Wallet",
    ["PLAYER_BANK"] = "Bank",
    ["PLAYER_JOBS"] = "JOBS",
    ["PLAYER_JOBS_IN"] = "In service",
    ["PLAYER_JOBS_OUT"] = "Out service",
    ["PLAYER_JOBS_BUSY"] = "Occupied",
    ["PLAYER_JOBS_NBUSY"] = "Active"
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})