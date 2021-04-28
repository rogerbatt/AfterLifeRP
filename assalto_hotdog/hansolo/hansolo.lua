
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
roB = Tunnel.getInterface("assalto_hotdog")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
local emprocesso = false
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 1604.51, ['y'] = 3828.21, ['z'] = 34.5, ['h'] = 144.73 },
	{ ['id'] = 2, ['x'] = 1606.82, ['y'] = 3825.16, ['z'] = 34.86, ['h'] = 203.09 },
	{ ['id'] = 3, ['x'] = 2082.63, ['y'] = 3553.54, ['z'] = 42.24, ['h'] = 344.55 },
	{ ['id'] = 4, ['x'] = 1983.64, ['y'] = 3705.25, ['z'] = 32.57, ['h'] = 7.9 },
	{ ['id'] = 5, ['x'] = 1967.74, ['y'] = 3259.75, ['z'] = 45.92, ['h'] = 324.55 },
	{ ['id'] = 6, ['x'] = 2465.9, ['y'] = 3829.66, ['z'] = 40.26, ['h'] = 117.68 },
	{ ['id'] = 7, ['x'] = -1042.15, ['y'] = 5326.16, ['z'] = 44.61, ['h'] = 307.0 },
	{ ['id'] = 8, ['x'] = 1087.01, ['y'] = 6510.71, ['z'] = 21.06, ['h'] = 90.46 },
	{ ['id'] = 9, ['x'] = 2473.87, ['y'] = 4444.69, ['z'] = 35.43, ['h'] = 179.60 },
	{ ['id'] = 10, ['x'] = 1262.02, ['y'] = 3547.21, ['z'] = 35.13, ['h'] = 100.35 },
	{ ['id'] = 11, ['x'] = -2510.95, ['y'] = 3614.53, ['z'] = 13.69, ['h'] = 167.10 },
	{ ['id'] = 12, ['x'] = -271.37, ['y'] = 6074.22, ['z'] = 31.69, ['h'] = 182.92 },
	{ ['id'] = 13, ['x'] = 151.79, ['y'] = 6505.77, ['z'] = 31.84, ['h'] = 220.21 },
	{ ['id'] = 14, ['x'] = -3026.94, ['y'] = 368.74, ['z'] = 14.62, ['h'] = 166.79 },
}

-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUBO ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				local registradora = locais[k]

				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), registradora.x, registradora.y, registradora.z, true ) < 0.5 and not emprocesso then
					DrawText3D(registradora.x, registradora.y, registradora.z, "~w~[~r~E~w~] Para iniciar o ~r~ROUBO")
				end

				if Vdist(v.x,v.y,v.z,x,y,z) < 1.2 and not andamento then
					idle = 5
					if IsControlJustPressed(0,38) then
						roB.checkRobbery(v.id,v.x,v.y,v.z,v.h)
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

RegisterNetEvent("iniciohotdog")
AddEventHandler("iniciohotdog",function(head,x,y,z)
	segundos = 30
	andamento = true
	teste = true
	SetEntityHeading(PlayerPedId(),head)
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent('cancelando',true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				emprocesso = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end