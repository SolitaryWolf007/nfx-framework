return setmetatable({
    
    ["REG_TITLE"] = "RG",
    ["PLAYER_NAME"] = "Nome",
    ["PLAYER_AGE"] = "Idade",
    ["PLAYER_REG"] = "RG",
    ["PLAYER_PHONE"] = "Telefone",
    ["PLAYER_WALLET"] = "Carteira",

    ["TOGGLE_ENTER"] = "Entrou em serviço",
    ["TOGGLE_EXIT"] = "Saiu de serviço",
    ["BUSY_ENTER"] = "Entrou em Modo Ocupado",
    ["BUSY_EXIT"] = "Saiu do Modo Ocupado",

    ["CALL_TARGET"] = "[%s] CHAMADO",
    ["CALL_BLIP"] = "[%s] CHAMADO",
    ["CALL_TARGET_MSG"] = "%s %s [%s], informou: %s",
    ["CALL_TARGET_ACCEPT"] = "Aceitar o chamado de <b>%s %s</b>?",
    ["CALL_ACCEPTED"] = "Chamado atendido por <b>%s %s</b>, aguarde no local.",
    ["CALL_IS_ACCEPTED"] = "Chamado ja foi atendido por outra pessoa.",

    ["POLICE_SHOT_NUM"] = "911",
    ["POLICE_SHOT_WARN"] = "Disparos de arma de fogo aconteceram, verifique o ocorrido.",
    ["POLICE_SHOT_BLIP"] = "Disparos de arma de fogo",
    ["POLICE_PRISON_RUNNING"] = "Ainda vai passar <b>%s meses</b> preso.",
    ["POLICE_PRISON_END"] = "Sua sentença terminou, esperamos não ve-lo novamente.",
    ["POLICE_REG_NOTFOUND"] = "Passaporte <b>%s</b> indisponível no momento.",

    ["EMS_RE_RUNNING"] = "reanimando",
    ["EMS_RE_INVALID"] = "A pessoa precisa estar em coma para prosseguir.",
    ["EMS_TREAT_START"] = "Tratamento no paciente iniciado com sucesso.",
    ["EMS_TREAT_START_2"] = "Tratamento iniciado, aguarde a liberação do paramédico.",
    ["EMS_TREAT_END"] = "Tratamento concluido.",

    ["MEC_DISABLED"] = "Desabilitado",
    ["MEC_LEVEL"] = "Nivel",
    ["MEC_ECU"] = "ECU",
    ["MEC_BRAKES"] = "Freios",
    ["MEC_TRANSM"] = "Transmissão",
    ["MEC_SUSPEN"] = "Suspenção",
    ["MEC_SHIELD"] = "Blindagem",
    ["MEC_CHASSIS"] = "Chassis",
    ["MEC_ENGINE"] = "Motor",
    ["MEC_FUEL"] = "Gasolina",
    ["MEC_REPAIRING"] = "reparando..",

},
{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})