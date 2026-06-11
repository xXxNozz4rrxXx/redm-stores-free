local openedStoreId = nil
local UIData = { category = nil, storeCategoryType = nil }
local hasCooldownAction = false

local function shallowCopy(source)
    local copy = {}
    for key, value in pairs(source or {}) do
        copy[key] = value
    end
    return copy
end

local function sendAccountsToNui()
    EnsureCodexCore()

    SendNUIMessage({
        action = 'updatePlayerAccountInformation',
        accounts = {
            dollars = CodexCore.GetMoney() or 0,
            cents = 0,
            gold = CodexCore.GetGold() or 0,
        }
    })
end

RegisterNetEvent('codex_stores:closeNUI')
AddEventHandler('codex_stores:closeNUI', function()
    SendNUIMessage({ action = 'closeUI' })
end)

RegisterNetEvent('codex_stores:requestPlayerAccountUpdate')
AddEventHandler('codex_stores:requestPlayerAccountUpdate', function()
    sendAccountsToNui()
end)

OpenStoreCategory = function(storeId)
    EnsureCodexCore()
    openedStoreId = storeId
    UIData.category = nil
    UIData.storeCategoryType = nil

    local storeConfig = Config.Stores[storeId]
    if not storeConfig then return end

    ClientData.job = CodexCore.GetJob()

    SendNUIMessage({ action = 'clearStoreCategories' })
    SendNUIMessage({ action = 'clearStoreCategoryTypes' })
    SendNUIMessage({ action = 'clearStoreCategoryProducts' })
    SendNUIMessage({ action = 'updateStoreHeaderTitle', header = storeConfig.StoreName, footer = Locales['choose_category'] })
    sendAccountsToNui()

    for _, categoryData in pairs(storeConfig.Categories or {}) do
        SendNUIMessage({
            action = 'addStoreCategories',
            label = categoryData.category,
        })
    end

    Wait(250)

    UIType = 'enable_shop'
    EnableGui(true, UIType)
end

EnableGui = function(state, ui)
    SetNuiFocus(state, state)

    if not state then
        ClearPedTasks(PlayerPedId())
    end

    IsInMenu = state
    SendNUIMessage({
        type = ui,
        enable = state,
    })
end

RegisterNUICallback('closeNUI', function(_, cb)
    EnableGui(false, UIType)
    if cb then cb({ ok = true }) end
end)

RegisterNUICallback('loadCategories', function(_, cb)
    local storeConfig = Config.Stores[openedStoreId]
    if not storeConfig then
        if cb then cb({ ok = false }) end
        return
    end

    SendNUIMessage({ action = 'clearStoreCategories' })
    SendNUIMessage({ action = 'updateStoreHeaderTitle', header = storeConfig.StoreName, footer = Locales['choose_category'] })

    for _, categoryData in pairs(storeConfig.Categories or {}) do
        SendNUIMessage({ action = 'addStoreCategories', label = categoryData.category })
    end

    if cb then cb({ ok = true }) end
end)

RegisterNUICallback('loadStoreTypeCategories', function(data, cb)
    local storeConfig = Config.Stores[openedStoreId]
    if not storeConfig then
        if cb then cb({ ok = false }) end
        return
    end

    UIData.storeCategoryType = data.category

    SendNUIMessage({ action = 'clearStoreCategoryTypes' })
    SendNUIMessage({ action = 'updateStoreHeaderTitle', header = storeConfig.StoreName, footer = Locales['choose_category'] })

    for _, categoryData in pairs(storeConfig.Categories or {}) do
        if categoryData.category == data.category then
            for _, transactionType in pairs(categoryData.types or {}) do
                SendNUIMessage({
                    action = 'addStoreCategoryTypes',
                    label = transactionType,
                })
            end
        end
    end

    if cb then cb({ ok = true }) end
end)

local function getCurrentLevel(levelingData)
    if not levelingData or not levelingData.Allowed then return 1 end

    local resourceName = Config.LevelingResource or 'codex_leveling'

    if GetResourceState(resourceName) ~= 'started' then
        return 1
    end

    local ok, level = pcall(function()
        return exports[resourceName]:getLevel(levelingData.Type)
    end)

    if ok and tonumber(level) then
        return tonumber(level)
    end

    return 1
end

RegisterNUICallback('loadStoreTypeCategoryProducts', function(data, cb)
    local storeConfig = Config.Stores[openedStoreId]
    if not storeConfig then
        if cb then cb({ ok = false }) end
        return
    end

    local footerText = Locales[(data.category or '') .. '_menu'] or tostring(data.category or '')
    local levelingData = storeConfig.LevelingData
    local currentLevel = getCurrentLevel(levelingData)

    UIData.category = data.category

    SendNUIMessage({ action = 'clearStoreCategoryProducts' })
    SendNUIMessage({ action = 'updateStoreHeaderTitle', header = storeConfig.StoreName, footer = footerText })

    local packageName = storeConfig.StoreProductsPackage
    local productPackage = Config.StoreProductPackages[packageName]
    local productsList = productPackage and productPackage[UIData.category]

    if not productsList then
        if cb then cb({ ok = false }) end
        return
    end

    ClientData.job = CodexCore.GetJob()

    for _, categoryData in pairs(storeConfig.Categories or {}) do
        if categoryData.category == UIData.storeCategoryType then
            for _, product in pairs(productsList) do
                if product.category == UIData.storeCategoryType then
                    local productJobs = product.jobs
                    local hasProductJob = productJobs == nil or CheckJob(productJobs, ClientData.job)

                    if hasProductJob then
                        local productData = shallowCopy(product)
                        productData.hasRequiredLevel = true

                        if levelingData and levelingData.Allowed then
                            productData.hasRequiredLevel = (tonumber(product.requiredLevel or 1) <= currentLevel)
                        end

                        productData.availableCount = 0

                        SendNUIMessage({
                            action = 'addStoreSelectedCategoryProducts',
                            item_data = productData,
                            store_type = data.category,
                        })
                    end
                end
            end
        end
    end

    if cb then cb({ ok = true }) end
end)

RegisterNUICallback('getItemCount', function(data, cb)
    local itemName = data and data.itemName

    if not itemName or itemName == '' then
        SendNUIMessage({ type = 'itemCount', count = 0 })
        if cb then cb({ ok = false, count = 0 }) end
        return
    end

    CodexCore.TriggerServerCallback('codex_stores:getItemCount', function(count)
        count = tonumber(count) or 0
        SendNUIMessage({ type = 'itemCount', count = count })
        if cb then cb({ ok = true, count = count }) end
    end, itemName)
end)

RegisterNUICallback('performActionOnSelectedProduct', function(data, cb)
    if not data or not data.item then
        SendNotification(nil, Locales['NOT_SELECTED'], 'error')
        if cb then cb({ ok = false }) end
        return
    end

    local quantity = tonumber(data.quantity)

    if not quantity or quantity <= 0 or math.floor(quantity) ~= quantity then
        SendNotification(nil, Locales['WRONG_INPUT'], 'error')
        if cb then cb({ ok = false }) end
        return
    end

    if hasCooldownAction then
        SendNotification(nil, Locales['SPAMMING'], 'error')
        if cb then cb({ ok = false }) end
        return
    end

    hasCooldownAction = true

    if data.category == 'buy' then
        TriggerServerEvent('codex_stores:onSelectedProductPurchase', openedStoreId, data.item, data.label, quantity)
    elseif data.category == 'sell' then
        TriggerServerEvent('codex_stores:onSelectedProductSell', openedStoreId, data.item, data.label, quantity)
    end

    SetTimeout(Config.ActionCooldown or 1500, function()
        hasCooldownAction = false
    end)

    if cb then cb({ ok = true }) end
end)
