--==============================================================
-- MODULES
--==============================================================
local Tunnel = module("nfx","shared/Tunnel")
local Proxy = module("nfx","shared/Proxy")
nFXcli = Proxy.getInterface("nFX")
--==============================================================
-- nFX
--==============================================================
cFX = {}
sFX = Tunnel.getInterface("nfx_status")
Tunnel.bindInterface("nfx_status",cFX)
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["main"] = module("nfx_status","config/status")
Lang = module("nfx_status","config/locales/"..cfg["main"].locale)
--==============================================================
-- FUNC
--==============================================================
local css = [[
	.div_nfxstatus {
		background: rgba(15,15,15,0.7);
		color: #d3d3d3;
		bottom: 9%;
		right: 2.2%;
		position: absolute;
		padding: 20px 30px;
		font-family: Arial;
		line-height: 30px;
		letter-spacing: 1.5px;
		border-radius: 5px;
		border-right: 4px solid #000000;
	}
	.div_nfxstatus b {
		color: #ffffff;
		padding: 0 4px 0 0;
	}

	.div_nfxstatus center {
		text-align: center;
	}
]]

local identity = false

RegisterCommand('nfxstatus:toggle',function()
	if identity then
		nFXcli.removeDiv("nfxstatus")
		identity = false
	else
		local pid,money,bank,name,lastname,age,reg,phone,jobs = sFX.GetStatus()
		local sjobs = ""
		for name,data in pairs(jobs) do	
			local act = Lang["PLAYER_JOBS_OUT"].."<br>"
			if data.active then 
				act = Lang["PLAYER_JOBS_IN"] 
				local bsy = Lang["PLAYER_JOBS_NBUSY"]
				if data.busy then bsy = Lang["PLAYER_JOBS_BUSY"] end
				act = act.." - "..bsy.."<br>"
			end			
			sjobs = sjobs.."<b>"..name.." - "..data.level.."</b><br>"..act
		end
		if pid then
			nFXcli.setDiv("nfxstatus",css,"<center><b>"..Lang["PLAYER_TITLE"].."</b></center><b>ID:</b> "..pid.."<br><b>"..Lang["PLAYER_NAME"]..":</b> "..name.." "..lastname.."<br><b>"..Lang["PLAYER_AGE"]..":</b> "..age.."<br><b>"..Lang["PLAYER_REG"]..":</b> "..reg.."<br><b>"..Lang["PLAYER_PHONE"]..":</b> "..phone.."<br><b>"..Lang["PLAYER_WALLET"]..":</b> $"..money.."<br><b>"..Lang["PLAYER_BANK"]..":</b> $"..bank.."<br><center><b>"..Lang["PLAYER_JOBS"].."</b></center>"..sjobs)
			identity = true
		end
	end
end, false)
RegisterKeyMapping('nfxstatus:toggle' , 'Toggle Status' , 'keyboard' , 'F11' )