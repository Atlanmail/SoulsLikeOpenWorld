local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local PlayerEntityData = require(ServerStorage.Common.Data.PlayerEntityData)
local Entity = require(ReplicatedStorage.Common.EntityClass.Entity)
local PlayerEntity = require(ReplicatedStorage.Common.EntityClass.PlayerEntity)

local playerInput = ReplicatedStorage:WaitForChild("RemoteEvents").Controls.playerInput
--- runs functions on player input
local function onPlayerInput(player, inputState, inputObject)
    local entity = PlayerEntityData:GetPlayerEntity(player)
    if inputObject == "Enum.UserInputType.MouseButton2" and inputState == "Enum.UserInputState.Begin" then
        entity:StopPlayerMovementInput()
        entity:RollForwards()
        entity:StartPlayerMovementInput()
        
    end
end

playerInput.OnServerEvent:Connect(onPlayerInput)