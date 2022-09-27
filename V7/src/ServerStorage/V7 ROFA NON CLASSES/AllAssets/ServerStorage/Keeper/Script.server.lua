local tool = script.Parent
local event = tool:WaitForChild("RemoteEvent")
local db = false
local debris = game:GetService("Debris")
local saveanim = tool:WaitForChild("Save")
local tweenservice = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)

--[[
local function dive(player, side)
	if player and player.Character then
		local char = player.Character
		local Humanoid = char:WaitForChild("Humanoid")
		local hr = char:WaitForChild("HumanoidRootPart")
		local diving = char:WaitForChild("Diving")

		if script.Parent.Parent ~= char then return end
		if Humanoid.Health <= 0 or diving.Value == true then return end
		
		--with the previous one
		diving.Value = true
		--calculate force direction
		local savetrack = Humanoid:LoadAnimation(saveanim)
		local finalcframe
		
		if side == 'right' then
			local dirvec = hr.CFrame.rightVector
			finalcframe = CFrame.new(hr.Position + (dirvec * 35)) * CFrame.Angles(0,0,-math.pi/2)
		elseif side == 'left' then
			local dirvec = -hr.CFrame.rightVector
			finalcframe = CFrame.new(hr.Position + (dirvec * 35)) * CFrame.Angles(0,0,math.pi/2)
		end
		Humanoid.JumpPower = 0
		local tween = tweenservice:Create(hr, tweeninfo, {CFrame = finalcframe})
		tween:Play()
		savetrack:Play()
		wait(0.5)
		event:FireClient(player, 'done')
		Humanoid.JumpPower = 50
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		savetrack:Stop()
		diving.Value = false
	end
end
]]--

--[[
local function dive(player, side)
	if player and player.Character then
		local char = player.Character
		local Humanoid = char:WaitForChild("Humanoid")
		local hr = char:WaitForChild("HumanoidRootPart")
		local diving = char:WaitForChild("Diving")
		print(Humanoid.PlatformStand)
		if db == true then return end
		if script.Parent.Parent ~= char then return end
		print("passed2")
		if Humanoid.Health <= 0 and diving.Value == true then return end
		print("passed3")
		if hr:FindFirstChild("BodyGyro") then return end
		print("passed4")
		
		local finished = false --local to this thread so when next thread is called wont intefere
		--with the previous one
		diving.Value = true
		--calculate force direction
		local savetrack = Humanoid:LoadAnimation(saveanim)
		local forcecalc, finalcframe
		
		if side == 'right' then
			local rightvec = hr.CFrame.rightVector
			print(rightvec)
			forcecalc = rightvec * 1300
			finalcframe = hr.CFrame * CFrame.Angles(0, 0, -math.pi/2)
		elseif side == 'left' then
			local rightvec = -hr.CFrame.rightVector
			print(rightvec)
			forcecalc = rightvec * 1300
			finalcframe = hr.CFrame * CFrame.Angles(0, 0, math.pi/2)
		end
	
	
	--print("torso lv ", char.Torso.CFrame.lookVector)
		
		Humanoid.PlatformStand = true
		Humanoid.JumpPower = 0
		local bv = Instance.new("BodyForce")
		bv.Parent = hr
		bv.Force = forcecalc
		
		local bg = Instance.new("BodyGyro")
		bg.Parent = hr
		bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bg.CFrame = finalcframe
		bg.P = 10000
		savetrack:Play()
		
		debris:AddItem(bv, 0.4)
		debris:AddItem(bg, 0.7)
		
		wait(0.5)
		
		getting_up = Humanoid.Touched:Connect(function(part)
			if not part.Parent:FindFirstChild("Humanoid") and finished == false then
				getting_up:Disconnect()
				finished = true
				hr.Velocity = hr.Velocity * 0.4
				event:FireClient(player, 'done')
				Humanoid.PlatformStand = false
				wait(0.2)
				Humanoid.JumpPower = 50
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				savetrack:Stop()
				db = false
			end
		end)
		
		wait(1)
		if Humanoid.PlatformStand == true and finished == false then
			finished = true
			Humanoid.PlatformStand = false
			getting_up:Disconnect()
			Humanoid.JumpPower = 50
			savetrack:Stop()
			db = false
			event:FireClient(player, 'done')
			--Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
		diving.Value = false
	end
end


event.OnServerEvent:Connect(function(...)
	local tuple = {...}
	local player = tuple[1]
	local side = tuple[2]
	dive(player, side)
end)
]]--