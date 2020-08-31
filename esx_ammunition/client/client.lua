local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	end

	while not ESX.IsPlayerLoaded() do 
		Citizen.Wait(10) 
	end
	
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function()
	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local CurrentAction
				
		for k,v in pairs(Config.Locations) do
			if PlayerData.job and PlayerData.job.name == v.job or v.job == false then
				local distance = GetDistanceBetweenCoords(coords, v.coords, true)
				if distance <= 10 then
					DrawMarker(v.markerType, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markerSize, v.markerColor, v.markerDensity, true, true, 2, true, false, false, false)
				end
					
				if distance < 1 then
						
					CurrentAction = 'ammostation'
					CurrentActionmsg = 'Press ~INPUT_CONTEXT~ to buy ammunition'
						
					ESX.ShowHelpNotification(CurrentActionmsg)
							
					if IsControlJustPressed(0, 38) then
						if CurrentAction == 'ammostation' then
							OpenAmmoBuyMenu()
						end
					end
				end					
			end
		end
	end
end)

function OpenAmmoBuyMenu()
	ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'ammomenu',
        {
          title = "How much?"
        },
        function(data, menu)
			local ammo = data.value
			local money = ammo * Config.Price
				ESX.TriggerServerCallback('esx_ammunition:hasmoney', function(hasmoney)
					if hasmoney then
						local ped = PlayerPedId()
						local weapon = GetSelectedPedWeapon(ped)
						local ammoinweapon = GetAmmoInPedWeapon(ped, weapon)
						if HasPedTheRightWeapon() then
							if ammoinweapon + ammo <= 250 then
								AddAmmoToPed(ped, weapon, ammo)
								TriggerServerEvent('esx_ammunition:buy', money)
								Notify('You have bought '..ammo..' ammo for '..Config.CurrencyIcon..money)
							else
								Notify('You can only carry 250 ammunition')
							end
						else
							Notify('You don\'t have a weapon that we offer ammunition for equipped')
						end
					else
						Notify('You don\'t have enough Money')
					end
				end, money)

            menu.close()
        end,
      function(data, menu)
        menu.close()
    end)
end

Notify = function(msg)
	ESX.ShowNotification(msg)
end

HasPedTheRightWeapon = function()
	local ped = PlayerPedId()
	local weapon = GetSelectedPedWeapon(ped)
	local hasWeapon
	for i = 1,#Config.Weapons do
	local weaponhash = GetHashKey(Config.Weapons[i])
		if weapon == weaponhash then
			hasWeapon = true
		end
	end
	return hasWeapon
end



















