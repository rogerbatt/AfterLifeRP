local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-municoes",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local municoes = {
	{ item = "m-vp9" },
	{ item = "m-five" },
	{ item = "m-glock" }
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
				if item == "m-vp9" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_APPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 10 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",10) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE AK47")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_APPISTOL",100)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições de VP9</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-five" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 10 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",10) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE FIVESEVEN")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL_MK2",100)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições FIVESEVEN</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-glock" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_COMBATPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 10 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",10) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE GLOCK")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_COMBATPISTOL",100)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Glock</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
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
    if vRP.hasPermission(user_id,"lifer-mafia.permissao") or vRP.hasPermission(user_id,"mafia.permissao") then
        return true
    end
end