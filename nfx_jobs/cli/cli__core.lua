--==============================================================
-- MODULES
--==============================================================
Tunnel = module("nfx","shared/Tunnel")
Proxy = module("nfx","shared/Proxy")
Tools = module("nfx","shared/Tools")
--==============================================================
-- nFX
--==============================================================
nFXcli = Proxy.getInterface("nFX")
--==============================================================
-- CFG / LANG
--==============================================================
cfg = {}
cfg["core"] = module("nfx_jobs","config/_core")
cfg["police"] = module("nfx_jobs","config/police")
cfg["emergency"] = module("nfx_jobs","config/emergency")
cfg["player"] = module("nfx","config/player")

Lang = module("nfx_jobs","config/locales/"..cfg["core"].locale)
--==============================================================
-- ...
--==============================================================