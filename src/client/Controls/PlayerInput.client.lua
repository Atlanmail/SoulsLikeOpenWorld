local ContextActionService = game:GetService("ContextActionService")
local MouseService = game:GetService("MouseService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


local localPlayer = Players.LocalPlayer

local playerInput = ReplicatedStorage:WaitForChild("RemoteEvents").Controls.playerInput

local CONTROL_KEYS = {
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseButton3
}

local function onControlkeyChanged(actionName, inputState, inputObject)
    local inputObjectType

    if inputObject.KeyCode ~= Enum.KeyCode.Unknown then
        inputObjectType = inputObject.KeyCode
    else
        inputObjectType = inputObject.UserInputType
    end

    playerInput:FireServer(tostring(inputState), tostring(inputObjectType))
end

ContextActionService:BindAction("onControlkeyChanged", onControlkeyChanged, false, unpack(CONTROL_KEYS))