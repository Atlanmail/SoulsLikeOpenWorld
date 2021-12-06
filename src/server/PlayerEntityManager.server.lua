--[[ Creates a new entity for the character every time it is loaded and deletes the old ones 
when the character is removed]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local PlayerEntityData = require(ServerStorage.Common.Data.PlayerEntityData)
local Entity = require(ReplicatedStorage.Common.EntityClass.Entity)
local PlayerEntity = require(ReplicatedStorage.Common.EntityClass.PlayerEntity)

local MovementActionsPath = ReplicatedStorage.Common.Actions.MovementActions



local function onCharacterAdded(character)
    local player = Players:GetPlayerFromCharacter(character)
    local entity = PlayerEntity.new(player)
    entity:LoadActions(MovementActionsPath)
    PlayerEntityData:AddPlayer(player, entity)
end

local function onCharacterRemoving(character)
    PlayerEntityData:RemovePlayer(Players:GetPlayerFromCharacter(character))
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(onCharacterAdded)
    player.CharacterRemoving:Connect(onCharacterRemoving)
end

local function onPlayerRemoving(player)
    player.CharacterAdded:Disconnect()
    player.CharacterRemoving:Disconnect()
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)