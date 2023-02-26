function Login.playerLoaded() end

function Login.characterLoaded()
 -- Main events leave alone 
 TriggerEvent("np-base:playerSpawned")
 TriggerEvent("playerSpawned")
 TriggerServerEvent('character:loadspawns')
 -- Main events leave alone 

 TriggerEvent("Relog")

 -- Everything that should trigger on character load 
 TriggerServerEvent('checkTypes')
 TriggerServerEvent('isVip')
 TriggerEvent('rehab:changeCharacter')
 TriggerEvent("resetinhouse")
 TriggerEvent("fx:clear")
 TriggerServerEvent("raid_clothes:retrieve_tats")
 TriggerServerEvent('Blemishes:retrieve')
 TriggerServerEvent("currentconvictions")
 TriggerServerEvent("GarageData")
 TriggerServerEvent("Evidence:checkDna")
 TriggerEvent("banking:viewBalance")
 TriggerServerEvent("police:getLicensesCiv")
 TriggerServerEvent('np-doors:requestlatest')
 TriggerServerEvent("item:UpdateItemWeight")
 TriggerServerEvent("np-weapons:getAmmo")
 TriggerServerEvent("ReturnHouseKeys")
 TriggerServerEvent("requestOffices")
 TriggerServerEvent('np-base:addLicenses')
 Wait(500)
 TriggerServerEvent('commands:player:login')
 TriggerServerEvent("police:getAnimData")
 TriggerServerEvent("police:getEmoteData")
 TriggerServerEvent("police:SetMeta")
 TriggerServerEvent("retreive:licenes:server")
 TriggerServerEvent("clothing:checkIfNew")
 -- Anything that might need to wait for the client to get information, do it here.
 Wait(3000)
 TriggerServerEvent("bones:server:requestServer")
 TriggerEvent("apart:GetItems")
 TriggerEvent("np-editor:readyModels")
 Wait(4000)
 TriggerServerEvent('distillery:getDistilleryLocation')
 TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))	
 TriggerServerEvent("bank:getLogs")
 TriggerEvent('np-hud:EnableHud', true)
 TriggerServerEvent('void:getmapprefrence')
 TriggerServerEvent('np-phone:grabWallpaper')
 TriggerServerEvent('banking-loaded-in')
 TriggerServerEvent('np-base:updatedphoneLicenses')
 TriggerServerEvent('getallplayers')
 TriggerEvent("np-base:PolyZoneUpdate")
 TriggerServerEvent('np-scoreboard:AddPlayer')
 TriggerServerEvent("server:currentpasses")
 TriggerServerEvent('np-base:addLicenses')
 TriggerEvent("np-newphone:phone:fetch")
end

function Login.characterSpawned()

  hasGivenItems = false
  isNear = false
  TriggerServerEvent('np-base:sv:player_control')
  TriggerServerEvent('np-base:sv:player_settings')

  TriggerServerEvent("TokoVoip:clientHasSelecterCharacter")
  TriggerEvent("spawning", false)
  TriggerEvent("inSpawn", false)
  TriggerEvent("attachWeapons")
  TriggerEvent("tokovoip:onPlayerLoggedIn", true)

  TriggerEvent("np-hud:initHud")

  TriggerServerEvent("request-dropped-items")
  TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))

  if Spawn.isNew then
      Wait(1000)
      TriggerEvent("hud:saveCurrentMeta")

     -- Only give the items once
     if not hasGivenItems then
      TriggerEvent("player:receiveItem", "idcard", 1)
      TriggerEvent("player:receiveItem", "mobilephone", 1)
      TriggerEvent("player:receiveItem", "present", 1)
      hasGivenItems = true
  end

      local src = GetPlayerServerId(PlayerId())
      TriggerServerEvent("registerboosting", src)
      TriggerServerEvent("reviveGranted", src)
      TriggerEvent("Hospital:HealInjuries", src, true)
      TriggerServerEvent("ems:healplayer", src)
      TriggerEvent("heal", src)
      TriggerEvent("status:needs:restore", src)

      TriggerServerEvent("np-spawn:newPlayerFullySpawned")
  end

  SetPedMaxHealth(PlayerPedId(), 200)
  
  runGameplay() -- moved from NP-base 
  Spawn.isNew = false
end

-- Add a new flag to track if the items have already been given
local hasGivenItems = false

RegisterNetEvent("np-spawn:characterSpawned");
AddEventHandler("np-spawn:characterSpawned", Login.characterSpawned);

RegisterNetEvent("np-spawn:getStartingItems");
AddEventHandler("np-spawn:getStartingItems", function()
  TriggerEvent("player:receiveItem", "idcard",1,true,information)
	TriggerEvent("player:receiveItem", "mobilephone",1,true,information)
end)

RegisterNetEvent("np-spawn:getNewAccountBox");
AddEventHandler("np-spawn:getNewAccountBox", function(cid)
  TriggerEvent("player:receiveItem", "newaccountbox", 1)
end)
