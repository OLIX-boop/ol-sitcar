Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
end)

local alreadySit, sitcar = false, false


RegisterCommand('sitcar', function()
    if not alreadySit then
        local car = GetEntityCoords(ESX.Game.GetClosestVehicle(), false)
        local dist = #(GetEntityCoords(PlayerPedId()) - car)
        if dist < 5 then
            alreadySit = true
            sitcar = true
            LoadDict('timetable@jimmy@mics3_ig_15@')
            TaskPlayAnim(PlayerPedId(), "timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", 8.0, -8.0, -1, 1, 0, false, false, false)
	    ESX.ShowNotification("You've sitted on the vehicle")
        else
		ESX.ShowNotification("You\'re too far away from a vehicle")		
	end
    else
        ClearPedTasks(PlayerPedId())
        alreadySit = false
        sitcar = false
        SetEntityCollision(PlayerPedId(), true, true)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if sitcar then
            local vehicle = ESX.Game.GetClosestVehicle()
            local vehicleCoords = GetEntityCoords(vehicle, false)
            local heading = GetEntityHeading(vehicle)

            SetEntityCollision(PlayerPedId(), false, false)
            SetEntityCoords(PlayerPedId(), vehicleCoords.x, vehicleCoords.y, vehicleCoords.z-0.3, 1, 1, 1, false)
            SetEntityHeading(PlayerPedId(), heading)
        end

    end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end
