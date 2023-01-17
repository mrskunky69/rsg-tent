local RSGCore = exports['rsg-core']:GetCoreObject()
local xSound = exports.xsound
local isPlaying = false

RSGCore.Functions.CreateUseableItem("tent", function(source, item)
	local src = source
	local Player = RSGCore.Functions.GetPlayer(src)
	TriggerClientEvent('rsg_tent:client:placeDJEquipment', src)
	Player.Functions.RemoveItem('tent', 1)
	TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['tent'], "remove")
end)


RegisterNetEvent('rsg_mobiledj:server:pickedup', function(entity)
    local src = source
    xSound:Destroy(-1, tostring(entity))
end)


RegisterNetEvent('rsg_mobiledj:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)

RegisterServerEvent('rsg_tent:server:pickeupdecks')
AddEventHandler('rsg_tent:server:pickeupdecks', function()
	local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
	Player.Functions.AddItem('tent', 1)
	TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['tent'], "add")
end)