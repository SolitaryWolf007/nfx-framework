--=====================================================
-- ITEMS FUNCTIONS
--=====================================================
function nFX.registerInvItem(itemid,name,index,weight,type)
	if (not cfg["inventory"].items[itemid]) then
        cfg["inventory"].items[itemid] = { ["name"] = name, ["index"] = index, ["weight"] = weight, ["type"] = type }
        return true
    end
    return false
end

function nFX.unregisterInvItem(itemid)
	if cfg["inventory"].items[itemid] then
        cfg["inventory"].items[itemid] = nil
        return true
    end
    return false
end

function nFX.calcInvWeight(inv)
    local weight = 0
    for itemid,qtd in pairs(inv) do
        if cfg["inventory"].items[itemid] then
            weight = weight + (cfg["inventory"].items[itemid].weight*qtd)
        end
    end
    return weight
end
--=====================================================
-- ITEMS
--=====================================================
function nFX.getInvItems()
	return cfg["inventory"].items
end
--=====================================================
-- ITEMNAME
--=====================================================
function nFX.getInvItemName(itemid)
	if cfg["inventory"].items[itemid] then
		return cfg["inventory"].items[itemid].name
	end
end
--=====================================================
-- ITEMINDEX
--=====================================================
function nFX.getInvItemIndex(itemid)
    if cfg["inventory"].items[itemid] then
		return cfg["inventory"].items[itemid].index
	end
end
--=====================================================
-- ITEMTYPE
--=====================================================
function nFX.getInvItemType(itemid)
    if cfg["inventory"].items[itemid] then
		return cfg["inventory"].items[itemid].type
	end
end
--=====================================================
-- ITEMWEIGHT
--=====================================================
function nFX.getInvItemWeight(itemid)
    if cfg["inventory"].items[itemid] then
		return cfg["inventory"].items[itemid].weight
	end
end
--=====================================================
-- ITEM
--=====================================================
function nFX.getInvItemData(itemid)
    if cfg["inventory"].items[itemid] then
		return cfg["inventory"].items[itemid]
	end
end
--=====================================================
-- VEHICLE WEIGHT
--=====================================================
function nFX.getTrunkWight(model)
    if cfg["inventory"].vehicle_chests[model] then
		return cfg["inventory"].vehicle_chests[model]
	end
end