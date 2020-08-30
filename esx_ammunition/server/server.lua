ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_ammunition:hasmoney', function(source, cb, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plymoney = xPlayer.getMoney()
	cb(plymoney >= amount) -- CHANGE FOR BANK IF YOU WANT TO PAY WITH BANK ETC
end)

RegisterServerEvent('esx_ammunition:buy')
AddEventHandler('esx_ammunition:buy', function(money)
local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(money)
end)