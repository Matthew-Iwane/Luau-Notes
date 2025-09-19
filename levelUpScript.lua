











game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
	
		local plots = game.Workspace:WaitForChild("Plots")
		local playerId = player.UserId
		
		for _, p in plots:GetChildren() do

			if p:GetAttribute("Owner") == playerId then
				-- If player doesn't have any beds yet, skip
				
				local itemsFolder = p:WaitForChild("Items")
				local MAX_BED_LEVEL = 3
				
				
				itemsFolder.ChildAdded:Connect(function(child: Instance) 
					
					for _, b in itemsFolder:GetChildren() do
						
						if b.Name == "Bed" and b:IsA("Model") then
							
							local bedLevel = b:GetAttribute("BedLevel")
							
							if bedLevel == MAX_BED_LEVEL then
								break
							end
							
							local bedPos = b:GetPivot()
							
							
							local upgradeBedButton = Instance.new("Part")
							upgradeBedButton.Parent = workspace
							upgradeBedButton.CFrame = bedPos + Vector3.new(10, 0, 0)
					
							
							break
							
						end 
					end
				end)
			end
		end
	end)
end)