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
    local players = GetPlayers()
    for k, v in pairs(players) do
      TriggerClientEvent('es_em:sendEmergencyToDocs', v, reason, playerIDInComa, x, y, z)
    end
  end
)

RegisterServerEvent('es_em:getTheCall')
AddEventHandler('es_em:getTheCall',
  function(playerName, playerID)
    local players = GetPlayers()
    for k, v in pairs(players) do
      TriggerClientEvent('es_em:callTaken', v, playerName, playerID)
    end
  end)
