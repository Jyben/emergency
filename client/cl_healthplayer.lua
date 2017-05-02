--[[
################################################################
- Creator: Jyben
- Date: 30/04/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]

local isDead = false
local isKO = false

--[[
################################
            THREADS
################################
--]]

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    --ResurrectPlayerByEmergency(GetPlayerPed(-1)) -- DEBUG
    local playerPed = GetPlayerPed(-1)
    local playerID = PlayerId()
    local currentPos = GetEntityCoords(playerPed, true)
    local previousPos

    isDead = IsEntityDead(playerPed)

    if isKO and previousPos ~= currentPos then
      isKO = false
    end

    if (GetEntityHealth(playerPed) < 120 and not isDead and not isKO) then
      if (IsPedInMeleeCombat(playerPed)) then
        SetPlayerKO(playerID, playerPed)
      end
    end

    previousPos = currentPos
  end
end)

--[[
################################
            EVENTS
################################
--]]

-- Triggered when player died by environment
AddEventHandler('baseevents:onPlayerDied',
  function(playerId, reasonID)
    local reason = 'Tentative de suicide'
    TriggerEvent('es_em:playerInComa')
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('es_em:sendEmergency', reason, PlayerId(), pos.x, pos.y, pos.z)
    SendNotification('Vous êtes dans le coma !')
  end
)

-- Triggered when player died by an another player
AddEventHandler('baseevents:onPlayerKilled',
  function(playerId, playerKill, reasonID)
    local reason = GetStringReason(reasonID)
    TriggerEvent('es_em:playerInComa')
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('es_em:sendEmergency', reason, PlayerId(), pos.x, pos.y, pos.z)
    SendNotification('Vous êtes dans le coma !')
  end
)

--[[
################################
        BUSINESS METHODS
################################
--]]

function SetPlayerKO(playerID, playerPed)
  isKO = true
  SendNotification('Vous êtes KO !')
  SetPedToRagdoll(playerPed, 6000, 6000, 0, 0, 0, 0)
end

function ResurrectPlayerByEmergency(playerPed)
  SendNotification('Vous avez été réanimé')
  ResurrectPed(playerPed)
  SetEntityHealth(playerPed, GetPedMaxHealth(playerPed)/2)
  ClearPedTasksImmediately(playerPed)
end

function SendNotification(message)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(message)
  DrawNotification(false, false)
end

--[[
################################
        USEFUL METHODS
################################
--]]

function GetStringReason(reasonID)
  local reasonString = 'killed'

  if reasonID == 0 or reasonID == 56 or reasonID == 1 or reasonID == 2 then
    reasonIDString = 'meleed'
  elseif reasonID == 3 then
    reasonIDString = 'knifed'
  elseif reasonID == 4 or reasonID == 6 or reasonID == 18 or reasonID == 51 then
    reasonIDString = 'bombed'
  elseif reasonID == 5 or reasonID == 19 then
    reasonIDString = 'burned'
  elseif reasonID == 7 or reasonID == 9 then
    reasonIDString = 'pistoled'
  elseif reasonID == 10 or reasonID == 11 then
    reasonIDString = 'shotgunned'
  elseif reasonID == 12 or reasonID == 13 or reasonID == 52 then
    reasonIDString = 'SMGd'
  elseif reasonID == 14 or reasonID == 15 or reasonID == 20 then
    reasonIDString = 'assaulted'
  elseif reasonID == 16 or reasonID == 17 then
    reasonIDString = 'sniped'
  elseif reasonID == 49 or reasonID == 50 then
    reasonString = 'ran over'
  end

  return reasonString
end
