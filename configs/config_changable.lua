local RSGCore = exports['rsg-core']:GetCoreObject()



RegisterNetEvent('tent:Client:MenuAmbulanceBag', function()
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then return Notify("You cannot Open  while dead", "error") end
    if IsPedSwimming(playerPed) then return Notify("You cannot Open  in the water.", "error") end
    if IsPedSittingInAnyVehicle(playerPed) then return Notify("You cannot Open inside a vehicle", "error") end
    local job = RSGCore.Functions.GetPlayerData().job.name
    if Config.Bag.NeedJob == true then
        if job ~= Config.Bag.Job then
            Notify("You dont have permissions to Open ")
            return false
        end
    end
    exports['rsg-menu']:openMenu({
        { header = "tent", txt = "", isMenuHeader = true },
        { header = "Open storage",  params = { event = "tent:Client:StorageAmbulanceBag" } },

        -- You can add more menus with your's personal events...
        { header = "", txt = "❌ Close", params = { event = "rsg-menu:closeMenu" } },
    })
end)

