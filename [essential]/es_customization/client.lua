local inCustomization = false

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local validTorso = {}
local validUnder = {}

function initValids()
			local am = 0
			for i = 0,GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 3) do				
				if IsPedComponentVariationValid(GetPlayerPed(-1), 3, i, 2) then
					am = am + 1
					validTorso[am] = i
				end
			end
			am = 0
			for i =0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 7) do
				if IsPedComponentVariationValid(GetPlayerPed(-1), 7, i, 2) then
					am = am + 1
					validUnder[am] = i

				end
			end
end

local options = {
	{
		id = 2,
		prettyName = "Hair",
		name = "hair",
		t = 'drawable',
		tid = 2,
		zoomOffset = 0.6,
		camOffset = 0.65,
		current = 0,
		max = function() 
			local am = 0
			for i = 1,GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 2) do
				if IsPedComponentVariationValid(GetPlayerPed(-1),  2,  i,  2) then

				end
			end
			return GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 2)
		end
	},
	{
		id = 2,
		t = 'texture',
		prettyName = "Hair Colour",
		name = "haircolour",
		zoomOffset = 0.6,
		camOffset = 0.65,
		current = 0,
		tid = 2,
		max = function() 
			return GetNumberOfPedTextureVariations(GetPlayerPed(-1), 2, GetPedDrawableVariation(GetPlayerPed(-1), 2)) - 1
		end
	},
	{
		id = 3,
		prettyName = "Torso",
		name = "torso",
		zoomOffset = 0.75,
		camOffset = 0.15,
		t = 'drawable',
		tid = 4,
		current = 0,
		max = function() 
			local am = 0
			for i = 0,GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 3) do				
				if IsPedComponentVariationValid(GetPlayerPed(-1), 3, i, 2) then
					am = am + 1
					validTorso[am] = i
				end
			end
			return am
		end
	},
	{
		id = 3,
		prettyName = "Torso Texture",
		name = "torsotexture",
		zoomOffset = 0.75,
		camOffset = 0.15,
		t = 'texture',
		current = 0,
		tid = 3,
		max = function() 
			return GetNumberOfPedTextureVariations(GetPlayerPed(-1), 3, GetPedDrawableVariation(GetPlayerPed(-1), 3)) - 1
		end
	},
	{
		id = 11,
		prettyName = "Torso Extra",
		name = "torsoextra",
		zoomOffset = 0.75,
		camOffset = 0.15,
		t = 'drawable',
		current = 0,
		tid = 6,
		max = function() 
			return GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 11)
		end
	},
	{
		id = 11,
		prettyName = "Torso Extra Texture",
		name = "torsoextratexture",
		zoomOffset = 0.75,
		camOffset = 0.15,
		t = 'texture',
		current = 0,
		tid = 11,
		max = function() 
			return GetNumberOfPedTextureVariations(GetPlayerPed(-1), 11, GetPedDrawableVariation(GetPlayerPed(-1), 11)) - 1
		end
	},
	{
		id = 4,
		prettyName = "Pants",
		name = "pants",
		camOffset = -0.5,
		zoomOffset = 0.8,
		t = 'drawable',
		current = 0,
		tid = 8,
		max = function() 
			return GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 4)
		end
	},
	{
		id = 4,
		prettyName = "Pants Colour",
		name = "pantscolour",
		t = 'texture',
		current = 0,
		camOffset = -0.5,
		zoomOffset = 0.8,
		tid = 4,
		max = function() 
			return GetNumberOfPedTextureVariations(GetPlayerPed(-1), 4, GetPedDrawableVariation(GetPlayerPed(-1), 4)) - 1
		end
	},
	{
		id = 6,
		prettyName = "Shoes",
		name = "shoes",
		t = 'drawable',
		camOffset = -0.8,
		zoomOffset = 0.8,
		current = 0,
		tid = 10,
		max = function() 
			return GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 6)
		end
	},
	{
		id = 6,
		prettyName = "Shoes Colour",
		name = "shoescolour",
		camOffset = -0.8,
		zoomOffset = 0.8,
		t = 'texture',
		current = 0,
		tid = 6,
		max = function() 
			return GetNumberOfPedTextureVariations(GetPlayerPed(-1), 6, GetPedDrawableVariation(GetPlayerPed(-1), 6)) - 1
		end
	},
	{
		id = 7, -- 11
		prettyName = "Body Accosoire",
		name = "bodyaccesoire",
		camOffset = 0.35,
		zoomOffset = 0.6,
		t = 'drawable',
		current = 0,
		max = function() 
			local am = 0
			for i =0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 7) do
				if IsPedComponentVariationValid(GetPlayerPed(-1), 7, i, 2) then
					am = am + 1
					validUnder[am] = i

				end
			end
			return am
		end
	},
	{
		id = 8, -- 12
		prettyName = "Under shirt",
		name = "undershirt",
		camOffset = 0.35,
		zoomOffset = 0.6,
		t = 'drawable',
		current = 0,
		max = function() 
			return GetNumberOfPedDrawableVariations(GetPlayerPed(-1),  8)
		end
	},
	{
		id = 9, -- 13
		prettyName = "Armor",
		name = "armor",
		camOffset = 0.35,
		zoomOffset = 0.6,
		t = 'drawable',
		current = 0,
		max = function() 
			return GetNumberOfPedDrawableVariations(GetPlayerPed(-1),  9)
		end
	},
	{
		id = 25, -- 13
		prettyName = "Save",
		t = 'save',
		camOffset = -0.1,
		zoomOffset = 1.8,
		current = 0,
		max = function() 
			return "250 pounds"
		end
	},
	{
		id = 26,
		prettyName = "Exit",
		t = 'exit',
		current = 0,
		camOffset = -0.1,
		zoomOffset = 1.8,
		max = function()
		return ""
		end
	}
}

local clothingStores = {
	{ ['x'] = 1864.4403076172, ['y'] = 3747.3469238281, ['z'] = 33.031894683838 },
	{ ['x'] = 1693.2647705078, ['y'] = 4822.2797851563, ['z'] = 42.063091278076 },
	{ ['x'] = 125.83338165283, ['y'] = -223.16986083984, ['z'] = 54.55782699585 },
	{ ['x'] = -710.16009521484, ['y'] = -153.26420593262, ['z'] = 37.415138244629 },
	{ ['x'] = -821.69067382813, ['y'] = -1073.900390625, ['z'] = 11.328099250793 },
	{ ['x'] = -1192.8112792969, ['y'] = -768.24377441406, ['z'] = 17.319314956665 },
	{ ['x'] = 4.2589497566223, ['y'] = 6512.8803710938, ['z'] = 31.877851486206 },
}

Citizen.CreateThread(function()
	for k,v in ipairs(clothingStores)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 73)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Customize Player")
		EndTextCommandSetBlipName(blip)
	end
end)

local selected = 1
local camOffset = 0.65
local zoomOffset = 0.6

local old = 0
local cur = "customCam"
local heading = 90.0


Citizen.CreateThread(function()
	local customCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	local customCam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)

	SetCamRot(customCam, 0.0, 0.0, 270.0, true)
	SetCamRot(customCam2, 0.0, 0.0, 270.0, true)

	while true do
		Citizen.Wait(0)


		local pos = GetEntityCoords(GetPlayerPed(-1), false)

			if inCustomization then
				if(not IsCamActive(customCam) and not IsCamActive(customCam2))then
					SetCamActive(customCam, true)
				end

				for i = 0,32 do
					if(NetworkIsPlayerActive(i))then
						if(GetPlayerPed(i) ~= GetPlayerPed(-1))then
							SetEntityVisible(GetPlayerPed(i), false)
						end
					end
				end

				SetPedCanHeadIk(GetPlayerPed(-1), false)

				DisableControlAction(1, 9, true)
				DisableControlAction(1, 32, true)
				DisableControlAction(1, 8, true)
				DisableControlAction(1, 34, true)

				local Poz = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, zoomOffset, camOffset)

				TaskLookAtCoord(GetPlayerPed(-1), Poz.x, Poz.y, Poz.z, 1, 0, 2)
				SetEntityHeading(GetPlayerPed(-1), heading)

				DrawRect(0.153, 0.108, 0.245, 0.08, 0, 0, 0, 100)
				drawTxt(0.530, 0.56, 1.0,1.0,0.81, "Player Customization", 255, 255, 255, 255)
				drawTxt(0.530, 0.61, 1.0,1.0,0.41, "Part", 200, 200, 200, 255)
				drawTxt(0.695, 0.61, 1.0,1.0,0.41, "Current/Max", 200, 200, 200, 255)
				local t = 0
				for k,v in ipairs(options)do
					t = t + 1
					if(t ~= selected)then
						DrawRect(0.153, 0.12939 + (t * 0.037),  0.245,  0.037,  100,  100, 100,  200)
					end

					if(old ~= selected)then
						local p = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, options[selected].zoomOffset, options[selected].camOffset)

						if(cur == "customCam")then
							SetCamCoord(customCam2,  p.x, p.y, p.z)
						else
							SetCamCoord(customCam,  p.x, p.y, p.z)
						end

						if(cur == "customCam2")then
							SetCamActiveWithInterp(customCam, customCam2, 400, 0, 0)
							
							cur = "customCam"
						else
							SetCamActiveWithInterp(customCam2, customCam, 400, 0, 0)

							cur = "customCam2"
						end

						old = selected
					end

					DrawRect(0.153, 0.12939 + (selected * 0.037),  0.245,  0.037,  200,  200, 200,  200)
					drawTxt(0.530, 0.61 + (t * 0.037), 1.0,1.0,0.37, "" .. v.prettyName, 255, 255, 255, 255, true)
					if(v.t == "save" or v.t == "exit")then
						drawTxt(0.695, 0.61 + (t * 0.037), 1.0,1.0,0.37, "" .. v.max(), 255, 255, 255, 255, true)
					else
						drawTxt(0.695, 0.61 + (t * 0.037), 1.0,1.0,0.37, "" .. v.current .. " / " .. v.max(), 255, 255, 255, 255, true)
					end
				end

				DisplayHelpText("Controls ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ ~INPUT_CELLPHONE_RIGHT~ ~INPUT_CELLPHONE_LEFT~")

				DisableControlAction(1, 27, true)
				if(IsControlJustPressed(1, 172)) then -- Up
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					if(selected ~= 1)then
						selected = selected - 1
					else
						selected = returnIndexesInTable(options)
					end
				elseif(IsControlJustPressed(1, 173)) then -- Down
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					if(selected ~= returnIndexesInTable(options))then
						selected = selected + 1
					else
						selected = 1
					end
				elseif(IsControlJustPressed(1, 175)) then -- Right
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					local sel = 0
					for k,v in pairs(options) do
						sel = sel + 1
						if(sel == selected)then
							if(true)then
								
								if(options[k].t == 'drawable')then
									if(options[k].current ~= options[k].max())then
										options[k].current = options[k].current + 1
									else
										options[k].current = 0
									end
									if(k == 3)then
										if IsPedComponentVariationValid(GetPlayerPed(-1), options[k].id, validTorso[options[k].current], 2)then
											SetPedComponentVariation(GetPlayerPed(-1), options[k].id, validTorso[options[k].current], 1, 2)
											if options[k].tid then
												options[options[k].tid].current = 1
											end
										end
									elseif(k == 11)then
										if IsPedComponentVariationValid(GetPlayerPed(-1), options[k].id, validUnder[options[k].current], 2)then
											SetPedComponentVariation(GetPlayerPed(-1), options[k].id, validUnder[options[k].current], 1, 2)
											if options[k].tid then
												options[options[k].tid].current = 1
											end
										end
									else
										if IsPedComponentVariationValid(GetPlayerPed(-1), options[k].id, options[k].current, 2)then
											SetPedComponentVariation(GetPlayerPed(-1), options[k].id, options[k].current, 1, 2)
											if options[k].tid then
												options[options[k].tid].current = 1
											end
										end
									end
								elseif(options[k].t == 'texture')then
									if(options[k].current ~= options[k].max())then
										options[k].current = options[k].current + 1
									else
										options[k].current = 0
									end
									SetPedComponentVariation(GetPlayerPed(-1), options[k].tid, GetPedDrawableVariation(GetPlayerPed(-1), options[k].tid), options[k].current, 2)
								elseif(options[k].t == "save")then
									local user = {
										hair = options[1].current,
										haircolour = options[2].current,
										torso = options[3].current,
										torsotexture = options[4].current,
										torsoextra = options[5].current,
										torsoextratexture = options[6].current,
										pants = options[7].current,
										pantscolour = options[8].current,
										shoes = options[9].current,
										shoescolour = options[10].current,
										bodyaccesoire = options[11].current,
										undershirt = options[12].current,
										armor = options[13].current
									}

									TriggerServerEvent("es_customization:saveUser", user)
								elseif(options[k].t == "exit")then
									inCustomization = false
									local pos = GetEntityCoords(GetPlayerPed(-1), false)
									SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z - 101.0)
									FreezeEntityPosition(GetPlayerPed(-1), false)
									SetCamActive(customCam, true)
									RenderScriptCams(0, 0, customCam,  true,  true)

									SetPedCanHeadIk(GetPlayerPed(-1), true)
								end
							end
						end
					end
				elseif(IsControlJustPressed(1, 174)) then -- Left
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					local sel = 0
					for k,v in pairs(options) do
						sel = sel + 1
						if(sel == selected)then
							if(true)then
								if(options[k].current ~= 0)then
									options[k].current = options[k].current - 1
								else
									options[k].current = options[k].max()
								end
								if(options[k].t == 'drawable')then
									if(k == 3)then
										if IsPedComponentVariationValid(GetPlayerPed(-1), options[k].id, validTorso[options[k].current], 2)then
											SetPedComponentVariation(GetPlayerPed(-1), options[k].id, validTorso[options[k].current], 1, 2)
											if options[k].tid then
												options[options[k].tid].current = 1
											end
										end
									elseif(k == 11)then
										if IsPedComponentVariationValid(GetPlayerPed(-1), options[k].id, validUnder[options[k].current], 2)then
											SetPedComponentVariation(GetPlayerPed(-1), options[k].id, validUnder[options[k].current], 1, 2)
											if options[k].tid then
												options[options[k].tid].current = 1
											end
										end
									else
										if IsPedComponentVariationValid(GetPlayerPed(-1), options[k].id, options[k].current, 2)then
											SetPedComponentVariation(GetPlayerPed(-1), options[k].id, options[k].current, 1, 2)
											if options[k].tid then
												options[options[k].tid].current = 1
											end
										else
											if (k == 13 and options[13].current == 0)then
												SetPedComponentVariation(GetPlayerPed(-1), options[k].id,  0,  0,  0)
											end
										end
									end
								elseif(options[k].t == 'texture')then
									SetPedComponentVariation(GetPlayerPed(-1), options[k].tid, GetPedDrawableVariation(GetPlayerPed(-1), options[k].tid), options[k].current, 2)
								end
							end
						end
					end
				end
			end

		for _,d in ipairs(clothingStores)do
			if Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < 20.0 then
				DrawMarker(1, d.x, d.y, d.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 255, 0,155, 0,0, 0,0)
			end

			if(Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < 1.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to customize your player.")
			end

			if(IsControlJustPressed(1, 51) and Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < 1.0)then
				local pos = GetEntityCoords(GetPlayerPed(-1), false)
				SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z + 100.0)
				FreezeEntityPosition(GetPlayerPed(-1), true)

				pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, options[selected].zoomOffset, options[selected].camOffset)
				SetCamCoord(customCam, pos.x, pos.y, pos.z)
				heading = 90.0
				SetCamActive(customCam, true)
				RenderScriptCams(1, 0, customCam,  true,  true)
				
				inCustomization = true
			end

		end
	end
end)

local components = {
	{ name = 'hair', t = 2},
	{ name = 'torso', t = 3},
	{ name = 'torsoextra', t = 11},
	{ name = 'pants', t = 4},
	{ name = 'shoes', t = 6},
	{ name = 'bodyaccesoire', t = 7},
	{ name = 'undershirt', t = 8},
	{ name = 'armor', t = 9}
}

local typeOfComponent = {
	hair = 'haircolour',
	torso = 'torsotexture',
	torsoextra = 'torsoextratexture',
	pants = 'pantscolour',
	shoes = 'shoescolour',
}

RegisterNetEvent("es_customization:setOutfit")
AddEventHandler("es_customization:setOutfit", function(u)
	initValids()
	
	for k,v in ipairs(options)do
		options[k].current = u[options[k].name]
	end

	for k,v in ipairs(components)do
		local te = u[typeOfComponent[v.name]]
		if(te == nil)then
			te = 1
		end
		if(u[k] ~= 0)then
			if(v.name == "torso")then
				SetPedComponentVariation(GetPlayerPed(-1),  v.t,  validTorso[u[v.name]],  te,  2)
			elseif(v.name == "undershirt")then
				SetPedComponentVariation(GetPlayerPed(-1),  v.t,  validUnder[u[v.name]],  te,  2)
			else
				SetPedComponentVariation(GetPlayerPed(-1),  v.t,  u[v.name],  te,  2)
			end
		end
	end

	
end)

function returnIndexesInTable(t)
	local i = 0;
	for _,v in pairs(t)do
 		i = i + 1
	end
	return i;
end