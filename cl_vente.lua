-- Made by Talec
Citizen.CreateThread(function()
    while true do
        local pPed1 = GetPlayerPed(-1)
        local pCoords2 = GetEntityCoords(pPed1)
		local chasse3 = false
		local dst = GetDistanceBetweenCoords(pCoords2, true)
        for k,v in pairs(config.chassev) do
			if #(pCoords2 - v.pos2) < 1.5 then
				
                chasse3 = true
                ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour parler au chasseur")
                if IsControlJustReleased(0, 38) then
					VenteMenu()
				end
            end
        end

        if chasse3 then
            Wait(1)
        else
            Wait(2000)
        	end
		end
end)

function VenteMenu()
    local menuv = RMenu.Add('vente', 'main', RageUI.CreateMenu("Menu de chasse", "~p~Gagner de l'argent grace à la chasse"), true)
    RageUI.Visible(menuv, not RageUI.Visible(menuv))

    menuv:SetRectangleBanner(0, 0, 0, 255)

    while menuv do
        Citizen.Wait(5)
        RageUI.IsVisible(menuv, function()
                local source = source             
                RageUI.Item.Button("Vendre de la chair", nil, { RightLabel = '~g~+200$'}, true , {
                    onSelected = function()
                        TriggerServerEvent('talec:cuir')
                    end
                })
                RageUI.Item.Button("Vendre de la viande", nil, { RightLabel = '~g~+400$'}, true , {
                    onSelected = function()
                        TriggerServerEvent('talec:viande')
                    end
				})
        end)
        if not RageUI.Visible(menuv) then
            menuv = RMenu:DeleteType("vente", true)
        end
    end
end