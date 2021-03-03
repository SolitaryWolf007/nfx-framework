--==================================================================================================
-- GUI
--==================================================================================================
local menu_state = {
	opened = false,
	name = "Menu",
}

function nFXcli.openMenuData(menudata)
	SendNUIMessage({ act = "open_menu", menudata = menudata })
end

function nFXcli.closeMenu()
	SendNUIMessage({ act = "close_menu" })
end

function nFXcli.getMenuState()
	return menu_state
end

function nFXcli.prompt(title,default_text)
	SendNUIMessage({ act = "prompt", title = title, text = tostring(default_text) })
	SetNuiFocus(true)
end

function nFXcli.request(id,text,time)
	SendNUIMessage({ act = "request", id = id, text = tostring(text), time = time })
end

RegisterNUICallback("menu",function(data,cb)
	if data.act == "close" then
		nFXsrv._closeMenu(data.id)
	elseif data.act == "valid" then
		nFXsrv._validMenuChoice(data.id,data.choice,data.mod)
	end
end)

RegisterNUICallback("menu_state",function(data,cb)
	menu_state = data
end)

RegisterNUICallback("prompt",function(data,cb)
	if data.act == "close" then
		SetNuiFocus(false)
		nFXsrv._promptResult(data.result)
	end
end)

RegisterNUICallback("request",function(data,cb)
	if data.act == "response" then
		nFXsrv._requestResult(data.id,data.ok)
	end
end)

RegisterNUICallback("init",function(data,cb)
	SendNUIMessage({ act = "cfg", cfg = {} })
end)

function nFXcli.setDiv(name,css,content)
	SendNUIMessage({ act = "set_div", name = name, css = css, content = content })
end

function nFXcli.setDivContent(name,content)
	SendNUIMessage({ act = "set_div_content", name = name, content = content })
end

function nFXcli.removeDiv(name)
	SendNUIMessage({ act = "remove_div", name = name })
end
--==================================================================================================
-- KEY MAPPING
--==================================================================================================
RegisterCommand('nfx:up', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "UP" }) 
       	PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
	end
end, false)
RegisterKeyMapping ( 'nfx:up' , 'Up' , 'keyboard' , 'UP' )
--==================================================================================================
RegisterCommand('nfx:down', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "DOWN" })
       	PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
	end
end, false)
RegisterKeyMapping ( 'nfx:down' , 'Down' , 'keyboard' , 'DOWN' )
--==================================================================================================
RegisterCommand('nfx:left', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "LEFT" })
       	PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
	end
end, false)
RegisterKeyMapping ( 'nfx:left' , 'Left' , 'keyboard' , 'LEFT' )
--==================================================================================================
RegisterCommand('nfx:right', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "RIGHT" }) 
       	PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
	end
end, false)
RegisterKeyMapping ( 'nfx:right' , 'Right' , 'keyboard' , 'RIGHT' )
--==================================================================================================
RegisterCommand('nfx:select', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "SELECT" })
		PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
	end
end, false)
RegisterKeyMapping ( 'nfx:select' , 'Select' , 'keyboard' , 'RETURN' )
--==================================================================================================
RegisterCommand('nfx:cancel', function()
	SendNUIMessage({ act = "event", event = "CANCEL" })
end, false)
RegisterKeyMapping ( 'nfx:cancel' , 'Cancel' , 'keyboard' , 'BACK' )
--==================================================================================================
RegisterCommand('nfx:accept', function()
    SendNUIMessage({ act = "event", event = "Y" })
end, false)
RegisterKeyMapping ( 'nfx:accept' , 'Accept' , 'keyboard' , 'y' )
--==================================================================================================
RegisterCommand('nfx:decline', function()
    SendNUIMessage({ act = "event", event = "U" })
end, false)
RegisterKeyMapping ( 'nfx:decline' , 'Decline' , 'keyboard' , 'u' )
--==================================================================================================