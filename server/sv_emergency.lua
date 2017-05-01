RegisterServerEvent('es_em:sendEmergency')
AddEventHandler('es_em:sendEmergency', function(reason, playerId, position)
  TriggerClientEvent('es_em:emergencyNotification', reason, position)
end)
