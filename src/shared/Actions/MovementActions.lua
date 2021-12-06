local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Entity = require(ReplicatedStorage.Common.EntityClass.Entity)

local MovementActions = {}

--[[CFrame is an offset]]
function MovementActions:RollForwards(offset, durationInTicks)
    local durationInTicks = 10
    self:PlayAnimation(8185993105, offset, durationInTicks)
end


return MovementActions