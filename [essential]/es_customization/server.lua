local savedOutfits = {}

require "resources/essentialmode/lib/MySQL"
-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("127.0.0.1", "gta5_script_customization", "root", "monpasse")

RegisterServerEvent("es_customization:saveUser")
AddEventHandler("es_customization:saveUser", function(u)
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local executed_query = MySQL:executeQuery("SELECT * FROM outfits WHERE identifier = '@name'", {['@name'] = target.identifier})
		local result = MySQL:getResults(executed_query, {'identifier', 'hair', 'haircolour', 'torso', 'torsotexture', 'torsoextra', 'torsoextratexture', 'pants', 'pantscolour', 'shoes', 'shoescolour', 'bodyaccesoire', 'undershirt', 'armor'}, "identifier")

		if(result[1] == nil)then
			MySQL:executeQuery("INSERT INTO outfits (`identifier`,`hair`, `haircolour`, `torso`, `torsotexture`, `torsoextra`, `torsoextratexture`, `pants`, `pantscolour`, `shoes`, `shoescolour`, `bodyaccesoire`, `undershirt`, `armor`) VALUES ('@username', @haxczsdasir, @cdasdwad, @dasvdvsadewq, @qadsad, @jhgjghlyuy, @khgfhfg, @hgerqw, @bxcvxc, @jgdfgdfg, @mbcvfd, @lfoerp, @yruiqwdas, @czxczxdasd)",
			{['@username'] = target.identifier, ['@haxczsdasir']= u.hair, ['@cdasdwad'] = u.haircolour, ['@dasvdvsadewq'] = u.torso, ['@qadsad'] = u.torsotexture, ['@jhgjghlyuy'] = u.torsoextra, ['@khgfhfg'] = u.torsoextratexture, ['@hgerqw'] = u.pants, ['@bxcvxc'] = u.pantscolour, ['@jgdfgdfg'] = u.shoes, ['@mbcvfd'] = u.shoescolour, ['@lfoerp'] = u.bodyaccesoire, ['@yruiqwdas'] = u.undershirt, ['@czxczxdasd'] = u.armor})
		else
			print(u.haircolour)
			MySQL:executeQuery("UPDATE outfits SET `hair`='@haxczsdasir', `haircolour`='@cdasdwad', `torso` = '@dasvdvsadewq', `torsotexture` = '@qadsad', `torsoextra` = '@jhgjghlyuy', `torsoextratexture` = '@khgfhfg', `pants` = '@hgerqw', `pantscolour` = '@bxcvxc', `shoes` = '@jgdfgdfg', `shoescolour` = '@mbcvfd', `bodyaccesoire` = '@lfoerp', `undershirt` = '@yruiqwdas', `armor` = '@czxczxdasd' WHERE identifier = '@name'",
			{['@name'] = target.identifier, ['@haxczsdasir']= u.hair, ['@cdasdwad'] = u.haircolour, ['@dasvdvsadewq'] = u.torso, ['@qadsad'] = u.torsotexture, ['@jhgjghlyuy'] = u.torsoextra, ['@khgfhfg'] = u.torsoextratexture, ['@hgerqw'] = u.pants, ['@bxcvxc'] = u.pantscolour, ['@jgdfgdfg'] = u.shoes, ['@mbcvfd'] = u.shoescolour, ['@lfoerp'] = u.bodyaccesoire, ['@yruiqwdas'] = u.undershirt, ['@czxczxdasd'] = u.armor})
		end

		target:removeMoney(250)

		savedOutfits[source] = u

		TriggerClientEvent("chatMessage", source, "CLOTHING", {255, 0, 0}, "You saved your outfit, it will stay forever even if you reconnect. You can change it back at a clothing store.")
	end)
end)

AddEventHandler("es_customization:setToPlayerSkin", function(source)
	if(savedOutfits[source] == nil)then
		TriggerEvent("es:getPlayerFromId", source, function(target)
			local executed_query = MySQL:executeQuery("SELECT * FROM outfits WHERE identifier = '@name'", {['@name'] = target.identifier})
			local result = MySQL:getResults(executed_query, {'identifier', 'hair', 'haircolour', 'torso', 'torsotexture', 'torsoextra', 'torsoextratexture', 'pants', 'pantscolour', 'shoes', 'shoescolour', 'bodyaccesoire', 'undershirt', 'armor'}, "identifier")

			if(result[1] ~= nil)then
				result[1].identifier = nil

				savedOutfits[source] = result[1]
				TriggerClientEvent("es_customization:setOutfit", source, savedOutfits[source])
			else
				local default = {
					hair = 1,
					haircolour = 3,
					torso = 0,
					torsotexture = 0,
					torsoextra = 0,
					torsoextratexture = 0,
					pants = 0,
					pantscolour = 0,
					shoes = 0,
					shoescolour = 0,
					bodyaccesoire = 0,
					undershirt = 0,
					armor = 0
				}
				TriggerClientEvent("es_customization:setOutfit", source, default)
			end
		end)
	end

	if(savedOutfits[source])then
		TriggerClientEvent("es_customization:setOutfit", source, savedOutfits[source])
	end
end)

RegisterServerEvent("playerSpawn")
AddEventHandler("playerSpawn", function()
	if(savedOutfits[source] == nil)then
		TriggerEvent("es:getPlayerFromId", source, function(target)
			local executed_query = MySQL:executeQuery("SELECT * FROM outfits WHERE identifier = '@name'", {['@name'] = target.identifier})
			local result = MySQL:getResults(executed_query, {'identifier', 'hair', 'haircolour', 'torso', 'torsotexture', 'torsoextra', 'torsoextratexture', 'pants', 'pantscolour', 'shoes', 'shoescolour', 'bodyaccesoire', 'undershirt', 'armor'}, "identifier")

			if(result[1] ~= nil)then
				result[1].identifier = nil

				savedOutfits[source] = result[1]
				TriggerClientEvent("es_customization:setOutfit", source, savedOutfits[source])
			else
				local default = {
					hair = 1,
					haircolour = 3,
					torso = 0,
					torsotexture = 0,
					torsoextra = 0,
					torsoextratexture = 0,
					pants = 0,
					pantscolour = 0,
					shoes = 0,
					shoescolour = 0,
					bodyaccesoire = 0,
					undershirt = 0,
					armor = 0
				}
				TriggerClientEvent("es_customization:setOutfit", source, default)
			end
		end)
	end

	if(savedOutfits[source])then
		TriggerClientEvent("es_customization:setOutfit", source, savedOutfits[source])
	end
end)

AddEventHandler("playerDropped", function()
	savedOutfits[source] = nil
end)
