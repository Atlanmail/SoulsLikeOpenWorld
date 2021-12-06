local Entity = {}
Entity.__index = Entity

function Entity.new(model)
    local newEntity = {}
    newEntity.model = model
    newEntity.humanoid = model:WaitForChild("Humanoid")
    newEntity.animator = newEntity.humanoid:WaitForChild("Animator")
    newEntity.humanoidRootPart = model:WaitForChild("HumanoidRootPart")
    newEntity.animations = {}
    newEntity.IsPlayingAnimation = false
    setmetatable(newEntity, Entity)

    return newEntity
end



--[[
    LoadActions from a library of actions
]]

function Entity:LoadActions(path)
    local ActionsToLoad = require(path)
    print(ActionsToLoad)
    local methodsToAddTo = getmetatable(self)
    
    for i, v in pairs(ActionsToLoad) do
        if methodsToAddTo[i] == nil then
            methodsToAddTo[i] = v
        else
            print("overlap")
            return
        end
    end
    setmetatable(self, methodsToAddTo)

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


function Entity:PlayAnimation( animationID, offset, durationInSeconds) 
    if self:GetIsPlayingAnimation() == true then
        return
    end
    self.IsPlayingAnimation = true

    if not self.animations[animationID] then
        self:setAnimationFromID(animationID)
        task.wait()
    end
    local animator = self:GetAnimator()
    local animationTrack = self.animations[animationID]
    local originalSpeed = animationTrack.Length
    print(originalSpeed)
    local newSpeed = originalSpeed / durationInSeconds 
    
    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
		track:Stop(0)
	end
    
    animationTrack:Play(0.1, 1, newSpeed) -- first two are default parameters
    animationTrack.DidLoop:Wait()
    
    animationTrack:Stop()
    self.IsPlayingAnimation = false
    animationTrack:AdjustSpeed(originalSpeed)
    
    animationTrack.TimePosition = 0
    return
end

--[[
    Set's an animation to be loaded later

    animation = ID
]]
function Entity:setAnimationFromID(animationID)
    --local humanoid = self:GetHumanoid()
    local animator = self:GetAnimator()

    local newAnimation = Instance.new("Animation")
    newAnimation.AnimationId = "rbxassetid://" .. animationID
    
    local animationTrack = animator:LoadAnimation(newAnimation)
    animationTrack.Looped = true
    animationTrack.Priority = Enum.AnimationPriority.Action

    self.animations[animationID] = animationTrack
    print("Finished Setting")

end

function Entity:GetHumanoid()
    return self.humanoid
end

function Entity:GetAnimator()
    return self.animator
end

function Entity:GetHumanoidRootPart()
    return self.humanoidRootPart
end

function Entity:GetIsPlayingAnimation()
    return self.IsPlayingAnimation
end



return Entity