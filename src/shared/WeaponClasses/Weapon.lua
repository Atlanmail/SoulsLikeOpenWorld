local Weapon = {}
Weapon.__index = Weapon

--[[
    possible stances: high, low
]]

function Weapon.new()
    local newWeapon = {}
    newWeapon.stance = "high"
    newWeapon.weaponType = "none"
    setmetatable(newWeapon, Weapon)
    return newWeapon
end

function Weapon:ChangeStance()
    if self.stance == "high" then
        self.stance = "low"
    else
        self.stance = "high"
    end
end

function Weapon:GetStance()
    if self.stance == "high" then
        return "high"
    elseif self.stance == "low" then
        return "low"
    end

    error("Stance is not valid Stance: " .. self.stance)
end

function Weapon:GetWeaponType()
    return self.weaponType
end

return Weapon
