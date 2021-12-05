local PlayerEntityData = {}

--[[

    Container class for player and their respective entity
]]

function PlayerEntityData:AddPlayer(player, entity)
    PlayerEntityData[player] = entity
end

function PlayerEntityData:RemovePlayer(player)
    PlayerEntityData[player] = nil
end

function PlayerEntityData:GetPlayerEntity(player)
    return PlayerEntityData[player]
end

return PlayerEntityData