RegisterNetEvent('Notify')
AddEventHandler('Notify', function(mtype, mtext)
	SendNUIMessage({
        mtype = mtype,
        mtext = mtext
    })
   -- TriggerEvent("vrp_sound:source",'notify',1)
end)