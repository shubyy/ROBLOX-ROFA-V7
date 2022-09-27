local plr = game.Players.LocalPlayer

local mouse = plr:GetMouse()
local tool = script.Parent
local uis = game:GetService("UserInputService")
repeat wait() until plr.Character
local char = plr.Character
local hr = char:WaitForChild("HumanoidRootPart")
local Humanoid = char:WaitForChild("Humanoid")
local class = game.Players.LocalPlayer:WaitForChild("CurrentClass")
local maxJump



local db = false
local debris = game:GetService("Debris")
local saveanim = tool:WaitForChild("Save")
local savetrack = Humanoid:LoadAnimation(saveanim)


--[[
event.OnClientEvent:Connect(function(arg)
	if arg == 'done' then
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
end)

local function dive(side)
	if db == true or diving.Value == true then return end
	db = true
	event:FireServer(side)
	wait(1)
	db = false
end
]]--


local function dive(side)
	if db == true then return end
	if script.Parent.Parent ~= char then return end
	if Humanoid.Health <= 0 or Humanoid.PlatformStand == true then return end
	if hr:FindFirstChild("BodyVelocity") then return end
	local finished = false --local to this thread so when next thread is called wont intefere
	--with the previous one
	
	--calculate force direction
	local forcecalc, finalcframe
	if side == 'right' then
		local rightvec = hr.CFrame.rightVector
		forcecalc = rightvec * 1300
		finalcframe = hr.CFrame * CFrame.Angles(0, 0, -math.pi/2)
	elseif side == 'left' then
		local rightvec = -hr.CFrame.rightVector
		forcecalc = rightvec * 1300
		finalcframe = hr.CFrame * CFrame.Angles(0, 0, math.pi/2)
	end
	--print("torso lv ", char.Torso.CFrame.lookVector)
	db = true
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
	
	debris:AddItem(bv, 0.5)
	debris:AddItem(bg, 0.6)
	
	wait(0.6)
	
	getting_up = Humanoid.Touched:Connect(function(part)
		if not part.Parent:FindFirstChild("Humanoid") and finished == false then
			getting_up:Disconnect()
			finished = true
			db = true
			hr.Velocity = hr.Velocity * 0.3
			wait(0.2)
			Humanoid.JumpPower = maxJump
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			Humanoid.PlatformStand = false
			savetrack:Stop()
			db = false
		end
	end)
	
	wait(2)
	if Humanoid.PlatformStand == true and finished == false then
		finished = true
		getting_up:Disconnect()
		Humanoid.JumpPower = maxJump
		savetrack:Stop()
		db = false
		Humanoid.PlatformStand = false
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

end

uis.InputBegan:Connect(function(input, gp)
	if gp == true then return end
	if input.KeyCode == Enum.KeyCode.E then
		dive('right')
	elseif input.KeyCode == Enum.KeyCode.Q then
		dive('left')
	end
end)

local function updateclass()	
	local classfolder = game.ReplicatedStorage:WaitForChild("ClassInformation"):WaitForChild(tostring(class.Value))
	local jumpVal = classfolder:WaitForChild("Agility").Value 
	maxJump = (jumpVal)*(16)/(20) + 42
	
end

updateclass()

--[[
mouse.KeyDown:connect(function(keyy)
	local key = string.lower(keyy)
	if key == 'q' then
		dive('left')
	elseif key == 'e' then
		
	end
end)
]]--

if game:GetService("UserInputService").TouchEnabled then --and game:GetService("UserInputService").KeyboardEnabled == false then
	uis.TouchStarted:Connect(function(touch, gpe)
		if gpe then return end
		local x = touch.Position.X
		local midway = workspace.CurrentCamera.ViewportSize.X / 2
		if x < midway then
			dive('left')
		else
			dive('right')
		end
	end)
else
	mouse.Button1Down:Connect(function()
		dive('left')
	end)
	
	mouse.Button2Down:Connect(function()
		dive('right')
	end)
end