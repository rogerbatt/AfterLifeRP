local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("oc_entregas-drogas",emP)
levels = Proxy.getInterface("vrp_levels")
local rndexp = {10,20}
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdrugs = "https://discordapp.com/api/webhooks/747503481065177128/ib-rIk9cNqWJcCBdzP31A6vGZd4nhUeXPQv5HPFdGNgMbJMUEMJKw2b_kNFYCviL_-Pu"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(3,5)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        return vRP.getInventoryItemAmount(user_id,"lolo") or vRP.getInventoryItemAmount(user_id,"lsd") or vRP.getInventoryItemAmount(user_id,"baseado") >= quantidade[source]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local rndMin,rndMax = table.unpack(rndexp)
	local rndResult = math.random(rndMin, rndMax)
	local policia = vRP.getUsersByPermission("policia.permissao")
	local bonus = 0

	if #policia >= 1 and #policia <= 3 then
        bonus = 300
    elseif #policia >= 4 and #policia <= 6 then
        bonus = 400
    elseif #policia >= 7 and #policia <= 10 then
        bonus = 600
    elseif #policia > 10 then
        bonus = 800
    end

	if user_id then
		if vRP.tryGetInventoryItem(user_id,"lsd",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"lolo",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"baseado",quantidade[source]) then
			vRP.giveInventoryItem(user_id,"dinheiro-sujo", (parseInt(3500) + bonus) * quantidade[source])
			TriggerClientEvent("Notify",source,"importante","Você recebeu <b>Experiência em Crimes</b>.")
		end
		quantidade[source] = nil
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Recebemos uma denuncia de tráfico, verifique o ocorrido.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
		SendWebhookMessage(webhookdrugs,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FOI DENUNCIADO] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end