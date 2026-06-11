local RESOURCE_NAME = GetCurrentResourceName()
local CodexCore = exports['codex_core']:getLibServer()

local actionCooldowns = {}

local function devLog(message)
    if Config and Config.DevMode then
        print(('[%s][server] %s'):format(RESOURCE_NAME, tostring(message)))
    end
end

local function normalizeQuantity(quantity)
    quantity = tonumber(quantity)

    if not quantity or quantity <= 0 then
        return nil
    end

    if math.floor(quantity) ~= quantity then
        return nil
    end

    return quantity
end

local function round(number, decimals)
    local power = 10 ^ (decimals or 0)
    return math.floor((tonumber(number) or 0) * power + 0.5) / power
end

local function checkJob(jobList, playerJob)
    if not jobList then return true end
    if not playerJob then return false end

    for _, jobName in pairs(jobList) do
        if tostring(jobName) == tostring(playerJob) then
            return true
        end
    end

    return false
end

local function isStoreOpen(storeConfig)
    if not storeConfig or not storeConfig.Hours or not storeConfig.Hours.Allowed then
        return true
    end

    if type(GetClockHours) ~= 'function' then
        return true
    end

    local opening = tonumber(storeConfig.Hours.Opening) or 0
    local closing = tonumber(storeConfig.Hours.Closing) or 24
    local hour = GetClockHours()

    if opening == closing then return true end

    if opening < closing then
        return hour >= opening and hour < closing
    end

    return hour >= opening or hour < closing
end

local function canUseStore(source, storeConfig)
    if not storeConfig then return false end

    if storeConfig.JobsData and storeConfig.JobsData.Allowed then
        return checkJob(storeConfig.JobsData.Jobs, CodexCore.GetJob(source))
    end

    return true
end

local function getProduct(storeId, transactionType, itemName)
    local storeConfig = Config.Stores[storeId]
    if not storeConfig then return nil, nil end

    local packageName = storeConfig.StoreProductsPackage
    local productPackage = Config.StoreProductPackages[packageName]
    local products = productPackage and productPackage[transactionType]

    if not products then return nil, storeConfig end

    local allowedCategories = {}
    for _, categoryData in pairs(storeConfig.Categories or {}) do
        for _, allowedType in pairs(categoryData.types or {}) do
            if allowedType == transactionType then
                allowedCategories[categoryData.category] = true
            end
        end
    end

    for _, product in pairs(products) do
        if product.item == itemName and allowedCategories[product.category] then
            return product, storeConfig
        end
    end

    return nil, storeConfig
end

local function accountForCurrency(currencyType)
    if currencyType == 'dollars' then return 0 end
    if currencyType == 'gold' then return 1 end
    if currencyType == 'cents' then return 2 end
    return 0
end

local function getAccountBalance(source, account)
    if CodexCore.GetAccountMoney then
        return tonumber(CodexCore.GetAccountMoney(source, account)) or 0
    end

    if account == 0 then return tonumber(CodexCore.GetMoney(source)) or 0 end
    if account == 1 then return tonumber(CodexCore.GetGold(source)) or 0 end
    if account == 2 and CodexCore.GetCents then return tonumber(CodexCore.GetCents(source)) or 0 end

    return 0
end

local function triggerAccountRefresh(source)
    SetTimeout(250, function()
        TriggerClientEvent('codex_stores:requestPlayerAccountUpdate', source)
    end)
end

local function isOnCooldown(source)
    local now = GetGameTimer()
    local cooldown = tonumber(Config.ActionCooldown) or 1500

    if actionCooldowns[source] and (now - actionCooldowns[source]) < cooldown then
        return true
    end

    actionCooldowns[source] = now
    return false
end

local function validateStoreAction(source, storeId, transactionType, itemName, quantity)
    quantity = normalizeQuantity(quantity)

    if not quantity then
        SendNotification(source, Locales['WRONG_INPUT'], 'error')
        return nil
    end

    if isOnCooldown(source) then
        SendNotification(source, Locales['SPAMMING'], 'error')
        return nil
    end

    local product, storeConfig = getProduct(storeId, transactionType, itemName)

    if not storeConfig or not product then
        devLog(('Blocked invalid product action from %s. store=%s action=%s item=%s'):format(source, tostring(storeId), tostring(transactionType), tostring(itemName)))
        SendNotification(source, Locales['NOT_SELECTED'], 'error')
        return nil
    end

    if not isStoreOpen(storeConfig) then
        SendNotification(source, 'This store is currently closed.', 'error')
        return nil
    end

    if not canUseStore(source, storeConfig) then
        SendNotification(source, 'You do not have access to this store.', 'error')
        return nil
    end

    if product.jobs and not checkJob(product.jobs, CodexCore.GetJob(source)) then
        SendNotification(source, 'You do not have access to this product.', 'error')
        return nil
    end

    return product, storeConfig, quantity
end

CodexCore.RegisterServerCallback('codex_stores:getItemCount', function(source, cb, itemName)
    if not itemName or itemName == '' then
        cb(0)
        return
    end

    cb(CodexCore.GetItemCount(source, itemName) or 0)
end)

RegisterNetEvent('codex_stores:onSelectedProductPurchase')
AddEventHandler('codex_stores:onSelectedProductPurchase', function(storeId, itemName, _label, quantity)
    local source = source
    local product = nil
    local storeConfig = nil

    product, storeConfig, quantity = validateStoreAction(source, storeId, 'buy', itemName, quantity)
    if not product then return end

    local totalCost = round((tonumber(product.price) or 0) * quantity, 2)
    local account = accountForCurrency(product.currency)
    local balance = getAccountBalance(source, account)

    local canCarryItem = CodexCore.CanCarryItem(source, product.item, quantity)
    if not canCarryItem then
        SendNotification(source, Locales['CANNOT_CARRY'], 'error')
        return
    end

    if balance < totalCost then
        if product.currency == 'gold' then
            SendNotification(source, Locales['NOT_ENOUGH_GOLD'], 'error')
        elseif product.currency == 'cents' then
            SendNotification(source, Locales['NOT_ENOUGH_CENTS_OR_CASH'], 'error')
        else
            SendNotification(source, Locales['NOT_ENOUGH_CASH'], 'error')
        end
        return
    end

    CodexCore.RemoveAccountMoney(source, account, totalCost)
    CodexCore.AddItem(source, product.item, quantity)

    local currencyLabel = Locales['CASH']
    if product.currency == 'gold' then currencyLabel = Locales['GOLD'] end
    if product.currency == 'cents' then currencyLabel = Locales['CENTS'] end

    SendNotification(source, string.format(Locales['SUCESSFULLY_BOUGHT'], quantity, product.label, totalCost, currencyLabel), 'success')
    triggerAccountRefresh(source)
end)

RegisterNetEvent('codex_stores:onSelectedProductSell')
AddEventHandler('codex_stores:onSelectedProductSell', function(storeId, itemName, _label, quantity)
    local source = source
    local product = nil
    local storeConfig = nil

    product, storeConfig, quantity = validateStoreAction(source, storeId, 'sell', itemName, quantity)
    if not product then return end

    local itemQuantity = tonumber(CodexCore.GetItemCount(source, product.item)) or 0

    if quantity > itemQuantity then
        SendNotification(source, Locales['NO_QUANTITY_TO_SELL'], 'error')
        return
    end

    local totalReward = round((tonumber(product.price) or 0) * quantity, 2)

    CodexCore.RemoveItem(source, product.item, quantity)

    if product.currency == 'cents' then
        local dollars = math.floor(totalReward / 100)
        local cents = round(totalReward - (dollars * 100), 2)

        if dollars > 0 then
            CodexCore.AddAccountMoney(source, 0, dollars)
        end

        if cents > 0 then
            CodexCore.AddAccountMoney(source, 2, cents)
        end

        if dollars > 0 then
            SendNotification(source, string.format(Locales['SUCESSFULLY_SOLD2'], quantity, product.label, dollars, Locales['CASH'], cents, Locales['CENTS']), 'success')
        else
            SendNotification(source, string.format(Locales['SUCESSFULLY_SOLD'], quantity, product.label, cents, Locales['CENTS']), 'success')
        end
    else
        local account = accountForCurrency(product.currency)
        CodexCore.AddAccountMoney(source, account, totalReward)

        local currencyLabel = Locales['CASH']
        if product.currency == 'gold' then currencyLabel = Locales['GOLD'] end

        SendNotification(source, string.format(Locales['SUCESSFULLY_SOLD'], quantity, product.label, totalReward, currencyLabel), 'success')
    end

    triggerAccountRefresh(source)
end)

AddEventHandler('playerDropped', function()
    actionCooldowns[source] = nil
end)
