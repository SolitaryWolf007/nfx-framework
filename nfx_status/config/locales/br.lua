return setmetatable({
    ["PLAYER_TITLE"] = "PLAYER",
    ["PLAYER_NAME"] = "Nome",
    ["PLAYER_AGE"] = "Idade",
    ["PLAYER_REG"] = "RG",
    ["PLAYER_PHONE"] = "Telefone",
    ["PLAYER_WALLET"] = "Carteira",
    ["PLAYER_BANK"] = "Banco",
    ["PLAYER_JOBS"] = "EMPREGOS",
    ["PLAYER_JOBS_IN"] = "(em serviço)",
    ["PLAYER_JOBS_OUT"] = "(fora de serviço)"
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})