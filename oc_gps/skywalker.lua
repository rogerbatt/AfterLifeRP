local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("oc_gps",emP)
local rndexp = {10,20}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARM DE TECIDO MEDICO
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,3)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"admin.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	local rndMin,rndMax = table.unpack(rndexp)
	local rndResult = math.random(rndMin, rndMax)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"polvora",quantidade[source])
		quantidade[source] = nil
		return true
		end
	end
end