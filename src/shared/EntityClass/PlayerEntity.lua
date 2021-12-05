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

return PlayerEntity
