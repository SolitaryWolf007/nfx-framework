--==============================================================
-- MODULES
--==============================================================
local Tunnel = module("nfx","shared/Tunnel")
local Proxy = module("nfx","shared/Proxy")
nFX = Proxy.getInterface("nFX")
nFXcli = Tunnel.getInterface("nFX")
--==============================================================
-- nFX
--==============================================================
sFX = {}
Tunnel.bindInterface("nfx_status",sFX)
cFX = Tunnel.getInterface("nfx_status")
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["main"] = module("nfx_status","config/status")
Lang = module("nfx_status","config/locales/"..cfg["main"].locale)
--==============================================================
-- FUNC
--==============================================================
function sFX.GetStatus()
	local source = source
	local player = nFX.getPlayer(source)
	if player then
		local pid = player.getPlayerId()
		local money = player.getMoney()
		local bank = player.getBankMoney()
		local name = player.getName()
		local lastname = player.getLastname()
		local age = player.getAge()
		local reg = player.getRegistration()
		local phone = player.getPhoneNumber()
		local jobs = player.getGroups()	
		return pid,money,bank,name,lastname,age,reg,phone,jobs
	end
end