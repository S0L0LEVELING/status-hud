local defaultHunger = 100
local defaultThirst = 100
local decayHungerValue = 100
local decayThirstValue = 100
local status = nil
local InAction = true
local isRendering = false


function Initialize(scaleform)
  local scaleform = RequestScaleformMovie(scaleform)

  while not HasScaleformMovieLoaded(scaleform) do
    Citizen.Wait(0)
  end

  PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
  PushScaleformMovieFunctionParameterString("~r~WASTED")
  PushScaleformMovieFunctionParameterString("")
  PopScaleformMovieFunctionVoid()
  return scaleform

end

function startScaleform()
  isRendering = true
end

function stopScaleform()
  isRendering = false
end

function renderScaleform(scaleform)
  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
end

RegisterNetEvent("_status:retrieveCharacterInfo")
AddEventHandler("_status:retrieveCharacterInfo", function (CharacterHunger , CharacterThirst)
     decayHungerValue = CharacterHunger
     decayThirstValue = CharacterThirst    
    --print(decayHungerValue, decayThirstValue)
    

    
end)


Citizen.CreateThread(function()
local initalizedScaleform = Initialize("mp_big_message_freemode")
while true do
  if isRendering then
    renderScaleform(initalizedScaleform)
    end
  Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(5000)
      --print(defaultHunger - decayHungerValue)
    local values =  {
      show = true,
      hunger = defaultHunger - decayHungerValue,
      thirst = defaultThirst - decayThirstValue,
      health = GetEntityHealth(GetPlayerPed(-1)) - 100,
      armor = GetPedArmour(GetPlayerPed(-1)),
      stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
      st = status,
      getvehicle = IsPedInAnyVehicle(GetPlayerPed(-1)),
      carhealth = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)), false),  
    }
    TriggerEvent('_status:updateStatus', values)
        end
    end)

   --[[ Citizen.CreateThread(function()
      while true do
        Citizen.Wait(1000)
        --print(defaultHunger - decayHungerValue)
      
      local values =  {
        health = GetEntityHealth(GetPlayerPed(-1)) - 100,
        armor = GetPedArmour(GetPlayerPed(-1)),
        stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
 
      }
     
      TriggerEvent('_status:updateStatus', values)
          
          end
      end)]]--

RegisterNetEvent('_status:updateStatus')
AddEventHandler('_status:updateStatus', function(Status)
status = Status
SendNUIMessage({
  type = "update_ui",
  values = Status,
})
end)
RegisterNetEvent('_status:showUI')
AddEventHandler('_status:showUI', function()
SendNUIMessage({
  type = "show_needs_ui",
  
})
end)
