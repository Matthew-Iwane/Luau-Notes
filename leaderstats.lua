--[ SERVICES ]--

local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("TimeStats")
local service = game:GetService("MarketplaceService")

--[ LOCALS ]--

local VIPGamepassId = 20063983  -- VIP GAMEPASS ID
local GamepassId = 20063957  -- GAMEPASS ID

--[ FUNCTIONS ]--

game.Players.PlayerAdded:Connect(function(Player)


	--[{ LEADERSTATS }]--

	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	Leaderstats.Parent = Player
	
	local Seconds = Instance.new("IntValue")
	Seconds.Name = "Seconds"
	Seconds.Value = 0
	Seconds.Parent = Player

	local Level = Instance.new("IntValue")
	Level.Name = "Level" 
	Level.Value = 0
	Level.Parent = Leaderstats

	local Points = Instance.new("IntValue")
	Points.Name = "Points"
	Points.Value = 0
	Points.Parent = Player
	
	local Kills = Instance.new("NumberValue")
	Kills.Name = "Kills"
	Kills.Value = 0
	Kills.Parent = Leaderstats
	
	--[{ DATA STORE }]--

	local Data = DataStore:GetAsync(Player.UserId) 

	if type(Data) ~= "table" then
		Data = nil
	end

	if Data then
		Seconds.Value = Data.Seconds
		Level.Value = Data.Level
		Points.Value = Data.Points
		Kills.Value = Data.Kills
	end

	local incrementValue = 5 

	if (service:UserOwnsGamePassAsync(Player.UserId, VIPGamepassId)) then -- 3x gamepass
		incrementValue = 15
	elseif (service:UserOwnsGamePassAsync(Player.UserId, GamepassId)) then -- 2x gamepass
		incrementValue = 10
	end

	--[{ TIME GIVERS }]--

	coroutine.resume(coroutine.create(function(Player) 
		while true do
			wait(1)
			Seconds.Value += 1
			if Seconds.Value == 60 or Seconds.Value >= 120 then
				Level.Value += 1
			end
			if Seconds.Value >= 120 then
				Seconds.Value = 0
				Points.Value = Points.Value + incrementValue
			end
		end
	end))
end)

game.Players.PlayerRemoving:Connect(function(Player) 
	--[{ DATA STORE SAVING }]--
	DataStore:SetAsync(Player.UserId, { 
		Seconds = Player.Seconds.Value,
		Level = Player.leaderstats.Level.Value,
		Points = Player.Points.Value,
		Kills = Player.leaderstats.Kills.Value
	})
end)