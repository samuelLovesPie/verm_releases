local library = loadstring(game:HttpGet'https://raw.githubusercontent.com/wally-rblx/uwuware-ui/main/main.lua')()

local window = library:CreateWindow'soul shatters'
local tab1 = window:AddFolder'stuff'

local rs = game:service'ReplicatedStorage';
local plrs = game:service'Players';
local rsrv = game:service'RunService'

local sounds = rs:WaitForChild'Sounds'
local animations = rs:WaitForChild'Animations'
local remotes = rs:WaitForChild'Remotes'

local security = getrenv()._G.Pass
local punchsound = sounds.Punch
local hurtanimation2 = animations.HurtAnimations['Hurt' .. math.random(1, 3)]

spawn(function()
    while true do wait()
        pcall(function()
            if library.flags.killaura then
                for i,v in pairs(plrs:GetPlayers()) do
                    local target = v.Character
                    
                    if v ~= plrs.LocalPlayer and plrs.LocalPlayer.Character and plrs.LocalPlayer.Character:FindFirstChild'HumanoidRootPart' and target and target:FindFirstChild('HumanoidRootPart') then
                        local myroot = plrs.LocalPlayer.Character.HumanoidRootPart.Position
                        local enemyroot = target.HumanoidRootPart.Position
                        
                        if (myroot - enemyroot).magnitude <= 15 then
                            local ohTable3 = {["HitEffect"] = "BoneHitEffect", ["Type"] = "Knockback", ["HitTime"] = 0.7, ["Velocity"] = target.HumanoidRootPart.CFrame.lookVector * 5, ["HurtAnimation"] = hurtanimation2, ["VictimCFrame"] = target.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(180), 0) +  plrs.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 6, ["Sound"] = punchsound, ["Damage"] = 0/0}
                            
                            remotes.Damage:InvokeServer(security, target, ohTable3)
                        end
                    end
                end
            end
        end)
    end
end)

spawn(function()
    rsrv.Heartbeat:Connect(function()
        if library.flags.teleportbehind then
            for i,v in pairs(plrs:GetPlayers()) do
                local target = v.Character
                    
                if v ~= plrs.LocalPlayer and plrs.LocalPlayer.Character and plrs.LocalPlayer.Character:FindFirstChild'HumanoidRootPart' and target and target:FindFirstChild('HumanoidRootPart') and target:FindFirstChild('Humanoid') and target.Humanoid.Health > 0 then
                    local myroot = plrs.LocalPlayer.Character.HumanoidRootPart.Position
                    local enemyroot = target.HumanoidRootPart.Position
                        
                    if (myroot - enemyroot).magnitude <= 15 then
                        plrs.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0,math.random(1,9),5)
                    end
                end
            end
        end
        
        if library.flags.stayblocking then
            remotes.Functions:InvokeServer({[1]=security,[2]='Blocking',[3]=true})
            remotes.SansBadTimeMoves:InvokeServer({[1]=security,[2]='Blocking',[3]=true})
        end
        
        if library.flags.nojumpcooldown and game:service'UserInputService':IsKeyDown(Enum.KeyCode.Space) then
            if plrs.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Landed then
                plrs.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
        
        if library.flags.walkspeed and plrs.LocalPlayer.Character and plrs.LocalPlayer.Character:FindFirstChild'Humanoid' then
            plrs.LocalPlayer.Character.Humanoid.WalkSpeed = library.flags.speedval
        end
    end)
end)

tab1:AddToggle({ text = 'killaura', flag = 'killaura' })
tab1:AddToggle({ text = 'walkspeed', flag = 'walkspeed' })
tab1:AddSlider({ text = 'speed value', flag = 'speedval', min = 1, max = 200, value = 1 })

tab1:AddDivider()
tab1:AddToggle({text = 'stay blocking', flag = 'stayblocking'})
tab1:AddToggle({ text = 'infinite sprint', flag = 'infsprint' })
tab1:AddToggle({ text = 'teleport behind', flag = 'teleportbehind' })

tab1:AddDivider()
tab1:AddToggle({ text = 'no jump cooldown', flag = 'nojumpcooldown' })

library:Init()

spawn(function()
    local oldidx
    local oldnc

    oldidx = hookmetamethod(game, '__index', function(epic, epic2)
        if (tostring(epic) == 'Humanoid' and tostring(epic2) == 'WalkSpeed' and library.flags.walkspeed) then
            return 10;
        end
        return oldidx(epic, epic2)
    end)

    oldnc = hookmetamethod(game, '__namecall', function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == 'InvokeServer' and self.Name == 'Functions' and tostring(args[1][2]) == 'Running' and library.flags.infsprint then
            return wait(9e9)
        end
        return oldnc(self, unpack(args))
    end)
end)
