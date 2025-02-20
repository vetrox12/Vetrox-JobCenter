function CreateNPC(type, model, anim, dict, pos, help)
    local ped
    Citizen.CreateThread(function()
        local hash = GetHashKey(model)

        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(1)
        end

        RequestAnimDict(anim)
        while not HasAnimDictLoaded(anim) do
            Wait(1)
        end

        ped = CreatePed(type, hash, pos.x, pos.y, pos.z, pos.h, false, true)
        SetEntityHeading(ped, pos.h)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped, anim, dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end)
    
    while not ped do
        Citizen.Wait(100)
    end
    return ped
end

RegisterNetEvent("Vetrox:Ui:JobCenter", function(ui)
    if ui == true then
        SetNuiFocus(true, true)
        SendNUIMessage({
            CheckUi = "OpenUi",
            Language = UI.UiLanguage,
            Locales = UI.Locales[UI.UiLanguage],
            Jobs = Config.Jobs,
        })
    elseif ui == false then
        SetNuiFocus(false, false)
        SendNUIMessage({
            CheckUi = "CloseUi"
        })
    end
end)

RegisterNetEvent("vetrox:open:Owd3JobCenter", function()
    TriggerEvent("Vetrox:Ui:JobCenter", true)
end)

RegisterNUICallback("VetroxCloseUIToLua", function()
    TriggerEvent("Vetrox:Ui:JobCenter", false)
end)

RegisterNUICallback("VxChangeJob", function(data)
    TriggerServerEvent("CJobWiWi", data.JobLua, tonumber(data.JobGradeLua))
    TriggerEvent("Vetrox:Ui:JobCenter", false)
    exports[Exports.core]:GetCoreObject().Functions.Notify(UI.Locales[UI.UiLanguage]["TakeJobNotify"] .. " " .. exports[Exports.core]:GetCoreObject().Shared.Jobs[data.JobLua].label .. ".", "success", 5000)
end)

RegisterNUICallback("MakeWayPoint", function(data)
    local x, y, z = data.CoordsLua:match("([^,]+),%s*([^,]+),%s*([^,]+)")
    SetNewWaypoint(tonumber(x), tonumber(y), tonumber(z)) 
    TriggerEvent("Vetrox:Ui:JobCenter", false)
    exports[Exports.core]:GetCoreObject().Functions.Notify(UI.Locales[UI.UiLanguage]["MarkLocateNotify"], "success", 5000)
end)

CreateThread(function()
    for k, v in pairs(Config.targets) do
        CreateNPC(4, v.ped, "mini@strip_club@idles@bouncer@base", "base", {x = v.vector3.x, y = v.vector3.y, z = v.vector3.z - 1, h = v.heading}, "")
        local blip = AddBlipForCoord(v.vector3.x, v.vector3.y, v.vector3.z)
        SetBlipSprite(blip, v.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.blip.scale)
        SetBlipColour(blip, v.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.blip.label)
        EndTextCommandSetBlipName(blip)
        exports[Exports.Target]:AddBoxZone("VetroxJobCenter_1222" ..  '"' .. k ..  '"', v.vector3, v.info1, v.info2, {
            name = "VetroxJobCenter_1222" ..  '"' .. k ..  '"',
            heading = v.heading,
            debugPoly = false,
            minZ= v.minZ,
            maxZ= v.maxZ,
        }, {
            options = {
                {
                    type = "Client",
                    event = "vetrox:open:Owd3JobCenter",
                    icon = "fas fa-circle",
                    label = v.TargetLabel,
                },
            },
            distance = 2.0
        })
    end
end)

-- Vetrox https://discord.gg/jc3bxNTD9Y