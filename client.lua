-- Cipher Hack Section

local isHacking = false
local lastHackTime = 0
local isCooldown = false
local controlHackLocation = vector3(-2353.250, 3258.3049, 93.05) -- Adjust control panel location

local isHacked = false

-- Function to display a notification
local function showNotification(title, description)
    lib.notify({
        id = 'hack_notification',
        title = title,
        description = description,
        position = 'top',
        
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        },
        icon = 'ban',
        iconColor = '#C53030'
    })
end

local function hackSuccess(title, description)
    lib.notify({
        title = title,
        description = description,
        position = 'top',
        type = 'success'
    })
end

---------------------------------------------

-- Door Hack

---------------------------------------------

-- Use ox_target to interact with the hack location
exports.ox_target:addBoxZone({
    coords = vector3(-2343.8599, 3262.4875, 32.8277), -- Door Hack location
    size = vector3(2.0, 2.0, 2.0),
    heading = 0.0,
    debug = false,
    options = {
        {
            name = 'start_hacking',
            icon = 'fa-solid fa-laptop',
            label = 'Start Hack',
            onSelect = function()
                local playerPos = GetEntityCoords(PlayerPedId())
                local hackLocation = vector3(-2343.8599, 3262.4875, 32.8277)
        
                -- Check if the player is near the hack location
                local distance = #(playerPos - hackLocation)
                if distance < 2.0 then
                    if isCooldown then
                        showNotification('Cooldown', 'You need to wait before starting another hack.')
                        return
                    end
                    
                    isHacking = true
                    lastHackTime = GetGameTimer() -- Record the time when hacking started

                    local success = lib.skillCheck('medium', {'e'})
                    if success then
                        hackSuccess('Hack Success', 'Doors unlocked')
                        TriggerEvent('cd_doorlock:SetDoorState_closest', false)
                    else
                        -- Handle failure to prepare the alarm
                        showNotification('Hack Failed', 'System on cooldown.')
                    end

                    -- Start a cooldown timer after the minigame finishes
                    lastHackTime = GetGameTimer()
                    isCooldown = true
                end
            end
        }
    }
})

---------------------------------------------

-- Control Panel Hack section

---------------------------------------------

-- Define the controlHackLocation (example location)
local controlHackLocation = vector3(-2353.250, 3258.3049, 93.05)  -- Replace with actual coordinates

-- Register the context menu for the control panel hack
lib.registerContext({
    id = 'control_panel_hack_menu',
    title = 'CS Control Panel',
    options = {
        {
            title = 'Start Hack',
            onSelect = function()
                -- Check if the player is near the hack location
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - controlHackLocation)
                if distance < 2.0 then -- Adjust the radius as needed
                    isHacking = true
                    lastHackTime = GetGameTimer() -- Record the time when hacking started

                    -- Call the lightsout minigame event
                    local grid = 4 
                    local maxClicks = 5 -- max clicks
                    local result = exports['lightsout']:StartLightsOut(grid, maxClicks)

                    if result then
                        hackSuccess('Hack success', 'Defense Systems offline')
                        TriggerServerEvent("startalarm") -- Trigger the event to get all players
                        TriggerServerEvent('startairdefense')
                    else
                        showNotification('Hack Failed', 'Try again')
                    end
                end
            end,
            icon = 'lock'
        },
        {
            title = 'Stop Alarm',
            onSelect = function()
                if LocalPlayer.state["gsrp:onDuty"] == "yes" then
                    if lib.progressCircle({
                        duration = 2000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                        },
                    }) then
                        print('') 
                    else
                        print('') 
                    end
                    Wait(1000)
                    TriggerServerEvent('stopalarm')
                    TriggerServerEvent('startairdefense')
                    showNotification('Alarm Stopped', 'The alarm has been deactivated manually.')
                else
                    showNotification('Not Clocked In, failed to stop hack')
                end
            end,
            icon = 'unlock'
        }
    }
})

local function showControlPanelHackMenu()
    lib.showContext('control_panel_hack_menu')
end

exports.ox_target:addBoxZone({
    coords = controlHackLocation,  -- Control Panel Hack location
    size = vector3(1.0, 1.0, 1.0),
    heading = 0.0,
    debug = false, 
    options = {
        {
            name = 'control_panel_hack',
            icon = 'fa-solid fa-laptop',
            label = 'Start Control Panel Hack',
            onSelect = function()
                showControlPanelHackMenu()
            end
        }
    }
})




---------------------------------------------

-- Elevators

---------------------------------------------

-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "elevator-ding", 0.5)

-- Define elevator floor coordinates
local ElevatorLocation = vector3(-2360.6895, 3249.5750, 32.0307)
local ElevatorLocation2 = vector3(-2360.6951, 3249.6055, 91.9438)
local groundFloorCoords = vector3(-2360.6895, 3249.5750, 32.0307)
local topFloorCoords = vector3(-2360.8977, 3249.3752, 92.9039)

-- Define the elevator interaction using ox_target
exports.ox_target:addBoxZone({
    coords = ElevatorLocation,
    size = vector3(1.0, 1.0, 1.0),
    heading = 0.0,
    debug = false,
    options = {
        {
            name = 'elevator_menu',
            icon = 'fa-solid fa-elevator',
            label = 'Open Elevator Menu',
            onSelect = function()
                print('Elevator Menu option selected!')
                lib.showMenu('elevator_menu')
            end
        }
    }
})

exports.ox_target:addBoxZone({
    coords = ElevatorLocation2,
    size = vector3(1.0, 1.0, 1.0),
    heading = 0.0,
    debug = false,
    options = {
        {
            name = 'elevator_menu',
            icon = 'fa-solid fa-elevator',
            label = 'Open Elevator Menu',
            onSelect = function()
                print('Elevator Menu option selected!')
                lib.showMenu('elevator_menu')
            end
        }
    }
})

-- Register the Elevator Menu
lib.registerMenu({
    id = 'elevator_menu',
    title = 'Elevator Control Panel',
    position = 'top-right',
    onClose = function(keyPressed)
        print('Elevator menu closed')
        if keyPressed then
            print(('Pressed %s to close the menu'):format(keyPressed))
        end
    end,
    options = {
        {
            label = 'Select Floor',
            values = {'Ground Floor', 'Top Floor'},
            description = 'Select a floor to travel to',
        }
    },

}, function(selected, scrollIndex, args)

    print(selected, scrollIndex, args)

    local playerCoords = GetEntityCoords(PlayerPedId())
    local isOnDuty = LocalPlayer.state["zrlux:onDuty"] == "yes"
    
    if scrollIndex == 1 then -- Ground Floor
        if isOnDuty then
            if #(playerCoords - groundFloorCoords) < 2.0 then
                lib.notify({title = "Elevator", description = "You are already at the Ground Floor.", type = "info"})
            else
                SetEntityCoords(PlayerPedId(), groundFloorCoords.x, groundFloorCoords.y, groundFloorCoords.z)
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "elevator-ding", 0.5)
                lib.notify({title = "Elevator", description = "Teleported to the Ground Floor.", type = "success"})
            end
        else
            lib.notify({title = "Error", description = "You must be clocked in to use the elevator.", type = "error"})
        end
    elseif scrollIndex == 2 then -- Top Floor
        if isOnDuty then
            SetEntityCoords(PlayerPedId(), topFloorCoords.x, topFloorCoords.y, topFloorCoords.z)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "elevator-ding", 0.5)
            lib.notify({title = "Elevator", description = "Teleported to the Top Floor.", type = "success"})
        else
            lib.notify({title = "Error", description = "You must be clocked in to use the elevator.", type = "error"})
        end
    end
end)



---------------------------------------------

-- Main Loops, Event Handlers

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local playerPos = GetEntityCoords(PlayerPedId())
        local hackLocation = vector3(-2343.2661, 3262.3867, 32.8277)
        local distanceToHack = #(playerPos - hackLocation)
        local distanceToControlPanel = #(playerPos - controlHackLocation)
        
        -- Check if the player is near the hack location
        if distanceToHack < 2.0 or distanceToControlPanel < 2.0 then
            -- Check if ox_target has added the hack prompts
        else
            -- Handle when player is not in range
        end

        -- Cooldown logic
        if isCooldown then
            if GetGameTimer() - lastHackTime >= 60000 then
                -- If the cooldown period has passed, reset the cooldown state
                isCooldown = false
            end
        end
    end
end)

-- Event triggers for alarms (as in your existing code)

RegisterNetEvent("TriggerAlarm")
AddEventHandler("TriggerAlarm", function()
    local prepareSuccess = PrepareAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS")
    if prepareSuccess then
        -- If preparation is successful, start the alarm
        StartAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", true)
    end
end)

RegisterNetEvent("StopAlarm")
AddEventHandler("StopAlarm", function()
    StopAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", true)
end)


-- shit code but im too tired to fix it
RegisterNetEvent("stopairdefense")
AddEventHandler("stopairdefense", function()
    isHacked = false
end)

RegisterNetEvent("startairdefense")
AddEventHandler("startairdefense", function()
    isHacked = true
end)


-------------------------------------

-- Air Defence

-------------------------------------


local accuracy = 800.0
local nogozone
local ran = false
local isAlarmActive = false
local isExplosionActive = false
local Timer = 10000

local function ApplyInaccuracy(targetCoords)
    local offset = math.random(-accuracy, accuracy) / 100
    local xOffset = offset
    local yOffset = offset
    local zOffset = offset
    return vector3(targetCoords.x + xOffset, targetCoords.y + yOffset, targetCoords.z + zOffset)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(math.random(1000, 2000))
        local ped = PlayerPedId()
        local dist = #(GetEntityCoords(ped) - vector3(-2357.4287, 3250.8669, 106.0476))
        
        if dist < 300 and GetEntityHeightAboveGround(ped) > 5.0 and IsPedInFlyingVehicle(ped) and isHacked == false and LocalPlayer.state["gsrp:onDuty"] == "no" then
            local count = 0
            local random = math.random(1, 5)

            if not ran then
                ran = true
                nogozone = AddBlipForRadius(-2357.4287, 3250.8669, 106.0476, 300.0)
                SetBlipColour(nogozone, 1)
                SetBlipAlpha(nogozone, 128)
            end
            
            if not isAlarmActive then
                exports['okokNotify']:Alert('Restricted Airspace', 'You are entering restricted airspace! Please leave in the next ' .. (Timer / 1000) .. ' seconds!', 3000, 'warning', true)
                isAlarmActive = true
                Citizen.Wait(Timer)
                exports['okokNotify']:Alert('Restricted Airspace', 'Air defense systems have been activated! Get out of here!', 3000, 'warning', true)
                isExplosionActive = true
            end
            
            while count < random and isExplosionActive do
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)
                local targetCoords = ApplyInaccuracy(pCoords)
                AddExplosion(targetCoords.x, targetCoords.y, targetCoords.z, 18, 2.0, true, false, 1.0)
                count = count + 1
                Citizen.Wait(math.random(200, 500))

                local dist = #(pCoords - vector3(-2357.4287, 3250.8669, 106.0476))
                if dist >= 300 then
                    isExplosionActive = false
                    break
                end
            end
        elseif dist >= 300 then
            if ran then
                RemoveBlip(nogozone)
                ran = false
                isAlarmActive = false
                isExplosionActive = false
            end
        end

        if IsEntityDead(ped) then 
            RemoveBlip(nogozone)
            ran = false
            isAlarmActive = false
            isExplosionActive = false
            Citizen.Wait(1000)
        end
    end
end)
