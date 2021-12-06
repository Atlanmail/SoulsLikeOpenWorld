local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")

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
    --[[newEntity.humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
    newEntity.humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)]]--

    setmetatable(newEntity, Entity)

    return newEntity
end

--[[
    LoadActions from a library of actions
]]

function Entity:LoadActions(path)
    local ActionsToLoad = require(path) -- gets the methods in the path
    local methodsToAddTo = getmetatable(self)
    
    for i, v in pairs(ActionsToLoad) do
        if methodsToAddTo[i] == nil then
            methodsToAddTo[i] = v
        elseif  i == "__index" then
            continue
        else
            print("overlap " .. i)
            return
        end
    end
    ActionsToLoad = getmetatable(require(path))
    
    for i, v in pairs(ActionsToLoad) do -- gets the methods of the metatable of path
        if methodsToAddTo[i] == nil then
            methodsToAddTo[i] = v
        elseif  i == "__index" then
            continue
        else
            print("overlap " .. i)
            return
        end
    end

    setmetatable(self, methodsToAddTo)

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