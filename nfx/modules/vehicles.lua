--==============================================================
-- VEHICLE DATA
--==============================================================
function nFX.vehicleData(model)
    if cfg["vehicles"].data[model] then
        return cfg["vehicles"].data[model]
    end
end
--==============================================================
-- VEHICLE NAME
--==============================================================
function nFX.vehicleName(model)
    if cfg["vehicles"].data[model] then
        return cfg["vehicles"].data[model].name
    end
end
--==============================================================
-- VEHICLE MANUFACTURER
--==============================================================
function nFX.vehicleManufac(model)
    if cfg["vehicles"].data[model] then
        return cfg["vehicles"].data[model].manufacturer
    end
end
--==============================================================
-- VEHICLE CLASS
--==============================================================
function nFX.vehicleClass(model)
    if cfg["vehicles"].data[model] then
        return cfg["vehicles"].data[model].class
    end
end
--==============================================================
-- VEHICLE PRICE
--==============================================================
function nFX.vehiclePrice(model)
    if cfg["vehicles"].data[model] then
        return cfg["vehicles"].data[model].price
    end
end
--==============================================================
-- VEHICLE IS HIDDEN
--==============================================================
function nFX.vehicleIsHidden(model)
    if cfg["vehicles"].data[model] then
        return cfg["vehicles"].data[model].hide
    end
end
--==============================================================
-- VEHICLE MODEL
--==============================================================
function nFX.vehicleModel(hash)
    if cfg["vehicles"].hashes[hash] then
        return cfg["vehicles"].hashes[hash]
    end
end
--==============================================================
-- GET CLASSES
--==============================================================
function nFX.vehicleClasses()
    return cfg["vehicles"].classes
end
--==============================================================
-- GET MANUFACTURERS
--==============================================================
function nFX.vehicleManufacturers()
    return cfg["vehicles"].manufacturers
end