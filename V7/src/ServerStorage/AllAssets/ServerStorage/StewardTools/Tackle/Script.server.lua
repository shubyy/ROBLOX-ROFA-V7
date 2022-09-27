local tool = script.Parent
local event = tool:WaitForChild("RemoteEvent")
local tackle = tool:WaitForChild("TackleAnim")
local carry = tool:WaitForChild("CarryAnim")
local track = nil
local held

event.OnServerEvent:Connect(function(...)
	local tuple = {...}
	local plr = tuple[1]
	local req = tuple[2]
	local targetplr = tuple[3]
	
	if req == "Grab" then
		--Grab player
		if not held then
			if targetplr and targetplr.Character and targetplr.Character:FindFirstChild("HumanoidRootPart") then
				--Stage one
				held = true
				targetplr.Character.Humanoid.PlatformStand = true
			 	track = plr.Character.Humanoid:LoadAnimation(tackle)
				track:Play()
				wait(.1)
				local weld = Instance.new("ManualWeld")
				weld.Part0 = plr.Character:FindFirstChild("Head")
				weld.Part1 = targetplr.Character:FindFirstChild("HumanoidRootPart")
				weld.C0 = CFrame.new(0,0,-1)
				weld.Name = "TackleWeld"
				weld.Parent = plr.Character.Head
				wait(2.9)
				
				if targetplr and targetplr.Character and targetplr.Character:FindFirstChild("HumanoidRootPart") and tackle then
					--stage 2
					track = plr.Character.Humanoid:LoadAnimation(carry)
					track:Play()
					weld:Destroy()
					
					weld = Instance.new("ManualWeld")
					weld.Part0 = plr.Character:FindFirstChild("HumanoidRootPart")
					weld.Part1 = targetplr.Character:FindFirstChild("HumanoidRootPart")
					weld.C0 = CFrame.new(1,0,-2)
					weld.Name = "TackleWeld"
					weld.Parent = plr.Character.HumanoidRootPart
					
				else
					held = false
				end
			end
			
		else
			if plr.Character.Head:FindFirstChild("TackleWeld") then
				plr.Character.Head.TackleWeld:Destroy()
			elseif  plr.Character.HumanoidRootPart:FindFirstChild("TackleWeld") then
				plr.Character.HumanoidRootPart.TackleWeld:Destroy()
			end
			if targetplr and targetplr.Character and targetplr.Character:FindFirstChild("Humanoid") then
				targetplr.Character.Humanoid.PlatformStand = false
			end
			if track then
				track:Stop()
				track = nil
			end
			held = false
		end
	end
end)
