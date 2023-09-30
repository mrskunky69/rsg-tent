local RSGCore = exports['rsg-core']:GetCoreObject()

local ObjectList = {}

RegisterNetEvent('tent:Client:SpawnAmbulanceBag', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 1.5)
    local spawnedObj = CreateObject(Config.Bag.AmbulanceBag[type].model, x, y, coords.z-1, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Bag.AmbulanceBag[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = vector3(x, y, z - 0.3),
    }
    TriggerServerEvent("tent:Server:RemoveItem","tent",1)
end)

RegisterNetEvent('tent:Client:spawnbag', function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
    progressBar("Putting the tent down...")
    Wait(2500)
    TriggerServerEvent("tent:Server:SpawnAmbulanceBag", "tent")
end)

RegisterNetEvent('tent:Client:GuardarAmbulanceBag')
AddEventHandler("tent:Client:GuardarAmbulanceBag", function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    local AmbulanceBag = GetClosestObjectOfType(playerPedPos, 10.0, GetHashKey("mp005_s_posse_tent_bountyhunter07x"), false, false, false)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
    progressBar("Taking Back The Tent...")
    Wait(2500)
    Notify("Taken Back with success.")
    SetEntityAsMissionEntity(AmbulanceBag, 1, 1)
    DeleteObject(AmbulanceBag)
    TriggerServerEvent("tent:Server:AddItem","tent",1)
end)

local citizenid = nil
AddEventHandler("tent:Client:StorageAmbulanceBag", function()
    local charinfo = RSGCore.Functions.GetPlayerData().charinfo
    citizenid = RSGCore.Functions.GetPlayerData().citizenid
    TriggerEvent("inventory:client:SetCurrentStash", "tent",citizenid)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tent",citizenid, {
        maxweight = 40000,
        slots = 48,
    })
end)

local AmbulanceBags = {
    `mp005_s_posse_tent_bountyhunter07x`,
}

exports['rsg-target']:AddTargetModel(AmbulanceBags, {
    options = {{event   = "tent:Client:MenuAmbulanceBag",icon    = "fa-solid fa-box",label   = "storage"},
    {event   = "tent:Client:GuardarAmbulanceBag",icon    = "fa-solid fa-box",label   = "Take Back Tent"},{event   = "rsg-gangmenu:client:OpenMenu",icon    = "fa-solid fa-box",label   = "gang menu"},},distance = 2.0 })
