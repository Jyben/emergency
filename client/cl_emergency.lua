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

Citizen.CreateThread(function()
  local x = 1155.26
  local y = -1520.82
  local z = 34.84

  while true do
    Citizen.Wait(1)

    local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
    --Citizen.Trace(Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z))
    if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 100.0) then
      -- Service
      DrawMarker(1, x, y, z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
      -- Service car
      DrawMarker(1, 1201.45, -1546.57, 39.4022 - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)

      if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 2.0) then
        DisplayHelpText("Press ~INPUT_CONTEXT~ to start your job")

        if (IsControlJustReleased(1, 51)) then
          SendNotification("Début du service")
          local model = GetHashKey('s_m_m_paramedic_01')

          RequestModel(model)
          while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
          end

          SetPlayerModel(PlayerId(), model)
          SetModelAsNoLongerNeeded(model)
        end
      end
    end


  end
end)

Citizen.CreateThread(function()
  local x = 1140.41
  local y = -1608.15
  local z = 34.6939
  -- 282.858
  -- -1424.29
  -- 29.6249

  while true do
    Citizen.Wait(1)

    local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

    if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 100.0) then
      -- Service car
      DrawMarker(1, x, y, z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)

      if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 2.0) then
        DisplayHelpText("Press ~INPUT_CONTEXT~ to get an emergency car")

        if (IsControlJustReleased(1, 51)) then
          SpawnAmbulance()
        end

      end
    end
  end
end)

RegisterNetEvent('es_em:emergencyNotification')
AddEventHandler('es_em:emergencyNotification', function(reason, position)
  job = 'emergency'
  Citizen.Trace('test')
  if job == 'emergency' then
    SendNotification('<b>EMERGENCY | Reason: </b>' .. reason)
    SendNotification('Press Y to get the call')

    if IsControlPressed(1, Keys["Y"]) then
      TriggerServerEvent('es_em:getTheCall', PlayerId())
    end

  end
end)

function SpawnAmbulance()
  Citizen.Wait(0)
  local myPed = GetPlayerPed(-1)
  local player = PlayerId()
  local vehicle = GetHashKey('ambulance')

  RequestModel(vehicle)

  while not HasModelLoaded(vehicle) do
    Wait(1)
  end

  local plate = math.random(100, 900)
  local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
  local spawned_car = CreateVehicle(vehicle, coords, 431.436, - 996.786, 25.1887, true, false)

  SetVehicleOnGroundProperly(spawned_car)
  SetVehicleNumberPlateText(spawned_car, "MEDIC")
  SetPedIntoVehicle(myPed, spawned_car, - 1)
  SetModelAsNoLongerNeeded(vehicle)
  Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function DisplayHelpText(str)
  SetTextComponentFormat("STRING")
  AddTextComponentString(str)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function SendNotification(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(message)
  DrawNotification(false, false)
end
