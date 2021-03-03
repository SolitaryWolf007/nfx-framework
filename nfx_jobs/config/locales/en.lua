return setmetatable({
    ["REG_TITLE"] = "RG",
    ["PLAYER_NAME"] = "Name",
    ["PLAYER_AGE"] = "Age",
    ["PLAYER_REG"] = "Registration",
    ["PLAYER_PHONE"] = "Phone",
    ["PLAYER_WALLET"] = "Wallet",

    ["TOGGLE_ENTER"] = "Entered service",
    ["TOGGLE_EXIT"] = "Out of service",
    ["BUSY_ENTER"] = "Entered Busy Mode",
    ["BUSY_EXIT"] = "Exit Busy Mode",

    ["CALL_TARGET"] = "[%s] CALLING",
    ["CALL_BLIP"] = "[%s] CALLING",
    ["CALL_TARGET_MSG"] = "%s %s [%s], inform: %s",
    ["CALL_TARGET_ACCEPT"] = "Accept <b>%s %s</b> call?",
    ["CALL_ACCEPTED"] = "Call answered by <b>%s %s</b>, wait on the spot.",
    ["CALL_IS_ACCEPTED"] = "Calling has already been answered by someone else.",

    ["POLICE_SHOT_NUM"] = "911",
    ["POLICE_SHOT_WARN"] = "Firearm shots happened, check what happened.",
    ["POLICE_SHOT_BLIP"] = "Firearm shots",
    ["POLICE_PRISON_RUNNING"] = "He'll still be in prison for <b>%s months</b>.",
    ["POLICE_PRISON_END"] = "Your sentence is over, we hope we won't see you again.",
    ["POLICE_REG_NOTFOUND"] = "Player <b>%s</b> currently unavailable.",

    ["EMS_RE_RUNNING"] = "reviving",
    ["EMS_RE_INVALID"] = "The person must be in a coma to proceed.",
    ["EMS_TREAT_START"] = "Treatment on the patient started successfully.",
    ["EMS_TREAT_START_2"] = "Treatment started, wait for the paramedic to be released.",
    ["EMS_TREAT_END"] = "Treatment completed.",

    ["MEC_DISABLED"] = "Disabled",
    ["MEC_LEVEL"] = "Level",
    ["MEC_ECU"] = "ECU",
    ["MEC_BRAKES"] = "Brakes",
    ["MEC_TRANSM"] = "Transmission",
    ["MEC_SUSPEN"] = "Suspension",
    ["MEC_SHIELD"] = "Shield",
    ["MEC_CHASSIS"] = "Chassis",
    ["MEC_ENGINE"] = "Engine",
    ["MEC_FUEL"] = "Fuel",
    ["MEC_REPAIRING"] = "repairing..",
},{
    __index = function(itable,key)
        return "NO LANG: "..key
    end
})