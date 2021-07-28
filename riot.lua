coroutine.wrap(function()
    while true do wait(0.45)
        pcall(function()
            local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
            
            if tool and tool:FindFirstChild("WeaponRemote") then
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v and v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") then
                        local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        local p2 = v.Character.HumanoidRootPart.Position
                        
                        if (p1 - p2).magnitude < 13 then
                            tool.WeaponRemote:FireServer("Swing", math.random(1,3))
                            tool.WeaponRemote:FireServer("T", v.Character.Head)
                        end
                    end
                end
            end
        end)
    end
end)()

coroutine.wrap(function()
    game.RunService.Heartbeat:Connect(function()
        game:GetService("ReplicatedStorage").Events.Look:FireServer("akita_cant_program!!", CFrame.new(0/0,0/0,0/0))
    end)
end)()
