RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,ms)
	SendNUIMessage({ css = css, mensagem = mensagem, ms = ms or 5000 })
end)