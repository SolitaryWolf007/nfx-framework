local menu_ids = Tools.newIDGenerator()
local client_menus = {}
local rclient_menus = {}

function nFX.openMenu(source,menudef)
	local menudata = {}
	menudata.choices = {}

	for k,v in pairs(menudef) do
		if k ~= "name" and k ~= "onclose" and k ~= "css" then
			table.insert(menudata.choices,{k,v[2]})
		end
	end

	table.sort(menudata.choices, function(a,b)
		return string.upper(a[1]) < string.upper(b[1])
	end)

	menudata.name = menudef.name or "Menu"
	menudata.css = menudef.css or {}
	menudata.id = menu_ids:gen() 

	client_menus[menudata.id] = { def = menudef, source = source }
	rclient_menus[source] = menudata.id

	nFXcli._closeMenu(source)
	nFXcli._openMenuData(source,menudata)
end

function nFX.closeMenu(source)
	nFXcli._closeMenu(source)
end

local prompts = {}
function nFX.prompt(source,title,default_text)
	local r = async()
	prompts[source] = r
	nFXcli._prompt(source,title,default_text)
	return r:wait()
end

local request_ids = Tools.newIDGenerator()
local requests = {}

function nFX.request(source,text,time)
	local r = async()
	local id = request_ids:gen()
	local request = { source = source, cb_ok = r, done = false }
	requests[id] = request

	nFXcli.request(source,id,text,time)

	SetTimeout(time*1000,function()
		if not request.done then
			request.cb_ok(false)
			request_ids:free(id)
			requests[id] = nil
		end
	end)
	return r:wait()
end

function nFXsrv.closeMenu(id)
	local source = source
	local menu = client_menus[id]
	if menu and menu.source == source then
		if menu.def.onclose then
			menu.def.onclose(source)
		end
		menu_ids:free(id)
		client_menus[id] = nil
		rclient_menus[source] = nil
	end
end

function nFXsrv.validMenuChoice(id,choice,mod)
	local source = source
	local menu = client_menus[id]
	if menu and menu.source == source then
		local ch = menu.def[choice]
		if ch then
			local cb = ch[1]
			if cb then
				cb(source,choice,mod)
			end
		end
	end
end

function nFXsrv.promptResult(text)
	if text == nil then
		text = ""
	end

	local prompt = prompts[source]
	if prompt ~= nil then
		prompts[source] = nil
		prompt(text)
	end
end

function nFXsrv.requestResult(id,ok)
	local request = requests[id]
	if request and request.source == source then
		request.done = true
		request.cb_ok(not not ok)
		request_ids:free(id)
		requests[id] = nil
	end
end

AddEventHandler("nFX:playerDropped",function(source,license)
	local id = rclient_menus[source]
	if id then
		local menu = client_menus[id]
		if menu and menu.source == source then
			if menu.def.onclose then
				menu.def.onclose(source)
			end

			menu_ids:free(id)
			client_menus[id] = nil
			rclient_menus[source] = nil
		end
	end
end)