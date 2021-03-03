local config = {}
--======================================================
-- CORE - NFX SERVER
--======================================================
-- locale
config.locale = "br"
-- auto wl
config.auto_whitelist = 0 -- 1: ON // 0: OFF
-- clock format
config.time_template = "%H:%M:%S %d/%m/%Y" -- search 'os.date() lua' to more details
-- player save interval
config.save_interval = 10 -- seconds
-- access levels
config.access_levels = {  
    ["administrator"] = 4,
    ["moderator"] = 3,
    ["suport"] = 2,
    ["citizen"] = 1,
}
--======================================================
-- DEBUG
--======================================================
config.debug = false                -- if true, write debugging information to the console (true/false).
config.debug_async_warning = false  -- displaying async return warning (true/false).
config.debug_async_time = 2         -- time to wait before displaying async return warning (seconds).

return config