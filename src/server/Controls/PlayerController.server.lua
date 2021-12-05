local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local PlayerEntityData = require(ServerStorage.Common.Data.PlayerEntityData)
local Entity = require(ReplicatedStorage.Common.EntityClass.Entity)


local playerInput = ReplicatedStorage:WaitForChild("RemoteEvents").Controls.playerInput
--- runs functions on player input
local function onPlayerInput(player, inputState, inputObject)
    local entity = PlayerEntityData:GetPlayerEntity(player)
    print(entity:GetAnimator())
end

playerInput.OnServerEvent:Connect(onPlayerInput)