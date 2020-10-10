local Proxy = module("_core", "libs/Proxy")
local Tunnel = module("_core", "libs/Tunnel")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("cAPI")


RegisterServerEvent("_status:sendCharacterInfo")
AddEventHandler("_status:sendCharacterInfo", function()
    local src = source
    local User = API.getUserFromSource(src) --Grabs all User Data Tables
    local Character = User:getCharacter()
    local CharacterHunger = json.decode(Character:getData(Character:getId(), 'charTable', 'hunger'))
    local CharacterThirst = json.decode(Character:getData(Character:getId(), 'charTable', 'thirst'))
    CharacterHunger = tonumber(CharacterHunger)
    CharacterThirst = tonumber(CharacterThirst)
    local HungerThirstValues = {}
    table.insert(HungerThirstValues, math.floor(CharacterHunger))
    table.insert(HungerThirstValues, math.floor(CharacterThirst))
    
   
	TriggerClientEvent("_status:retrieveCharacterInfo", src, CharacterHunger, CharacterThirst)
end)