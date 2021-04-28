local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("oc_gps")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARM DE TECIDO MEDICO
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 1108.2 --- 1108.2, -2034.41, 31.0
local CoordenadaY = -2034.41
local CoordenadaZ = 31.0
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 1110.31, ['y'] = -2035.87, ['z'] = 33.51 }, 
	[2] = { ['x'] = 1110.64, ['y'] = -2037.32, ['z'] = 33.51 }, 
	[3] = { ['x'] = 1109.38, ['y'] = -2036.54, ['z'] = 33.36 }, 
	[4] = { ['x'] = 1117.48, ['y'] = -2043.07, ['z'] = 33.46 }, 
	[5] = { ['x'] = 1117.59, ['y'] = -2044.87, ['z'] = 33.51 }, 
	[6] = { ['x'] = 1118.27, ['y'] = -2044.92, ['z'] = 33.54 }, 
	[7] = { ['x'] = 1110.31, ['y'] = -2035.87, ['z'] = 33.51 }, 
	[8] = { ['x'] = 1110.64, ['y'] = -2037.32, ['z'] = 33.51 }, 
	[9] = { ['x'] = 1109.38, ['y'] = -2036.54, ['z'] = 33.36 }, 
	[10] = { ['x'] = 1117.48, ['y'] = -2043.07, ['z'] = 33.46 }, 
	[11] = { ['x'] = 1117.59, ['y'] = -2044.87, ['z'] = 33.51 }, 
	[12] = { ['x'] = 1118.27, ['y'] = -2044.92, ['z'] = 33.54 }, 	
	[13] = { ['x'] = 1110.64, ['y'] = -2037.32, ['z'] = 33.51 }, 
	[14] = { ['x'] = 1109.38, ['y'] = -2036.54, ['z'] = 33.36 }, 
	[15] = { ['x'] = 1117.48, ['y'] = -2043.07, ['z'] = 33.46 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 3 then
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,204,0,204,80,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INCIAR A COLETA PÓLVORA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = math.random(15)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você iniciou a coleta.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			
			if distance <= 3 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,204,0,204,80,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR PÓLVORA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
						if emP.checkPayment() then
							TriggerEvent('cancelando',true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 10
							vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
							while true do
								if backentrega == selecionado then
									selecionado = math.random(15)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,167) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você encerrou as coletas de pólvora.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar Pólvora")
	EndTextCommandSetBlipName(blips)
end