local QBCore = exports['qb-core']:GetCoreObject()
local CurrentCops = -0
local copsCalled = false
local requiredItems = {}
local isLoggedIn = true
PlayerJob = {}

-- Location For Laptop Aninmation
local hackCoord = {x = -595.43,  y = -283.65,  z = 50.60, h = 150}

-- Hacking The Security System
RegisterNetEvent('hackinglaptop:UseHackinglaptop')
AddEventHandler('hackinglaptop:UseHackinglaptop', function()
    if QBCore ~= nil and isLoggedIn then
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - vector3(Config.JewelLocation["HackSecurity"].x, Config.JewelLocation["HackSecurity"].y,Config.JewelLocation["HackSecurity"].z)) < 1.0 then
            if CurrentCops >= Config.RequiredCops then
                QBCore.Functions.TriggerCallback("qb-jewellery:Callback:Cooldown",function(isCooldown)
                    if not isCooldown then
                        local pos = GetEntityCoords(PlayerPedId())
                        if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                        end
                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
                            if hasItem then
                            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                            TriggerServerEvent("qb-jewellery:server:SetHackSecurityStatus", "isBusy", true)
                            QBCore.Functions.Progressbar("power_hack", "Hacking Security", math.random(4500, 4600), false, true, {
                                   useWhileDead = false,
                                   canCancel = false,
                                   controlDisables = {
                                   disableMovement = true,
                                   disableCarMovement = false,
                                   disableMouse = false,
                                   disableCombat = false,
                                },
                            })
                            HackAnim()
                            Wait(2000)
                            exports['hacking']:OpenHackingGame(Config.VangelicoTime, Config.VangelicoBlocks, Config.VangelicoRepeat, function(Success)
                                if Success then
                                    SecuritySuccess()
                                    HackSuccessAnim()
                                    TriggerServerEvent('nui_doorlock:server:updateState', "doubledoor",  false, false, false, true)
                                    TriggerServerEvent('qb-jewellery:BeginCooldown')
                                else
                                    SecurityFailed()
                                    HackFailedAnim()
                                end
                            end)                        
                        else
                            QBCore.Functions.Notify(Lang:t("error.wrong_equipment"), "error", 3500)
                            --QBCore.Functions.Notify("You Don\'t Have The Correct Equipment!", "error")   
                        end
                    end, "usb_green")
                else
                    QBCore.Functions.Notify(Lang:t("error.cooldown"), "error", 3500)
                    --QBCore.Functions.Notify("This Has Just Been Hit, You'll Have To Wait!", "error")
                end      
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.required_police"), "error", 3500)
            --QBCore.Functions.Notify('Not Enough Police ('.. Config.RequiredCops ..') Required!', 'error')
        end 
    end   
else
    Citizen.Wait(3000)
end

end)

-- Hack Into Security System!
function HackAnim()
    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s") 
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local cardLoc = vector4(-595.43, -283.65, 50.60, 150)

    SetEntityHeading(ped, hackCoord.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", hackCoord.x, hackCoord.y, hackCoord.z+0.80, hackCoord.x, hackCoord.y, hackCoord.z+0.85, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", hackCoord.x, hackCoord.y, hackCoord.z+0.80, hackCoord.x, hackCoord.y, hackCoord.z+0.85, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", hackCoord.x, hackCoord.y, hackCoord.z+0.80, hackCoord.x, hackCoord.y, hackCoord.z+0.85, 0, 2)

    netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), cardLoc, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)

    netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)

    netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

    SetPedComponentVariation(ped, 5, 0, 0, 0)
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
end

RegisterNetEvent('thermite:UseThermite')
AddEventHandler('thermite:UseThermite', function()
    local pos = GetEntityCoords(PlayerPedId())
    if #(pos - vector3(Config.JewelLocation["DisableCameras"].x, Config.JewelLocation["DisableCameras"].y,Config.JewelLocation["DisableCameras"].z)) < 1.5 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
            if Config.JewelLocation["HackSecurity"].isDone then
                if hasItem then
                    TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                    TriggerServerEvent("qb-jewellery:server:SetCameraStatus", "isBusy", true)
                    exports["memorygame"]:thermiteminigame(Config.CorrectBlocks, Config.IncorrectBlocks, Config.TimeToShow, Config.TimeToLose,
                    function() -- Successfully Disable Cameras
                        ThermiteAnimation1() 
                        CamerasSucess()
                        TriggerServerEvent('nui_doorlock:server:updateState', "doubledoor",  false, false, false, true)
                     end,
                     function() -- Fail To Disable Cameras
                        CamerasFailed()
                     
                    end) 
                
                else
                    QBCore.Functions.Notify(Lang:t("error.wrong_equipment"), "error", 3500)
                    --QBCore.Functions.Notify("You Don\'t Have The Correct Equipment!", "error")
                end

            else
                QBCore.Functions.Notify(Lang:t("error.cooldown_disable"), "error", 3500)
                --QBCore.Functions.Notify("You Haven't Hacked The Security System Yet!", "error")
            end
            
        end, "thermite")
        
    end

end)

-- Effect for Thermite
RegisterNetEvent("Peely-ptfxparticle")
AddEventHandler("Peely-ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(-632.07, -233.88, 38.00)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(5000)
    StopParticleFxLooped(effect, 0)
end)

-- 1st Thermite Animation
function ThermiteAnimation1() 
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
    SetEntityHeading(ped, 125)
    Citizen.Wait(100)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-632.11, -234.92, 38.07, rotx, roty, rotz + 125, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -632.11, -234.92, 38.07,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("Peely-particleserver", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end

------- / Trigger Status

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    TriggerServerEvent("qb-jewellery:server:SetJewelLocations")
end)

RegisterNetEvent('qb-jewellery:client:ConfigLocs')
AddEventHandler('qb-jewellery:client:ConfigLocs', function(list)
    Config.JewelLocation = list
end)

-- Hacking Security System!
RegisterNetEvent('qb-jewellery:client:SetHackSecurityStatus')
AddEventHandler('qb-jewellery:client:SetHackSecurityStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["HackSecurity"].isBusy = state
        print("Hack is Busy")
    elseif stateType == "isDone" then
        Config.JewelLocation["HackSecurity"].isDone = state
        print("Hack is Done")
    end
end)

-- Disabling The Cameras
RegisterNetEvent('qb-jewellery:client:SetCameraStatus')
AddEventHandler('qb-jewellery:client:SetCameraStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["DisableCameras"].isBusy = state
    elseif stateType == "isDone" then
        Config.JewelLocation["DisableCameras"].isDone = state
    end
end)

-- Functions


function HackSuccessAnim()
    NetworkStartSynchronisedScene(netScene3)
    Wait(2500)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(laptop)
    DeleteObject(bag)
    DeleteObject(card)    
end

function HackFailedAnim()
    NetworkStartSynchronisedScene(netScene3)
    Wait(2500)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(laptop)
    DeleteObject(bag)
    DeleteObject(card)    
end

-- Hack Security Fail
function SecurityFailed()
    QBCore.Functions.Notify(Lang:t("error.security_fail"), "error", 3500)
    --QBCore.Functions.Notify("You Failed To Hack The Security System!", "error")
    TriggerServerEvent('qb-jewellery:server:policeAlert')
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    TriggerServerEvent("qb-jewellery:server:SetHackSecurityStatus", "isBusy", false)    
end

-- Hack Security Successfully
function SecuritySuccess()
    QBCore.Functions.Notify(Lang:t("error.security_success"), "success", 3500)
    --QBCore.Functions.Notify("You Successfully Hacked The Security System!", "success")
    TriggerServerEvent('qb-jewellery:Server:BeginCooldown')
    TriggerServerEvent("QBCore:Server:RemoveItem", "usb_green", 1)
    local pos = GetEntityCoords(PlayerPedId())
    if #(pos - vector3(Config.JewelLocation["HackSecurity"].x, Config.JewelLocation["HackSecurity"].y,Config.JewelLocation["HackSecurity"].z)) < 1.5 then
        TriggerServerEvent("qb-jewellery:server:SetHackSecurityStatus", "isDone", true)
        TriggerServerEvent("qb-jewellery:server:SetHackSecurityStatus", "isBusy", false)  
    end
end

-- Fail Disabled Cameras
function CamerasFailed()
    QBCore.Functions.Notify(Lang:t("error.camera_fail"), "error", 3500)
    --QBCore.Functions.Notify("You Failed To Disabled The Security!", "error")
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    TriggerServerEvent("qb-jewellery:server:SetCameraStatus", "isBusy", false)    
end

-- Successfully Disabling Cameras
function CamerasSucess()
    QBCore.Functions.Notify(Lang:t("error.camera_success"), "success", 3500)
    --QBCore.Functions.Notify("You Have Disabled The Security!", "success")
    local pos = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('qb-jewellery:server:policeAlert')
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1)
    if #(pos - vector3(Config.JewelLocation["DisableCameras"].x, Config.JewelLocation["DisableCameras"].y,Config.JewelLocation["DisableCameras"].z)) < 1.5 then
        TriggerServerEvent("qb-jewellery:server:SetCameraStatus", "isDone", true)
        TriggerServerEvent("qb-jewellery:server:SetCameraStatus", "isBusy", false)  
    end
end

-- Leaves FingerPrints Behind For Police
function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

-- Creates Smoke For Thermite
function CreateFire(coords, time)
    for i = 1, math.random(1, 7), 1 do
        TriggerServerEvent("thermite:StartServerFire", coords, 24, false)
    end
    Citizen.Wait(time)
    TriggerServerEvent("thermite:StopFires")
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


-- Creates Animation For Smashing Cases
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(3)
    end
end

-- Loads Particles For The Glass Cases
function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

-- Checks Player For Whitelisted Weapon
function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

-- Creates Stage For Stealing From Cases / Needs Updating
function smashVitrine(k)
    local animDict = "missheist_jewel"
    local animName = "smash_case"
    local ped = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
    local pedWeapon = GetSelectedPedWeapon(ped)
    if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
    elseif math.random(1, 100) <= 5 and IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
        QBCore.Functions.Notify(Lang:t("error.fingerprints_left"), "success", 3500)
        --QBCore.Functions.Notify('You\'ve Left Fingerprints On The Glass', 'error')
    end
    smashing = true
    QBCore.Functions.Progressbar("smash_vitrine", "Grabbing Jewellery", Config.WhitelistedWeapons[pedWeapon]["timeOut"], false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-jewellery:server:setVitrineState', "isOpened", true, k)
        TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", false, k)
        TriggerServerEvent('qb-jewellery:server:vitrineReward')
        TriggerServerEvent('qb-jewellery:server:setTimeout')
        TriggerServerEvent('police:server:policeAlert', 'Robbery in progress')
        smashing = false
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end, function() -- Cancel
        TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", false, k)
        smashing = false
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end)
    TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", true, k)

    CreateThread(function()
        while smashing do
            loadAnimDict(animDict)
            TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Wait(500)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
            loadParticle()
            StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
            Wait(2500)
        end
    end)
end

------- / Needs Updating

RegisterNetEvent('qb-jewellery:client:startbreakinglass')
AddEventHandler('qb-jewellery:client:startbreakinglass', function()
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false

        if QBCore ~= nil and isLoggedIn then
            for case,_ in pairs(Config.Locations) do
                local dist = #(pos - vector3(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"]))
                local storeDist = #(pos - vector3(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"]))
                if dist < 30 then
                    inRange = true
                    if dist < 0.6 then
                        if not Config.Locations[case]["isBusy"] and not Config.Locations[case]["isOpened"] then
                            QBCore.Functions.TriggerCallback('qb-jewellery:server:getCops', function(cops)
                                if Config.JewelLocation["DisableCameras"].isDone then 
                                    if validWeapon() then
                                        smashVitrine(case)
                                    else
                                        QBCore.Functions.Notify(Lang:t("error.weak_weapon"), "error", 3500)
                                        --QBCore.Functions.Notify('This Weapon Isn\'t Strong Enough', 'error')
                                    end
                                else
                                    QBCore.Functions.Notify(Lang:t("error.disable_security"), "error", 3500)
                                    --QBCore.Functions.Notify("Destroy The Alarm System!", "error")
                                end               
                            end) 
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
end)

------ / Events / Done & Finished

RegisterNetEvent('qb-jewellery:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)

------ / Export Target / Done & Finished

-- Open Vangelico Doors
CreateThread(function()
    exports['qb-target']:AddBoxZone("HackSecurity", vector3(-595.8919, -283.6523, 50.3237), 0.40, 0.90, {
        name = "StartJewel",
        heading = 302.7994,
        debugPoly = false,
        minZ = 50.3 - 0.2,
        maxZ = 50.3 + 1.0,
    }, {
        options = {
            {
                type = "client",
                event = "hackinglaptop:UseHackinglaptop",
                icon = 'fas fa-gem',
                label = 'Hack Security',
            }
        },
        distance = 2.5,
    })
end)

------ / Export Target / Done & Finished

-- Reopen Vangelico Doors
CreateThread(function()
    exports['qb-target']:AddBoxZone("DisableSecurity", vector3(-632.15, -234.95, 38.00), 1.2, 0.1, {
        name = "DisableCamera",
        heading = 35.5005,
        debugPoly = false,
        minZ = 38.3 - 0.62,
        maxZ = 38.3 + 1.05,
    }, {
        options = {
            {
                type = "client",
                event = "thermite:UseThermite",
                icon = 'fas fa-video',
                label = 'Disable Cameras',
            }
        },
        distance = 5.0,
    })
end)


-- Break in Jewellery Cases
CreateThread(function()
    local models = {
        'des_jewel_cab_start',
        'des_jewel_cab2_start',
        'des_jewel_cab3_start',
        'des_jewel_cab4_start',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = "client",
                event = "qb-jewellery:client:startbreakinglass",
                icon = "fas fa-gem",
                label = "Smash Case!",
            }
        },
        distance = 2.5,
    })
end)

------ / Blip Location / Done & Finished

Citizen.CreateThread(function()
    Dealer = AddBlipForCoord(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])

    SetBlipSprite (Dealer, 617)
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, 0.6)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, 3)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vangelico Jewellery")
    EndTextCommandSetBlipName(Dealer)
end)