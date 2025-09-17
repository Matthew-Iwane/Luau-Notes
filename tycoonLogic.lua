-- On player JOIN
game.Players.PlayerAdded:Connect(function(player)
        local Buttons = TemplatePlot.Buttons:Clone()
        local Items = TemplatePlot.Items
        -- set Buttons folder as the plot's child
        Buttons.Parent = plot
        
        for _, button in Buttons:GetChildren() do
            -- Calculates the relative position of the button to the plot's CFrame
            local RelativeButtonPos = TemplatePlot.CFrame:ToObjectSpace(button.CFrame)
            -- set button position relatively to the center of the plot
            button.CFrame = plot.CFrame:ToWorldSpace(RelativeButtonPos)
            
            button.Touched:Connect(function(hit)
                local player = Players:GetPlayerFromCharacter(hit.Parent)
                
                if not player then return end
                
                local ItemsFolder = Instance.new("Folder")
                ItemsFolder.Name = "Items"
                ItemsFolder.Parent = plot
                
                -- check if player owns the plot
                if player.UserId ~= plot:GetAttribute("Owner") then return end
                                
                local buttonId = button:GetAttribute("ItemToUnlockId")
               
                for _, item in Items:GetChildren() do
                    if item:GetAttribute("Id") ~= buttonId then continue end

                    local TemplateItemPos
                    local cloneItem = item:Clone()

                    if item:IsA("BasePart") then
                        TemplateItemPos = cloneItem.CFrame
                    end
                    
                    if item:IsA("Model") then
                        TemplateItemPos = cloneItem.GetPivot()
                    end
                    
                    
                    local TemplateItemRelativePos = TemplatePlot.CFrame:ToObjectSpace(TemplateItemPos)

                    cloneItem.CFrame = plot.CFrame:ToWorldSpace(TemplateItemRelativePos)
                    cloneItem.Parent = ItemsFolder
                    
                    button:Destroy()
                end
            end)
        end
        break
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    
    -- Remove plot ownership on player leave
    for index, plot in Plots:GetChildren() do
        if plot:GetAttribute("Owner") == player.UserId then
            plot:SetAttribute("Taken", false)
            plot:SetAttribute("Owner", nil)
            
            for _, plotItems in plot:GetChildren() do
                plotItems:Destroy()
            end
            
            break
        end
    end
end)