return setmetatable({
    ["CONNECTING_GET_LICENSE"] = "Carregando Licenças do Usuário..",
    ["CONNECTING_GET_USER"] = "Carregando Usuário..",
    
    ["CONNECTING_GET_WL"] = "Verificando Whitelist..",
    ["CONNECTING_NO_WL"] = "Você está sem Whitelist!\nVisite nosso discord: discord.gg/YOURSERVER\nSua licença:",
    
    ["CONNECTING_GET_BAN"] = "Verificando Banimentos..",
    ["CONNECTING_IS_BAN"] = "Você está banido!\nAjuda: discord.gg/YOURSERVER\nUnban Automatico em:",
    ["BANNED_NEVER"] = "Nunca :(",
    ["BANNED_HOURS"] = "Horas",

    ["CONNECTING_ALL_OK"] = "Concluindo Carregamento..",

    ["LOGIN_PROFILES"] = "Personagens",
    ["LOGIN_NEW"] = "-> Novo",
    ["LOGIN_NEW_TXT"] = "Criar Novo Personagem",
    ["LOGIN_NAME"] = "Nome:",
    ["LOGIN_REG"] = "Reg.:",
    
    ["DEATH_TIMER_RUNNING"] = "VOCÊ TEM ~r~%s ~w~SEGUNDOS DE VIDA",
    ["DEATH_TIMEOUT"] = "PRESSIONE ~g~E ~w~PARA VOLTAR AO HOSPITAL OU AGUARDE UM PARAMÉDICO"
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})