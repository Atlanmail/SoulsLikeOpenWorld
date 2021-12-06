--[[ playerEntity extends Entity]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Entity = require(ReplicatedStorage.Common.EntityClass.Entity)

local PlayerEntity = {}
PlayerEntity.__index = PlayerEntity
setmetatable(PlayerEntity, Entity)

function PlayerEntity.new(player)
    local newPlayerEntity = Entity.new(player.Character)
    newPlayerEntity.player = player

    setmetatable(newPlayerEntity, PlayerEntity)
    return newPlayerEntity
end

function PlayerEntity:GetPlayer()
    return self.player
end

function PlayerEntity:StopPlayerMovementInput()
    self.player.DevComputerMovementMode = Enum.DevComputerMovementMode.Scriptable
end

function PlayerEntity:StartPlayerMovementInput()
    self.player.DevComputerMovementMode = Enum.DevComputerMovementMode.UserChoice
end


return PlayerEntity
