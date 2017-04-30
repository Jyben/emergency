local isDead = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)

    local playerPed = GetPlayerPed(-1)
    local playerID = PlayerId()

    isDead = IsEntityDead(playerPed)

    if (GetEntityHealth(playerPed) < 120) then
      -- This part of code can be glitched by the player:
      -- if he's in melee combat while an another guy shoot him,
      -- he will be KO instead of being in a coma
      if (IsPedInMeleeCombat(playerPed)) then
        SetPlayerKO(playerID, playerPed)
      elseif isDead then
        SendNotification("Vous êtes dans le coma !")
        -- TODO Add an event with Emergency
        if true == true then
          ResurrectPlayerByEmergency(playerPed)
        end
      end
    end
  end
end)

function SetPlayerKO(playerID, playerPed)
  SendNotification("Vous êtes KO !")
  --SetPlayerInvincible(playerID, true)
  SetPedToRagdoll(playerPed, 6000, 6000, 0, 0, 0, 0)
  Citizen.Wait(6000)
  SetEntityHealth(playerPed, GetPedMaxHealth(playerPed)/2)
  --SetPlayerInvincible(playerID, false)
end

function ResurrectPlayerByEmergency(playerPed)
  SendNotification("Vous avez été réanimé")
  ResurrectPed(playerPed)
  SetEntityHealth(playerPed, GetPedMaxHealth(playerPed)/2)
  ClearPedTasksImmediately(playerPed)
end

function SendNotification(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(message)
  DrawNotification(false, false)
end
