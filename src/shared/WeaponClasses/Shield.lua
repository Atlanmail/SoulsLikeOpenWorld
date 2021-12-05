--[[
    Shield extends weapon
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Weapon = require(ReplicatedStorage.Common.WeaponClasses.Weapon)

local Shield = {}
Shield.__index = Shield
setmetatable(Shield, Weapon)

function Shield.new()
    local newShield = Weapon.new()
    newShield.weaponType = "shield"

    setmetatable(newShield, Shield)

    return newShield
end

function Shield:Block() 
    print("Shield has attacked")
end

return Shield