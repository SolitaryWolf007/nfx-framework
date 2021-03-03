local config = {}
--======================================================
-- GROUPS
--======================================================
config.groups = {
    ["Police"] = {
        _config = {
            type = "primary",
            single = true
        },
        ["Recruit"] = { level = 1, salary = 1500 },
        ["Official"] = { level = 2, salary = 2600 },
        ["Sergeant"] = { level = 3, salary = 3100 },
        ["Lieutenant"] = { level = 4, salary = 3900 },
        ["Captain"] = { level = 5, salary = 4800 },
        ["Commander"] = { level = 6, salary = 7000 },     
    },

    ["EMS"] = {
        _config = {
            type = "primary",
            single = true
        },
        ["Nurse"] = { level = 1, salary = 2000 },
        ["Paramedic"] = { level = 2, salary = 2800 },
        ["Doctor"] = { level = 3, salary = 3600 },
        ["Surgeon"] = { level = 4, salary = 5500 },
        ["Director"] = { level = 5, salary = 7000 },
    },

    ["FireDepartment"] = {
        _config = {
            type = "primary",
            single = true
        },
        ["Official"] = { level = 1, salary = 2800 },
        ["Sergeant"] = { level = 2, salary = 3600 },
        ["Lieutenant"] = { level = 3, salary = 4500 },
        ["Captain"] = { level = 4, salary = 5500 },
        ["Commander"] = { level = 5, salary = 7000 },     
    },

    ["Mechanic"] = {
        _config = {
            type = "primary",
            single = false
        },
        ["Novice"] = { level = 1, salary = 1000 },
        ["Experient"] = { level = 2, salary = 1800 },
        ["Professional"] = { level = 3, salary = 2600 },
        ["Manager"] = { level = 4, salary = 3500 },
        ["Boss"] = { level = 5, salary = 5000 },
    },

    ["Taxi"] = {
        _config = {
            type = "primary",
            single = false
        },
        ["Novice"] = { level = 1, salary = 600 },
        ["Experient"] = { level = 2, salary = 1000 },
        ["Professional"] = { level = 3, salary = 1300 },
        ["Manager"] = { level = 4, salary = 1800 },
        ["Boss"] = { level = 5, salary = 2000 },
    },

}

return config