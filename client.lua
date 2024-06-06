local QBCore = exports['qb-core']:GetCoreObject()

local attachedWeapons = {}

-- Function to attach weapon to player
local function attachWeaponToPlayer(playerPed, weapon)
    local weaponConfig = Config.Weapons[weapon]

    local boneIndex = GetPedBoneIndex(playerPed, weaponConfig.bone)
    RequestModel(weaponConfig.model)
    while not HasModelLoaded(weaponConfig.model) do
        Wait(1)
    end

    local weaponObject = CreateObject(GetHashKey(weaponConfig.model), 0, 0, 0, true, true, false)
    AttachEntityToEntity(weaponObject, playerPed, boneIndex, weaponConfig.x, weaponConfig.y, weaponConfig.z, weaponConfig.xRot, weaponConfig.yRot, weaponConfig.zRot, true, true, false, true, 1, true)
    attachedWeapons[weapon] = weaponObject
end

-- Function to detach and delete weapon from player
local function detachWeaponFromPlayer(weapon)
    if attachedWeapons[weapon] then
        DeleteObject(attachedWeapons[weapon])
        attachedWeapons[weapon] = nil
    end
end

-- Check for weapons on player and attach them
local function checkWeaponsOnPlayer()
    local playerPed = PlayerPedId()

    QBCore.Functions.TriggerCallback('ox_inventory:getInventory', function(inventory)
        local playerWeapons = {}
        for _, item in pairs(inventory) do
            playerWeapons[item.name] = true
        end

        for weapon, config in pairs(Config.Weapons) do
            if playerWeapons[weapon] and not attachedWeapons[weapon] then
                attachWeaponToPlayer(playerPed, weapon)
            elseif not playerWeapons[weapon] and attachedWeapons[weapon] then
                detachWeaponFromPlayer(weapon)
            end
        end
    end)
end

-- Event to check weapons when player spawns
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    checkWeaponsOnPlayer()
end)

-- Event to check weapons when inventory updates
RegisterNetEvent('ox_inventory:updateInventory', function()
    checkWeaponsOnPlayer()
end)

-- Initialize check when script loads
Citizen.CreateThread(function()
    while true do
        Wait(10000) -- Check every 10 seconds
        checkWeaponsOnPlayer()
    end
end)