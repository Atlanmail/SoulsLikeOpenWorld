local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Actions = require(ReplicatedStorage.Common.ActionClass.Action)

local MovementActions = {}
setmetatable(MovementActions, Actions)

--[[CFrame is an offset]]
function MovementActions:RollForwards(durationInSeconds)
    
    if self:GetIsPlayingAnimation() == true then
        return
    end 

    
    local durationInSeconds = durationInSeconds or 1
    local humanoid = self:GetHumanoid()
    local initialWalkspeed = humanoid.WalkSpeed
     
    self.IsPlayingAnimation = true

    
    humanoid.WalkSpeed = 0
    
    local movementCoroutine = coroutine.create(self.DisplaceModel)
    coroutine.resume(movementCoroutine, self, Vector3.new(0,0,-50), 1)
    ---self:PlayAnimation(8185993105, durationInSeconds)
    humanoid.WalkSpeed = initialWalkspeed

    self.IsPlayingAnimation = false
end


return MovementActions