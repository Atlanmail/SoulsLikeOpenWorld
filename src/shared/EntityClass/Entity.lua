local Entity = {}
Entity.__index = Entity

function Entity.new(model)
    local newEntity = {}
    newEntity.model = model
    newEntity.humanoid = model:WaitForChild("Humanoid")
    newEntity.animator = newEntity.humanoid:WaitForChild("Animator")
    newEntity.humanoidRootPart = model:WaitForChild("HumanoidRootPart")
    newEntity.animations = {}
    setmetatable(newEntity, Entity)

    return newEntity
end

function Entity:GetHumanoid()
    return self.humanoid
end

function Entity:GetAnimator()
    return self.animator
end
--[[
    Set's an animation to be loaded later

    animation = ID
]]
function Entity:setAnimationFromID(animationID)
    local humanoid = self:GetHumanoid()
    local animator = self:GetAnimator()

    local newAnimation = Instance.new("Animation")
    newAnimation.AnimationId = "rbxassetid://" .. animationID

    local animationTrack = animator:LoadAnimation(newAnimation)
    self.animations[animationID] = animationTrack

end

--[[
    Plays an animation on a character while offsetting it in a certain direction
    entity for a certain time
    @param 
    animation = ID
    offset = CFrame relative to the entity
    durationInTicks = durationInTicks
    Animation needs to be set first
]]



function Entity:PlayAnimation( animationID, offset, durationInTicks) 
    
    local animationTrack = self.animations[animationID]
    local originalSpeed = animationTrack.Length
    local newSpeed = originalSpeed / durationInTicks 
    animationTrack:AdjustSpeed(newSpeed)

    animationTrack:Play()

    animationTrack:AdjustSpeed(originalSpeed)
end

function Entity:GetHumanoidRootPart()
    return self.humanoidRootPart
end

return Entity