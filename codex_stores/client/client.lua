CodexCore = exports['codex_core']:getLibClient()

ClientData = {
    loaded = false,
    job = nil,
    money = 0,
    gold = 0,
}

local initialized = false

local function safeCoreValue(methodName, fallback)
    EnsureCodexCore()

    if not CodexCore or type(CodexCore[methodName]) ~= 'function' then
        return fallback
    end

    local ok, result = pcall(function()
        return CodexCore[methodName]()
    end)

    if not ok or result == nil then
        return fallback
    end

    return result
end

local function updateClientData()
    ClientData.job = safeCoreValue('GetJob', ClientData.job)
    ClientData.money = safeCoreValue('GetMoney', ClientData.money or 0)
    ClientData.gold = safeCoreValue('GetGold', ClientData.gold or 0)
end

local function initializeStores(reason)
    if initialized then return end

    EnsureCodexCore()
    PromptSetUp()
    updateClientData()

    ClientData.loaded = true
    initialized = true

    if Config.AlwaysShowStoreBlips then
        RefreshStoreBlips()
    end

    if Config.DevMode then
        print(('[codex_stores] Client initialized: %s'):format(tostring(reason or 'unknown')))
        DebugNearestStore('after-init')
    end
end

RegisterNetEvent('codex-core:playerLoaded')
AddEventHandler('codex-core:playerLoaded', function()
    if Config.DevMode then
        print('[codex_stores] codex-core:playerLoaded received.')
    end

    initializeStores('codex-core:playerLoaded')
end)

CreateThread(function()
    EnsureCodexCore()

    -- If the resource is ensured/restarted after the player is already in-game,
    -- codex-core:playerLoaded may already have fired. This fallback keeps stores alive.
    Wait(2500)

    if not initialized then
        initializeStores('resource-start fallback')
    end
end)

CreateThread(function()
    while true do
        Wait(10000)

        if ClientData.loaded and not IsInMenu then
            updateClientData()
        end
    end
end)

CreateThread(function()
    while not ClientData.loaded do
        Wait(250)
    end

    while true do
        local sleep = true
        local player = PlayerPedId()

        if player ~= 0 and not IsInMenu and not IsEntityDead(player) then
            local playerCoords = GetEntityCoords(player)
            local currentHour = GetClockHours()

            for storeId, storeConfig in pairs(Config.Stores) do
                local storeCoords = vector3(storeConfig.Coords.x, storeConfig.Coords.y, storeConfig.Coords.z)
                local distance = #(playerCoords - storeCoords)
                local isOpen = IsStoreOpen(storeConfig, currentHour)

                if not isOpen then
                    if not Config.AlwaysShowStoreBlips then
                        RemoveStoreBlip(storeId)
                    end
                    RemoveStoreNPC(storeId)
                else
                    if storeConfig.BlipData and storeConfig.BlipData.Allowed and not storeConfig.BlipHandle then
                        AddBlip(storeId)
                    end

                    if storeConfig.NPC and distance > (Config.RenderNPCDistance or 30.0) then
                        RemoveStoreNPC(storeId)
                    end

                    if (not storeConfig.NPC or not DoesEntityExist(storeConfig.NPC)) and storeConfig.NPCData and storeConfig.NPCData.Allowed and distance <= (Config.RenderNPCDistance or 30.0) then
                        SpawnNPC(storeId)
                    end

                    if distance <= (storeConfig.DistanceOpenStore or 2.0) and PlayerCanUseStore(storeConfig) then
                        sleep = false
                        ShowStorePrompt(storeConfig.PromptName)

                        if StorePromptCompleted() then
                            OpenStoreCategory(storeId)
                            TaskStandStill(player, -1)
                            Wait(1000)
                        end
                    end
                end
            end

            DebugNearestStore('loop')
        end

        if sleep then
            Wait(1000)
        else
            Wait(0)
        end
    end
end)
