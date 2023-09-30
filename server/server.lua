local RSGCore = exports['rsg-core']:GetCoreObject()

local Objects = {}

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

RSGCore.Functions.CreateUseableItem('tent', function(source, item)TriggerClientEvent("tent:Client:spawnbag", source)end)

RegisterNetEvent('tent:Server:SpawnAmbulanceBag', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("tent:Client:SpawnAmbulanceBag", src, objectId, type, src)
end)

RegisterNetEvent('tent:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)

RegisterNetEvent('tent:Server:AddItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount)
end)


