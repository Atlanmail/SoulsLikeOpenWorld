--[[
    Sword extends weapon
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Weapon = require(ReplicatedStorage.Common.WeaponClasses.Weapon)

local Sword = {}
Sword.__index = Sword
setmetatable(Sword, Weapon)

function Sword.new()
    local newSword = Weapon.new()
    newSword.weaponType = "sword"

    setmetatable(newSword, Sword)
    return newSword
end

function Sword:Attack() 
    print("Sword has attacked")
end

return Sword