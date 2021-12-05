local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shield = require(ReplicatedStorage.Common.WeaponClasses.Shield)
local Sword = require(ReplicatedStorage.Common.WeaponClasses.Sword)

local isStudio = RunService:IsStudio()

if isStudio then
    local Sword1 = Sword.new()
    local Shield1 = Shield.new()

    --[[
        Should print
        "high"
        "sword"
        "Sword has attacked"
    ]]
    print(Sword1:GetStance())
    print(Sword1:GetWeaponType())
    print(Sword1:Attack())

end