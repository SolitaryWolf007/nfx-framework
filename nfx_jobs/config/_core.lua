local config = {}
--==============================================================
-- CORE - JOBS
--==============================================================
config.locale = "br"

config.call_groups = {
    ["police"] = { { name = "Police", level = "Official" } },
    ["ems"] = { "FireDepartment", { name = "EMS", level = "Paramedic" } },
    ["mec"] = { "Mechanic" },
    ["taxi"] = { "Taxi" },
}

return config