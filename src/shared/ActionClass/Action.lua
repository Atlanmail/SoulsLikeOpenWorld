local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")
local RunService = game:GetService("RunService")

local Action = {}
Action.__index = Action


--[[ Gets an animation length bc Roblox's built in animation length sucks\
Animation
]]
local AnimationLengthCache = {}
local function GetAnimationLength(AnimationId)
	if AnimationLengthCache[AnimationId] then
		return AnimationLengthCache[AnimationId]
	end
    local keyframes = {}
    local length = 0
    local keyframeTable
	local success = pcall(function()
        keyframes = KeyframeSequenceProvider:GetKeyframeSequenceAsync("rbxassetid://" .. AnimationId)
    end)
    if success then
        keyframeTable = keyframes:GetKeyframes() 
    else
        error("Failed to receive keyframes", 2)
    end

    for i, v in pairs(keyframeTable) do
        if v.Time > length then 
			length = v.Time 
		end
    end
    
	AnimationLengthCache[AnimationId] = length
	
	return length
end
--[[

    Plays an animation on a character while offsetting it in a certain direction
    entity for a certain time
    Check if 
    @param 
    animation = ID
    durationInTicks = durationInTicks
    Animation needs to be set first
]]


function Action:PlayAnimation( animationID, durationInSeconds) 
    
    print("Animation Started")

    if not self.animations[animationID] then
        self:setAnimationFromID(animationID)
        task.wait()
    end
    local animator = self:GetAnimator()

    for i, v in pairs(animator:GetPlayingAnimationTracks()) do
        v:Stop()
    end

    local animationTrack = self.animations[animationID]
    
    animationTrack.Priority = Enum.AnimationPriority.Action

    local originalSpeed = GetAnimationLength(animationID)
    print(originalSpeed)
    local newSpeed = originalSpeed / durationInSeconds 
    
    animationTrack:Play(0.1, 1, newSpeed) -- first two are default parameters
    animationTrack.DidLoop:Wait()
    
    animationTrack:Stop()
    
    animationTrack.TimePosition = 0
    return
end

--[[
    Set's an animation to be loaded later

    animation = ID
]]
function Action:setAnimationFromID(animationID)
    --local humanoid = self:GetHumanoid()
    local animator = self:GetAnimator()

    local newAnimation = Instance.new("Animation")
    newAnimation.AnimationId = "rbxassetid://" .. animationID
    local catcher = GetAnimationLength(animationID)
    local animationTrack = animator:LoadAnimation(newAnimation)
    animationTrack.Looped = true
    animationTrack.Priority = Enum.AnimationPriority.Action

    self.animations[animationID] = animationTrack
    print("Finished Setting")

end

function Action:StopPlayerAnimations()
    
end

function Action:StartPlayerAnimations()
    
end

function Action:CreateAttachment(name)
    
    if self.attachments == nil then
        self.attachments = {}
    end
    
    if self.attachments[name] ~= nil then
        return self.attachments[name]
    end
    
    local newAttachment = Instance.new("Attachment")
    newAttachment.Name = name
    self.attachments[name] = newAttachment

    return newAttachment
end

function Action:createBodyVelocity(name)
    
    if self.bodyVelocites == nil then
        self.bodyVelocities = {}
    end
    
    if self.bodyVelocities[name] ~= nil then
        return self.bodyVelocities[name]
    end
    
    local newBodyVelocity = Instance.new("BodyVelocity")
    newBodyVelocity.Name = name
    self.bodyVelocities[name] = newBodyVelocity

    return newBodyVelocity
end

function Action:createLinearVelocity(name)
    print("creating " .. name)
    if self.linearVelocities == nil then
        print("created empty table")
        self.linearVelocities = {}
    end
    
    if self.linearVelocities[name] ~= nil then
        print("returned existing")
        return self.linearVelocities[name]
    end
    
    print("creating new linear")
    local newlinearVelocity = Instance.new("LinearVelocity")
    newlinearVelocity.Name = name
    self.linearVelocities[name] = newlinearVelocity

    return newlinearVelocity
end
--[[ creates a part for debugging purposes]]
local function createPart(CFrame)
    local newPart = Instance.new("Part")
    newPart.CFrame = CFrame
    newPart.Size = Vector3.new(0.5,0.5,0.5)
    newPart.CanCollide = false
    newPart.Anchored = true
    newPart.Parent = workspace
end

--[[
    move the character a specified distance over a specific frames
    displacement = vector3
    time = seconds
]]

--[[
function Action:DisplaceModel(displacement, time)
    print("Displacing")
    local humanoidRootPart = self:GetHumanoidRootPart()
    local HumanoidRootPartAttachment = self:CreateAttachment("HumanoidRootPartAttachment")
    local DisplacementAttachment = self:CreateAttachment("DisplacementAttachment")
    local newAlignPosition = Instance.new("AlignPosition")
    print(self:createLinearVelocity("antigravityVelocity"))
    local antigravityVelocity = self:createLinearVelocity("antigravityVelocity")

    print("antigravity velocity")
    antigravityVelocity.MaxForce = math.huge
    antigravityVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Line
    antigravityVelocity.LineDirection = Vector3.new(0,1,0)
    antigravityVelocity.RelativeTo =Enum.ActuatorRelativeTo.World
    antigravityVelocity.LineVelocity = 0
    antigravityVelocity.Attachment0 = HumanoidRootPartAttachment

    HumanoidRootPartAttachment.Parent = humanoidRootPart
    DisplacementAttachment.Parent = workspace.Baseplate

    DisplacementAttachment.CFrame = HumanoidRootPartAttachment.WorldCFrame:ToWorldSpace(CFrame.new(displacement))

    createPart(humanoidRootPart.CFrame) --- dummy cframe
    createPart(DisplacementAttachment.CFrame)

    newAlignPosition.ApplyAtCenterOfMass = true
    newAlignPosition.RigidityEnabled = false
    newAlignPosition.Responsiveness = 20
    newAlignPosition.MaxForce = math.huge
    newAlignPosition.MaxVelocity = displacement.Magnitude / time
    newAlignPosition.Attachment0 = HumanoidRootPartAttachment
    newAlignPosition.Attachment1 = DisplacementAttachment
    newAlignPosition.Enabled = true

    antigravityVelocity.Parent = humanoidRootPart
    newAlignPosition.Parent = humanoidRootPart


    task.wait(time)

    antigravityVelocity.Parent = nil
    newAlignPosition:Destroy()
    return
end
]]--



function Action:DisplaceModel(displacement, time)
    local humanoidRootPart = self:GetHumanoidRootPart()
    local HumanoidRootPartAttachment = self:CreateAttachment("HumanoidRootPartAttachment")
    local newlinearVelocity = self:createLinearVelocity("displacementVelocity")
    local humanoid = self:GetHumanoid()

    newlinearVelocity.MaxForce = math.huge
    newlinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
    newlinearVelocity.VelocityConstraintMode =Enum.VelocityConstraintMode.Vector
    newlinearVelocity.VectorVelocity = displacement / time
    newlinearVelocity.Attachment0 = HumanoidRootPartAttachment


    humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)

    HumanoidRootPartAttachment.Parent = humanoidRootPart
    newlinearVelocity.Parent = humanoidRootPart

    task.wait(time)

    humanoid:ChangeState(Enum.HumanoidStateType.Running)
    newlinearVelocity.Parent = nil

end




return Action