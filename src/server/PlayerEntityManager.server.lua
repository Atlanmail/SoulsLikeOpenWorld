local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local PlayerEntityData = require(ServerStorage.Common.Data.PlayerEntityData)
local Entity = require(ReplicatedStorage.Common.EntityClass.Entity)

local function onCharacterAdded(character)
    local entity = Entity.new(character)
    PlayerEntityData:AddPlayer(Players:GetPlayerFromCharacter(character), entity)
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