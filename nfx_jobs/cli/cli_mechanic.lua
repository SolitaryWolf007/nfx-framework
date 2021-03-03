--==============================================================
-- MECHANIC
--==============================================================
cMEC = {}
Tunnel.bindInterface("nfx_jobs-mechanic",cMEC)
Proxy.addInterface("nfx_jobs-mechanic",cMEC)
sMEC = Tunnel.getInterface("nfx_jobs-mechanic")
--==============================================================
-- VIEW TUNNING
--==============================================================
RegisterCommand("vtuning",function(source,args)
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(vehicle) and sMEC.isMechanic()  then
		local ecu = GetVehicleMod(vehicle,11)
		local brakes = GetVehicleMod(vehicle,12)
		local transmission = GetVehicleMod(vehicle,13)
		local suspension = GetVehicleMod(vehicle,15)
		local shield = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

        local lvl = Lang["MEC_LEVEL"]
        local des = Lang["MEC_DISABLED"]
        
        if ecu == -1 then
			ecu = des
		elseif ecu == 0 then
			ecu = lvl.." 1 / 4"
		elseif ecu == 1 then
			ecu = lvl.." 2 / 4"
		elseif ecu == 2 then
			ecu = lvl.." 3 / 4"
		elseif ecu == 3 then
			ecu = lvl.." 4 / 4"
		elseif ecu == 4 then
			ecu = lvl.." 5 / 5"
		end

		if brakes == -1 then
			brakes = des
		elseif brakes == 0 then
			brakes = lvl.." 1 / "..GetNumVehicleMods(vehicle,12)
		elseif brakes == 1 then
			brakes = lvl.." 2 / "..GetNumVehicleMods(vehicle,12)
		elseif brakes == 2 then
			brakes = lvl.." 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmission == -1 then
			transmission = des
		elseif transmission == 0 then
			transmission = lvl.." 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmission == 1 then
			transmission = lvl.." 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmission == 2 then
			transmission = lvl.." 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmission == 3 then
			transmission = lvl.." 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspension == -1 then
			suspension = des
		elseif suspension == 0 then
			suspension = lvl.." 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspension == 1 then
			suspension = lvl.." 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspension == 2 then
			suspension = lvl.." 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspension == 3 then
			suspension = lvl.." 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if shield == -1 then
			shield = des
		elseif shield == 0 then
			shield = lvl.." 1 / "..GetNumVehicleMods(vehicle,16)
		elseif shield == 1 then
			shield = lvl.." 2 / "..GetNumVehicleMods(vehicle,16)
		elseif shield == 2 then
			shield = lvl.." 3 / "..GetNumVehicleMods(vehicle,16)
		elseif shield == 3 then
			shield = lvl.." 4 / "..GetNumVehicleMods(vehicle,16)
		elseif shield == 4 then
			shield = lvl.." 5 / "..GetNumVehicleMods(vehicle,16)
		end

        TriggerEvent("Notify","info","<b>"..Lang["MEC_ECU"]..":</b> "..ecu.."<br><b>"..Lang["MEC_BRAKES"]..":</b> "..brakes..
        "<br><b>"..Lang["MEC_TRANSM"]..":</b> "..transmission.."<br><b>"..Lang["MEC_SUSPEN"]..":</b> "..suspension..
        "<br><b>"..Lang["MEC_SHIELD"]..":</b> "..shield.."<br><b>"..Lang["MEC_CHASSIS"]..":</b> "..parseInt(body/10)..
        "%<br><b>"..Lang["MEC_ENGINE"]..":</b> "..parseInt(engine/10).."%<br><b>"..Lang["MEC_FUEL"]..":</b> "..parseInt(fuel).."%",15000)
	end
end)