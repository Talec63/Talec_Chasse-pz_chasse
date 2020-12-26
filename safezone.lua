-- Made by Talec

local zones = {
	{ ['x'] = -1532.16, ['y'] = 4438.59, ['z'] = 7.89},
	{ ['x'] = -1494.71, ['y'] = 4980.78, ['z'] = 63.12}

}

local InZone = false
local HorsZone = false
local closestZone = 1

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		-- Vous pouvez ici changer le rayon de la zone

		if dist <= 500.0 then  
			if not InZone then																		
				NetworkSetFriendlyFireOption(false)
				ESX.ShowNotification('Vous êtes ~g~en zone de chasse')
				InZone = true
				HorsZone = false
			end
		else
			if not HorsZone then
				NetworkSetFriendlyFireOption(true)
				ESX.ShowNotification("Vous n'êtes ~r~plus en zone de chasse")
				RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_DAGGER"))
				RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_DBSHOTGUN"))
				ESX.ShowNotification("Vos armes de chasse ont été ~r~supprimés")
				HorsZone = true
				InZone = false
			end
		end
		if InZone then
			SetEntityInvincible(PlayerPedId(), true)
		end
	end
end)