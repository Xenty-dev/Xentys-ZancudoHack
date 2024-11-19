RegisterNetEvent("startalarm")
AddEventHandler("startalarm", function()
    for _, player in ipairs(GetPlayers()) do
        TriggerClientEvent("TriggerAlarm", player)
    end
end)

RegisterNetEvent("stopalarm")
AddEventHandler("stopalarm", function()
    for _, player in ipairs(GetPlayers()) do
        TriggerClientEvent("StopAlarm", player)
    end
end)

RegisterNetEvent("stopairdefense")
AddEventHandler("stopairdefense", function()
    for _, player in ipairs(GetPlayers()) do
        TriggerClientEvent("StopAirDefense", player)
    end
end)

RegisterNetEvent("startairdefense")
AddEventHandler("startairdefense", function()
    for _, player in ipairs(GetPlayers()) do
        TriggerClientEvent("StartAirDefense", player)
    end
end)