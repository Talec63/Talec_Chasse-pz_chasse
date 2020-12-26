-- Made by Talec

print('Script start, made by Talec')

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

-- Initilisation d'esx

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

-- Fonctions
	

function ChargerModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end
function ShowHelpNotification(msg, thisFrame)
	AddTextEntry('HelpNotification', msg)
	DisplayHelpTextThisFrame('HelpNotification', false)
end

function drawCenterText(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -1495.52, 4977.71, 63.38, 187.3, GetEntityHeading(PlayerPedId()), true, false)

    
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
    
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())


	ESX.ShowNotification('Vous avez ~g~réussi~s~ à depecer cet animal')

	TriggerServerEvent('talec:additem')

	DeleteEntity(AnimalId)
	print(cuir)
	print(viande)
end

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        ESX.ShowNotification( "~r~Echec, reessayez..." )

        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            if ( not DoesEntityExist( veh ) ) then 
                ESX.ShowNotification( "~g~Vehicule supprimé." )
            end 

            timeout = timeout + 1 
            Citizen.Wait( 500 )

            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                ESX.ShowNotification( "~r~Echec après " .. timeoutMax .. " essaies." )
            end 
        end 
    else 
        ESX.ShowNotification( "~g~Vehicule supprimé." )
    end 
end 

local distanceToCheck = 5.0

local numRetries = 5

RegisterNetEvent( "talec:supprv" )
AddEventHandler( "talec:supprv", function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                ESX.ShowNotification( "Vous devez être sur le siège avant" )
            end 
        else
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( ped, pos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                ESX.ShowNotification( "~y~Vous devez être dans le véhicule pour le supprimer." )
            end 
        end 
    end 
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        ESX.ShowNotification( "~r~Réessayez..." )

        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            if ( not DoesEntityExist( veh ) ) then 
                ESX.ShowNotification( "~g~Vehicule supprimé." )
            end 

            timeout = timeout + 1 
            Citizen.Wait( 500 )

            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                ESX.ShowNotification( "~r~Echec de la suppression au bout de " .. timeoutMax .. " essaies." )
            end 
        end 
    else 
        ESX.ShowNotification( "~g~Vehicule supprimé." )
    end 
end 

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

-- Création du blip

local blips = { 
    {title="Chasse", colour=1, id=119, x = -1493.88, y = 4985.01, z = 62.72},
    {title="Boucherie", colour=63, id=500, x = 736.07, y = -1364.96, z = 26.55}
}

Citizen.CreateThread(function()

   for _, info in pairs(blips) do
	   info.blip = AddBlipForCoord(info.x, info.y, info.z)
	   SetBlipSprite(info.blip, info.id)
	   SetBlipDisplay(info.blip, 4)
	   SetBlipScale(info.blip, 1.0)
	   SetBlipColour(info.blip, info.colour)
	   SetBlipAsShortRange(info.blip, true)
	   BeginTextCommandSetBlipName("STRING")
	   AddTextComponentString(info.title)
	   EndTextCommandSetBlipName(info.blip)
   end
end)

-- Création du ped


Citizen.CreateThread(function()
    for _,k in pairs(Config.pPos) do

        local hash = GetHashKey(k[1])
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        pPed = CreatePed("PED_TYPE_CIVFEMALE", k[1], k[2], true, true)
        SetBlockingOfNonTemporaryEvents(pPed, true)
        FreezeEntityPosition(pPed, true)
        SetEntityInvincible(pPed, true)
    end
end)

-- Position des animaux

local PosAnim = {
	{ x = -1552.12, y = 4436.59, z = 10.10 },
	{ x = -1550.45, y = 4453.41, z = 14.89 },
	{ x = -1529.30, y = 4412.98, z = 12.00 },
	{ x = -1500.5, y = 4424.5, z = 17.11 },
	{ x = -1516.88, y = 4391.01, z = 17.39 },
}

local AnimauxSpawn = {}
function spawnbeer()
	for index, value in pairs(PosAnim) do
		local Animal = CreatePed(5, GetHashKey('a_c_deer'), value.x, value.y, value.z, 0.0, true, false)
		TaskWanderStandard(Animal, true, true)
		SetEntityAsMissionEntity(Animal, true, true)
		--Blips

		local AnimalBlip = AddBlipForEntity(Animal)
		SetBlipSprite(AnimalBlip, 463)
		SetBlipColour(AnimalBlip, 69)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Gibier')
		EndTextCommandSetBlipName(AnimalBlip)


		table.insert(AnimauxSpawn, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})

		ChargerModel('blazer')
		ChargerModel('a_c_deer')
		LoadAnimDict('amb@medic@standing@kneel@base')
		LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
	end
end
-- Création du menu 
Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
		local chasse2 = false
		local dst = GetDistanceBetweenCoords(pCoords, true)
        for k,v in pairs(config.chasse) do
			if #(pCoords - v.pos) < 1.5 then
				
                chasse2 = true
                ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour parler au chasseur")
                if IsControlJustReleased(0, 38) then
                    drawCenterText('~b~[Davy]~b~ ~s~Alors ça te dis de gagner un peu de sous en chassant du gibier ?', 3000)
                    Wait(3000)
					OpenMenuTuto()
				end
            end
        end

        if chasse2 then
            Wait(1)
        else
            Wait(2000)
        	end
		end
end)


function OpenMenuTuto()
    local menuc = RMenu.Add('chasse', 'main', RageUI.CreateMenu("Menu de chasse", "~p~Gagner de l'argent grace à la chasse"), true)
    RageUI.Visible(menuc, not RageUI.Visible(menuc))

    menuc:SetRectangleBanner(0, 0, 0, 255)

    while menuc do
        Citizen.Wait(5)
        RageUI.IsVisible(menuc, function()
                local source = source             
                RageUI.Item.Button("Comment fonctionne la chasse ?", nil, { RightLabel = ''}, true , {
                    onSelected = function()
                        drawCenterText("~b~[Davy]~b~ ~s~Tu vas devoir louer une arme et véhicule et ensuite tuer le gibier", 3000)
                        Wait(3000)
						drawCenterText("~b~[Davy]~b~ ~s~ensuite tu devras aller vendre la chair et la peau sur le point sur ton gps", 3000)
						Wait(3000)
                    end
				})
				RageUI.Item.Button("Commencer la chasse", 'Vous allez louer un véhicule et un fusil.', { RightLabel = ''}, true , {
                    onSelected = function()
                        ESX.ShowNotification("Aller sur l'endroit indiquer sur le ~g~gps ~s~pour commencer")
						--DrawMarker(1, -1493.83, 4978.86, 63.39, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 100.0, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
						spawnbeer()
						--TriggerServerEvent('talec:chassemoney')
						spawnCar('rebel2')
        				GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_DAGGER"),0, true, false)
						GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_DBSHOTGUN"),100, true, false)
                    end
				})
				RageUI.Item.Button("Arreter de chasser", nil, { RightLabel = ''}, true , {
					onSelected = function()			
						TriggerEvent('talec:supprv')
                        DeleteGivenVehicle()
						RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_DAGGER"))
						RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_DBSHOTGUN"))
						ESX.ShowNotification('Vehicule et armes ~g~supprimés')
					end
                })
        end)
        if not RageUI.Visible(menuc) then
            menuc = RMenu:DeleteType("chasse", true)
        end
    end
end

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		Citizen.Wait(0)
		for index, value in pairs(AnimauxSpawn) do
			if DoesEntityExist(value.id) then
				local AnimalCoords = GetEntityCoords(value.id)
				local PlyCoords = GetEntityCoords(PlayerPedId())
				local AnimalHealth = GetEntityHealth(value.id)
				local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

				if AnimalHealth <= 0 then
					SetBlipColour(value.Blipid, 49)
					if PlyToAnimal < 2.0 then
						sleep = 5
						ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour dépecer le gibier")
						if IsControlJustReleased(0, Keys['E']) then
							if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_DAGGER')  then
								if DoesEntityExist(value.id) then
									table.remove(AnimauxSpawn, index)
									SlaughterAnimal(value.id)
								end
							else
								ESX.ShowNotification('Veuillez utiliser votre ~r~dague !')
							end
						end
					end
				end

			end
		end
	end
end)