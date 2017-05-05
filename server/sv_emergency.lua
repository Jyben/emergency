--[[
################################################################
- Creator: Jyben
- Date: 02/05/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]

RegisterServerEvent('es_em:sendEmergency')
AddEventHandler('es_em:sendEmergency',
  function(reason, playerIDInComa, x, y, z)
    print('emergency')
    for v = 0, 31, 1 do
      TriggerClientEvent('es_em:sendEmergencyToDocs', v, reason, playerIDInComa, x, y, z, source)
    end
  end
)

RegisterServerEvent('es_em:getTheCall')
AddEventHandler('es_em:getTheCall',
  function(playerName, playerID)
    print('getthecall')
    for v = 0, 31, 1 do
      TriggerClientEvent('es_em:callTaken', v, playerName, playerID)
    end
  end
)

RegisterServerEvent('es_em:sv_resurectPlayer')
AddEventHandler('es_em:sv_resurectPlayer',
  function(sourcePlayerInComa)
    print('res')
    TriggerClientEvent('es_em:cl_resurectPlayer', sourcePlayerInComa)
  end
)
