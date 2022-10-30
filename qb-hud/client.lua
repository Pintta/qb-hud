local QBCore = exports['qb-core']:GetCoreObject()
local hunger = 100
local thirst = 100
local isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

Citizen.CreateThread(function()
    while true do
        Wait(500)
        if isLoggedIn then
            local show = true
            local player = PlayerPedId()
            local talking = NetworkIsPlayerTalking(PlayerId())
            if IsPauseMenuActive() then
                show = false
            end
            SendNUIMessage({
                action = 'hudtick',
                show = show,
                thirst = thirst,
                hunger = hunger,
                talking = talking,
            })
        else
            SendNUIMessage({
                action = 'hudtick',
                show = false,
            })
        end
    end
end)
