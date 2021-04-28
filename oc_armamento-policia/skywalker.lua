 
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_armamento-policia",oC)

local webhooklink = "https://discordapp.com/api/webhooks/738772680651833484/ZgUBUl0ISO2a2hZ91So2EPZdmlZfVbdUQNtjHfgI4thp8_5evphrU8IWfiuJC4wcnY2k"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "kit1" },
	{ item = "kit2" },
	{ item = "kit3" },
	{ item = "kit4" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-arma")
AddEventHandler("produzir-arma",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
				if item == "kit1" then
                    -- vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMBATPISTOL",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_STUNGUN",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_NIGHTSTICK",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_FLASHLIGHT",1)
                    TriggerClientEvent("Notify",source,"sucesso","Você pegou o <b>KIT 1</b> para recrutas.")
            		SendWebhookMessage(webhooklink, "```[PLAYER ID]: "..user_id.." pegou o Kit 1 no arsenal da Policia.```")

                elseif item == "kit2" then
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMBATPISTOL",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_STUNGUN",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_NIGHTSTICK",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_FLASHLIGHT",1)
                    TriggerClientEvent("Notify",source,"sucesso","Você pegou o <b>KIT 2</b> para PTR diaria.")
            		SendWebhookMessage(webhooklink, "```[PLAYER ID]: "..user_id.." pegou o Kit 2 no arsenal da Policia.```")
                elseif item == "kit3" then
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMBATPISTOL",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_STUNGUN",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_NIGHTSTICK",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_SMG",1)
                    TriggerClientEvent("Notify",source,"sucesso","Você pegou o <b>KIT 3</b> para ação nível 1.")
            		SendWebhookMessage(webhooklink, "```[PLAYER ID]: "..user_id.." pegou o Kit 3 no arsenal da Policia.```")
                elseif item == "kit4" then
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMBATPISTOL",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_STUNGUN",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_NIGHTSTICK",1)
                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_CARBINERIFLE_MK2",1)
                    TriggerClientEvent("Notify",source,"sucesso","Você pegou o <b>KIT 4</b> para ação de banco.")      
            		SendWebhookMessage(webhooklink, "```[PLAYER ID]: "..user_id.." pegou o Kit 4 no arsenal da Policia.```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"pmerj.permissao") then
        return true
    end
end