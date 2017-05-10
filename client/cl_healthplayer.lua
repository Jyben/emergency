--[[
################################################################
- Creator: Jyben
- Date: 30/04/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

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
    --NetworkResurrectLocalPlayer(357.757, -597.202, 28.6314, true, true, false)
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
    local pos = GetEntityCoords(GetPlayerPed(-1))

    SendNotification('Vous êtes dans le coma !')
    SendNotification('Appuyez sur E pour appeler une ambulance')
    SendNotification('Appuyez sur X pour respawn')
    TriggerEvent('es_em:playerInComa')

    Citizen.CreateThread(
    	function()
        local res = false

        while not res do
    			Citizen.Wait(1)
          if (IsControlJustReleased(1, Keys['E'])) then
            TriggerServerEvent('es_em:sendEmergency', reason, PlayerId(), pos.x, pos.y, pos.z)
            res = true
          elseif (IsControlJustReleased(1, Keys['X'])) then
            NetworkResurrectLocalPlayer(357.757, -597.202, 28.6314, true, true, false)
            res = true
          end
        end
    end)
  end
)

-- Triggered when player died by an another player
AddEventHandler('baseevents:onPlayerKilled',
  function(playerId, playerKill, reasonID)
    local reason = GetStringReason(reasonID)
    local pos = GetEntityCoords(GetPlayerPed(-1))

    SendNotification('Vous êtes dans le coma !')
    SendNotification('Appuyez sur E pour appeler une ambulance')
    SendNotification('Appuyez sur X pour respawn')
    TriggerEvent('es_em:playerInComa')

    Citizen.CreateThread(
      function()
        local res = false

        while not res do
          Citizen.Wait(1)
          if (IsControlJustReleased(1, Keys['E'])) then
            TriggerServerEvent('es_em:sendEmergency', reason, PlayerId(), pos.x, pos.y, pos.z)
            res = true
          elseif (IsControlJustReleased(1, Keys['X'])) then
            NetworkResurrectLocalPlayer(357.757, -597.202, 28.6314, true, true, false)
            res = true
          end
        end
    end)
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
