local weapon_list = {}

--==============================================================
-- FUNCTIONS
--==============================================================
local function DoesPlayerOwnWeapon(weaponModel)
    return HasPedGotWeapon(PlayerPedId(), weaponModel, 0)
end

local function DoesPlayerWeaponHaveComponent(weaponModel, componentModel)
    return (DoesPlayerOwnWeapon(weaponModel) and HasPedGotWeaponComponent(PlayerPedId(), weaponModel, componentModel) or false)
end
--==============================================================
-- WEAPONS
--==============================================================
function nFXcli.getWeaponsGived()
	return weapon_list
end

function nFXcli.legalWeaponsChecker(weapon)
	local ilegal = false
	for v, b in pairs(weapon) do
	  	if not weapon_list[v] then
			--nFXsrv.ilegalWeapon(v,b.ammo or 0)
			ilegal = true
	  	end
	end
	if ilegal then
	  nFXcli.giveWeapons(weapon_list, true)
	  weapon = weapon_list
	end
	return weapon
end

function nFXcli.getWeapons()
	local ped = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for k,v in pairs(cfg["weapons"].weapon_models) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(ped,hash) then
			local weapon = {}
			weapons[v] = weapon
			local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74,ped,hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapon.ammo = GetAmmoInPedWeapon(ped,hash)
			else
				weapon.ammo = 0
			end
		end
	end
	return nFXcli.legalWeaponsChecker(weapons)
end

function nFXcli.replaceWeapons(weapons)
	local old_weapons = nFXcli.getWeapons()
	nFXcli.giveWeapons(weapons,true)
	return old_weapons
end

function nFXcli.giveWeapons(weapons,clear_before)
	local ped = PlayerPedId()
	if clear_before then
		RemoveAllPedWeapons(ped,true)
		weapon_list = {}
	end

	for k,weapon in pairs(weapons) do
		local hash = GetHashKey(k)
		local ammo = weapon.ammo or 0
		GiveWeaponToPed(ped,hash,ammo,false)
		weapon_list[k] = weapon
	end
end

function nFXcli.clearWeapons()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
	weapon_list = {}
end
--==============================================================
-- WEAPONS CUSTOMS
--==============================================================
function nFXcli.GiveWeaponsCustomizations(customs)
    local ped = PlayerPedId()

    if customs then
        for weapon,data in pairs(customs) do   
            if DoesPlayerOwnWeapon(weapon) then   
                
                SetPedWeaponTintIndex(ped,weapon,data.tint)
                for i,attach in ipairs(data.attachments) do
                    GiveWeaponComponentToPed(ped, weapon, attach.model)
                end

            end     
        end
    end   

end

function nFXcli.GetWeaponsCustomizations(weap)
    local customs = {}
	local ped = PlayerPedId()
	local weapons = weap
	if (not weapons) then
		weapons = nFXcli.getWeapons()
	end
    for weapon,_ in pairs(weapons) do
        if DoesPlayerOwnWeapon(weapon) then
            customs[weapon] = {
                tint = GetPedWeaponTintIndex(ped, weapon),
                attachments = nFXcli.GetWeaponComponents(weapon)
            }
        end
    end
    return customs
end

function nFXcli.GetWeaponComponents(weapon)
    local r = {}
    for _,attach in ipairs(cfg["weapons"].weapon_components) do
        if DoesPlayerWeaponHaveComponent(weapon, attach[1]) then
            r[#r+1] = {  
                model = attach[1]
            }
        end
    end
    return r
end