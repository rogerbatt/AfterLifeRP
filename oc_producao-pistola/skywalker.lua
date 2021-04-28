 
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-pistola",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "five" },
	{ item = "vp9" },
	{ item = "glock" }
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
				if item == "vp9" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_APPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-vp9") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 6 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 3 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpo-vp9",1) and vRP.tryGetInventoryItem(user_id,"placa-metal",6) and vRP.tryGetInventoryItem(user_id,"molas",3) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nu",source)

                                            TriggerClientEvent("progress",source,10000,"Montando VP9")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_APPISTOL",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>VP9</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de VP9</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "five" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-five") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 4 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpo-five",1) and vRP.tryGetInventoryItem(user_id,"placa-metal",4) and vRP.tryGetInventoryItem(user_id,"molas",2) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nu",source)

                                            TriggerClientEvent("progress",source,10000,"Montando FIVESEVEN")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>FIVESEVEN</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>2x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de fiveseven</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "glock" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_COMBATPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-glock") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 4 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpo-glock",1) and vRP.tryGetInventoryItem(user_id,"placa-metal",4) and vRP.tryGetInventoryItem(user_id,"molas",2) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nu",source)

                                            TriggerClientEvent("progress",source,10000,"Montando GLOCK")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMBATPISTOL",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>GLOCK</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>2x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de glock</b> na mochila.")
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
    if vRP.hasPermission(user_id,"lider-mafia.permissao") or vRP.hasPermission(user_id,"mafia.permissao") then
        return true
    end
end