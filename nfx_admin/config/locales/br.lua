return setmetatable({
    ["LICENSE"] = "Licença",
    ["PLAYER_NOTFOUND"] = "Player <b>%s</b> não encontrado.",
    ["BAN_PROMPT"] = "-1 = BAN Permanente | 0 = Unban | 1 ou maior = Tempo de banimento (horas)",
    ["COORDS_PROMPT"] = "Coords:",
    ["GROUP_SET_OK"] = "Player <b>%s</b> setado como <b>%s - %s</b>.",
    ["GROUP_SET_ERR"] = "Comando incorreto, Grupo ou Nivel invalido!",
    ["GROUP_REM_OK"] = "Grupo <b>%s</b> removido do player %s!",
    ["GROUP_REM_ERR"] = "Comando incorreto, o player não esta no grupo <b>%s</b>!",
    ["PON_ONLINE"] = "ONLINE:",
    ["PON_SRCS"] = "ONLINE SOURCES:",
    ["KICK_REASON"] = "Razão do Kick:",
    ["KICK_MSG"] = "Você foi kikado.\nMotivo: %s",
    ["KICKALL_REASON"] = "Razão do Kick:",
    ["KICKALL_MSG"] = "Todos players kickados.\nMotivo: %s",
    ["CAR_SPAWN_OK"] = "Veiculo <b>%s</b> spawnado!",
    ["CAR_SPAWN_ERR"] = "Veiculo <b>%s</b> não encontrado! Ou não esta em cache?",
    ["CAR_VINFOS"] = "Veiculo: <b>%s</b><br>Modelo: <b>%s ( %s )</b><br>Placa: <b>%s</b><br>Preço: <b>%s</b>",
    ["ITEM_GIVED"] = "Pegou: <b>%s</b><br>Quantidade:  <b>%sx</b>",
    ["CHANM_NAME"] = "Novo Nome:",
    ["CHANM_LASTNAME"] = "Novo Sobrenome:",
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})