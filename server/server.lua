local RSGCore = exports['rsg-core']:GetCoreObject()
local xSound = exports.xsound
local isPlaying = false

RSGCore.Functions.CreateUseableItem("tent", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
	local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
	if Player.Functions.RemoveItem(item.name, 0, item.slot) then
        TriggerClientEvent("rsg_tent:client:placeDJEquipment", source, item.name)
		TriggerEvent('rsg-log:server:CreateLog', 'camp', 'CAMPING ⛺', 'yellow', firstname..' '..lastname..' IS SETTING UP CAMP ⛺')
    end
end)


RegisterNetEvent('rsg_tent:server:pickedup', function(entity)
    local src = source
    xSound:Destroy(-1, tostring(entity))
end)


RegisterNetEvent('rsg_tent:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
	
end)

RegisterServerEvent('rsg_tent:server:pickeupdecks')
AddEventHandler('rsg_tent:server:pickeupdecks', function()
	local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
	local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
	Player.Functions.AddItem('tent', 0)
	TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[tent], "add")
	
end)