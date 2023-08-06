local inMenu = false
local paypalColor = "red"

RegisterNetEvent('opentransfer')
AddEventHandler('opentransfer', function()
    openPlayerspaypal('paypal')openPlayerspaypal('paypal')
    Citizen.Wait(0)
    openPlayerspaypal('paypal')openPlayerspaypal('paypal')
    local ped = GetPlayerPed(-1)
end)

function openPlayerspaypal(type, color)
    local ped = GetPlayerPed(-1)
    if type == 'paypal' then
        inMenu = true
        SetNuiFocus(true, true)
        paypalColor = "red"
        SendNUIMessage({type = 'openpaypal', color = paypalColor})
        TriggerServerEvent('flakey:paypal:balance')
    end
end

RegisterNetEvent('flakey:paypal:info')
AddEventHandler('flakey:paypal:info', function(balance)
    local id = PlayerId()
    local playerName = GetPlayerName(id)
    SendNUIMessage({
		type = "updateBalance",
		balance = balance,
        player = playerName,
    })
end)

RegisterNUICallback('balance', function()
    TriggerServerEvent('flakey:paypal:balance')
end)

RegisterNetEvent('flakey:balance:back')
AddEventHandler('flakey:balance:back', function(balance)
    SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

function closePaypal()
    local ped = GetPlayerPed(-1)
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
    inMenu = false
end

RegisterNUICallback('transfer', function(data)
    TriggerServerEvent('flakey:paypal:transfer', data.to, data.amountt)
    TriggerServerEvent('flakey:paypal:balance')
end)

AddEventHandler('onResourceStop', function(resource)
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

RegisterNUICallback('NUIFocusOff', function()
    closePaypal()
end)

--This is the trigger used to open the paypal window--

RegisterCommand("paypal", function(src, args, raw)
    TriggerEvent('opentransfer')
end)
