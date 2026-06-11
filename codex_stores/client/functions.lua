local RESOURCE_NAME = GetCurrentResourceName()

CodexCore = CodexCore or nil
CodexAPIs = CodexAPIs or nil

PromptGroup = nil
Prompt = nil
CurrentDayName = nil
IsInMenu = false
UIType = nil

local nativePromptGroup = nil
local nativePrompt = nil
local lastDebugPrint = 0

local function devLog(message)
    if Config and Config.DevMode then
        print(('[%s][client] %s'):format(RESOURCE_NAME, tostring(message)))
    end
end

local function safeToString(value)
    if value == nil then return 'nil' end
    return tostring(value)
end

function EnsureCodexCore()
    while GetResourceState('codex_core') ~= 'started' do
        Wait(500)
    end

    if not CodexCore then
        local ok, core = pcall(function()
            return exports['codex_core']:getLibClient()
        end)

        if ok and core then
            CodexCore = core
        end
    end

    if not CodexAPIs then
        local ok, apis = pcall(function()
            return exports['codex_core']:CodexAPIsInit()
        end)

        if ok and apis then
            CodexAPIs = apis
        end
    end

    return CodexCore, CodexAPIs
end

local function removeStoreBlip(storeConfig)
    if not storeConfig or not storeConfig.BlipHandle then return end

    if type(storeConfig.BlipHandle) == 'table' and storeConfig.BlipHandle.Remove then
        storeConfig.BlipHandle:Remove()
    else
        RemoveBlip(storeConfig.BlipHandle)
    end

    storeConfig.BlipHandle = nil
end

local function removeStoreNPC(storeConfig)
    if not storeConfig then return end

    if storeConfig.NPCHandle and type(storeConfig.NPCHandle) == 'table' and storeConfig.NPCHandle.Remove then
        storeConfig.NPCHandle:Remove()
    elseif storeConfig.NPC and DoesEntityExist(storeConfig.NPC) then
        DeleteEntity(storeConfig.NPC)
        DeletePed(storeConfig.NPC)
        Citizen.InvokeNative(0x5E94EA09E7207C16, storeConfig.NPC)
        SetEntityAsNoLongerNeeded(storeConfig.NPC)
    end

    storeConfig.NPCHandle = nil
    storeConfig.NPC = nil
end

AddEventHandler('onResourceStop', function(resourceName)
    if RESOURCE_NAME ~= resourceName then return end

    if IsInMenu then
        SetNuiFocus(false, false)
        ClearPedTasksImmediately(PlayerPedId())
    end

    for _, storeConfig in pairs(Config.Stores) do
        removeStoreBlip(storeConfig)
        removeStoreNPC(storeConfig)
    end

    if nativePrompt then
        Citizen.InvokeNative(0x00EDE88D4D13CF59, nativePrompt)
    end
end)

-----------------------------------------------------------
-- Prompts
-----------------------------------------------------------

local function setupNativePrompt()
    nativePromptGroup = GetRandomIntInRange(0, 0xffffff)
    nativePrompt = PromptRegisterBegin()

    PromptSetControlAction(nativePrompt, Config.OpenKey or 0xC7B5340A)
    PromptSetText(nativePrompt, CreateVarString(10, 'LITERAL_STRING', Locales['PROMPT_DISPLAY_TEXT'] or 'Open'))
    PromptSetEnabled(nativePrompt, true)
    PromptSetVisible(nativePrompt, true)
    PromptSetHoldMode(nativePrompt, Config.PromptHoldTime or 500)
    PromptSetGroup(nativePrompt, nativePromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, nativePrompt, true)
    PromptRegisterEnd(nativePrompt)

    PromptGroup = nativePromptGroup
    Prompt = nativePrompt

    devLog('Native RedM prompt initialized. group=' .. safeToString(nativePromptGroup) .. ' prompt=' .. safeToString(nativePrompt))
end

function PromptSetUp()
    if nativePrompt then return end
    setupNativePrompt()
end

function ShowStorePrompt(promptName)
    if not nativePrompt or not nativePromptGroup then
        PromptSetUp()
    end

    if nativePrompt and nativePromptGroup then
        PromptSetEnabled(nativePrompt, true)
        PromptSetVisible(nativePrompt, true)
        PromptSetActiveGroupThisFrame(nativePromptGroup, CreateVarString(10, 'LITERAL_STRING', promptName or 'Store'))
    end
end

function StorePromptCompleted()
    if not nativePrompt then return false end

    if PromptHasHoldModeCompleted(nativePrompt) then
        Wait(500)
        return true
    end

    return false
end

-----------------------------------------------------------
-- Blips
-----------------------------------------------------------

local function resolveNativeHash(value)
    if type(value) == 'number' then return value end
    if type(value) ~= 'string' or value == '' then return nil end

    if joaat then
        return joaat(value)
    end

    if GetHashKey then
        return GetHashKey(value)
    end

    return value
end

local function applyBlipModifier(blipHandle, modifier)
    if not blipHandle or not modifier then return end

    local modifierHash = resolveNativeHash(modifier)
    if not modifierHash then return end

    pcall(function()
        Citizen.InvokeNative(0x662D364ABF16DE2F, blipHandle, modifierHash)
    end)
end

function AddBlip(storeId)
    local storeConfig = Config.Stores[storeId]
    if not storeConfig or not storeConfig.BlipData or not storeConfig.BlipData.Allowed then return end
    if storeConfig.BlipHandle then return end

    local blipSprite = resolveNativeHash(storeConfig.BlipData.Sprite)
    if not blipSprite then
        devLog(('Skipped blip for %s because sprite is invalid.'):format(tostring(storeId)))
        return
    end

    local _, apis = EnsureCodexCore()

    if Config.UseCodexBlipAPI and apis and apis.Blip and apis.Blip.SetBlip then
        local ok, blipHandle = pcall(function()
            return apis.Blip:SetBlip(
                storeConfig.BlipData.Name,
                blipSprite,
                storeConfig.BlipData.Scale or 0.2,
                storeConfig.Coords.x,
                storeConfig.Coords.y,
                storeConfig.Coords.z
            )
        end)

        if ok and blipHandle then
            storeConfig.BlipHandle = blipHandle
            applyBlipModifier(storeConfig.BlipHandle, storeConfig.BlipData.Modifier)
            devLog(('Added CodexCore blip for %s'):format(storeId))
            return
        end
    end

    storeConfig.BlipHandle = N_0x554d9d53f696d002(1664425300, storeConfig.Coords.x, storeConfig.Coords.y, storeConfig.Coords.z)
    SetBlipSprite(storeConfig.BlipHandle, blipSprite, true)
    SetBlipScale(storeConfig.BlipHandle, storeConfig.BlipData.Scale or 0.2)
    applyBlipModifier(storeConfig.BlipHandle, storeConfig.BlipData.Modifier)
    Citizen.InvokeNative(0x9CB1A1623062F402, storeConfig.BlipHandle, storeConfig.BlipData.Name)
    devLog(('Added native blip for %s at %.2f %.2f %.2f'):format(storeId, storeConfig.Coords.x, storeConfig.Coords.y, storeConfig.Coords.z))
end

function RemoveStoreBlip(storeId)
    removeStoreBlip(Config.Stores[storeId])
end

function RefreshStoreBlips()
    if not Config or not Config.Stores then return end

    local createdCount = 0

    for storeId, storeConfig in pairs(Config.Stores) do
        if storeConfig.BlipData and storeConfig.BlipData.Allowed then
            if not storeConfig.BlipHandle then
                AddBlip(storeId)
            end

            if storeConfig.BlipHandle then
                createdCount = createdCount + 1
            end
        end
    end

    devLog(('Refreshed store blips. active=%s'):format(tostring(createdCount)))
end

-----------------------------------------------------------
-- NPCs
-----------------------------------------------------------

local function applyStaticNPCFlags(npc)
    if not npc or npc == 0 or not DoesEntityExist(npc) then return end

    SetEntityAsMissionEntity(npc, true, true)
    SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
    SetEntityCanBeDamaged(npc, false)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
    Citizen.InvokeNative(0x9587913B9E772D29, npc, true) -- PlaceEntityOnGroundProperly
    Citizen.InvokeNative(0x9F8AA94D6D97DBF4, npc, 0)
    Citizen.InvokeNative(0x1913FE4CBF41C463, npc, 6, true)
    Citizen.InvokeNative(0x1913FE4CBF41C463, npc, 292, true)
    Citizen.InvokeNative(0x1913FE4CBF41C463, npc, 294, true)
    Citizen.InvokeNative(0x1913FE4CBF41C463, npc, 301, true)
end

function LoadModel(model)
    local modelHash = type(model) == 'string' and joaat(model) or model

    if not modelHash or not IsModelValid(modelHash) then
        print(('[%s] Invalid NPC model: %s hash=%s'):format(RESOURCE_NAME, tostring(model), tostring(modelHash)))
        return nil
    end

    RequestModel(modelHash)

    local timeout = GetGameTimer() + 10000
    while not HasModelLoaded(modelHash) do
        Wait(50)
        RequestModel(modelHash)

        if GetGameTimer() > timeout then
            print(('[%s] Timed out loading NPC model: %s hash=%s'):format(RESOURCE_NAME, tostring(model), tostring(modelHash)))
            return nil
        end
    end

    return modelHash
end

local function spawnNPCWithNative(storeId, storeConfig)
    local modelHash = LoadModel(storeConfig.NPCData.Model)
    if not modelHash then return nil end

    local x = tonumber(storeConfig.Coords.x) or 0.0
    local y = tonumber(storeConfig.Coords.y) or 0.0
    local z = tonumber(storeConfig.Coords.z) or 0.0
    local h = tonumber(storeConfig.Coords.h) or 0.0

    devLog(('Trying NPC spawn: %s model=%s hash=%s coords=%.2f %.2f %.2f h=%.2f'):format(storeId, tostring(storeConfig.NPCData.Model), tostring(modelHash), x, y, z, h))

    local npc = CreatePed(modelHash, x, y, z, h, false, true, true, true)

    Wait(250)

    if not npc or npc == 0 or not DoesEntityExist(npc) then
        print(('[%s] Native NPC spawn failed for %s model=%s hash=%s'):format(RESOURCE_NAME, tostring(storeId), tostring(storeConfig.NPCData.Model), tostring(modelHash)))
        SetModelAsNoLongerNeeded(modelHash)
        return nil
    end

    applyStaticNPCFlags(npc)
    SetModelAsNoLongerNeeded(modelHash)

    devLog(('NPC spawned for %s entity=%s'):format(storeId, tostring(npc)))
    return npc
end

function SpawnNPC(storeId)
    local storeConfig = Config.Stores[storeId]
    if not storeConfig or not storeConfig.NPCData or not storeConfig.NPCData.Allowed then return end
    if storeConfig.NPC and DoesEntityExist(storeConfig.NPC) then return end

    storeConfig.NPCHandle = nil
    storeConfig.NPC = spawnNPCWithNative(storeId, storeConfig)
end

function RemoveStoreNPC(storeId)
    local storeConfig = Config.Stores[storeId]
    if storeConfig and storeConfig.NPC then
        devLog(('Removing NPC for %s'):format(tostring(storeId)))
    end

    removeStoreNPC(storeConfig)
end

-----------------------------------------------------------
-- General helpers
-----------------------------------------------------------

function CheckJob(jobList, playerJob)
    if not jobList then return true end
    if not playerJob then return false end

    for _, jobName in pairs(jobList) do
        if tostring(jobName) == tostring(playerJob) then
            return true
        end
    end

    return false
end

function IsStoreOpen(storeConfig, hour)
    if not storeConfig or not storeConfig.Hours or not storeConfig.Hours.Allowed then
        return true
    end

    local opening = tonumber(storeConfig.Hours.Opening) or 0
    local closing = tonumber(storeConfig.Hours.Closing) or 24
    hour = tonumber(hour) or GetClockHours()

    if opening == closing then return true end

    if opening < closing then
        return hour >= opening and hour < closing
    end

    return hour >= opening or hour < closing
end

function PlayerCanUseStore(storeConfig)
    if not storeConfig or not storeConfig.JobsData or not storeConfig.JobsData.Allowed then
        return true
    end

    EnsureCodexCore()

    local ok, job = pcall(function()
        return CodexCore.GetJob()
    end)

    if not ok then return false end

    return CheckJob(storeConfig.JobsData.Jobs, job)
end

function GetNearestStoreDebug()
    local player = PlayerPedId()
    if not player or player == 0 then return nil end

    local playerCoords = GetEntityCoords(player)
    local nearestId = nil
    local nearestConfig = nil
    local nearestDistance = 999999.0

    for storeId, storeConfig in pairs(Config.Stores) do
        local storeCoords = vector3(storeConfig.Coords.x, storeConfig.Coords.y, storeConfig.Coords.z)
        local distance = #(playerCoords - storeCoords)

        if distance < nearestDistance then
            nearestDistance = distance
            nearestId = storeId
            nearestConfig = storeConfig
        end
    end

    return nearestId, nearestConfig, nearestDistance, playerCoords
end

function DebugNearestStore(reason)
    if not Config.DevMode then return end

    local now = GetGameTimer()
    if reason == 'loop' and now - lastDebugPrint < 5000 then return end
    lastDebugPrint = now

    local storeId, storeConfig, distance, playerCoords = GetNearestStoreDebug()
    if not storeId or not storeConfig then
        devLog('Debug: no stores found in Config.Stores')
        return
    end

    local hour = GetClockHours()
    local isOpen = IsStoreOpen(storeConfig, hour)
    local canUse = PlayerCanUseStore(storeConfig)
    local npcExists = storeConfig.NPC and DoesEntityExist(storeConfig.NPC)

    devLog(('%s nearest=%s distance=%.2f open=%s canUse=%s npcAllowed=%s npcExists=%s promptDistance=%.2f renderDistance=%.2f player=%.2f %.2f %.2f store=%.2f %.2f %.2f'):format(
        tostring(reason or 'debug'),
        tostring(storeId),
        distance or -1.0,
        tostring(isOpen),
        tostring(canUse),
        tostring(storeConfig.NPCData and storeConfig.NPCData.Allowed),
        tostring(npcExists),
        tonumber(storeConfig.DistanceOpenStore) or 2.0,
        tonumber(Config.RenderNPCDistance) or 30.0,
        playerCoords and playerCoords.x or 0.0,
        playerCoords and playerCoords.y or 0.0,
        playerCoords and playerCoords.z or 0.0,
        storeConfig.Coords.x,
        storeConfig.Coords.y,
        storeConfig.Coords.z
    ))
end

RegisterCommand('codexstores_debug', function()
    DebugNearestStore('command')
end, false)

RegisterCommand('codexstores_reload', function()
    for storeId, _ in pairs(Config.Stores) do
        RemoveStoreBlip(storeId)
        RemoveStoreNPC(storeId)
    end

    if nativePrompt then
        Citizen.InvokeNative(0x00EDE88D4D13CF59, nativePrompt)
        nativePrompt = nil
        nativePromptGroup = nil
        Prompt = nil
        PromptGroup = nil
    end

    PromptSetUp()
    RefreshStoreBlips()
    devLog('Reloaded prompts, blips and NPC cache. Walk near a store or use /codexstores_debug.')
end, false)

RegisterCommand('codexstores_blips', function()
    RefreshStoreBlips()
end, false)
