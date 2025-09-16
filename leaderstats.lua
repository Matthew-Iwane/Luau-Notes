game.Players.PlayersAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local cash = Instance.new("IntValue")
    cash.Name = "Cash"
    cash.Value = 0
    cash.Parent = leaderstats
end)

-- "leaderstats" needs to be in lowercase for Roblox to recognize it as a leaderboard
-- Each player will have a "Cash" stat initialized to 0