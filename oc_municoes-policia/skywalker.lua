local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_municoes-policia",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local municoes = {
	{ item = "m-m4a1" },
    { item = "m-glock2" },
	{ item = "m-mp5" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-municao")
AddEventHandler("produzir-municao",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(municoes) do
			if item == v.item then
                if item == "m-m4a1" then
                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_CARBINERIFLE_MK2",100)
                    TriggerClientEvent("Notify",source,"sucesso","Você pegou as munições de <b>M4A1</b>.")
                elseif item == "m-glock2" then
                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_COMBATPISTOL",100)
                    TriggerClientEvent("Notify",source,"sucesso","Você pegou as munições de <b>GLOCK</b>.")
                elseif item == "m-mp5" then
                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_SMG",100)
                    TriggerClientEvent("Notify",source,"sucesso","Você pegou as munições de <b>MP5</b>.")
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