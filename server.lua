-- Made by Talec

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('talec:additem')
AddEventHandler('talec:additem', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    cuir = math.random(1, 10)
    viande = math.random(1, 10)
    --print(cuir)
    --print(viande)
    TriggerClientEvent('esx:showNotification', source, "Vous avez depecer" .. cuir .. "kg de cuir et"  ..viande.. 'kg de viande')
    xPlayer.addInventoryItem('leather', cuir)
    xPlayer.addInventoryItem('chair', viande)
end)

RegisterServerEvent('talec:cuir')
AddEventHandler('talec:cuir', function ()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    item = xPlayer.getInventoryItem('leather').count
    --print(item)
    if item > 0 then
        xPlayer.removeInventoryItem('leather', 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~r~1kg ~s~de cuir")
        xPlayer.addMoney(Cuir_Money)
    end
    if item <= 0 then 
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez plus de~r~ cuir à vendre!")
    end
end)

RegisterServerEvent('talec:viande')
AddEventHandler('talec:viande', function ()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    item2 = xPlayer.getInventoryItem('chair').count
    --print(item2)
    if item2 > 0 then
        xPlayer.removeInventoryItem('chair', 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~r~1kg ~s~de viande")
        xPlayer.addMoney(Viande_Money)
    end
    if item2 <= 0 then 
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez plus de~r~ viande à vendre!")
    end
end)