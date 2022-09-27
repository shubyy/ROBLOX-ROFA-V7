local handle = script.Parent
local debounce = false
local debounce2 = false
local lastshot = handle:WaitForChild("LastShot")
local debris = game:GetService("Debris")
local playeronball = handle:WaitForChild("PlayerOnBall")
local skillController = handle:WaitForChild("SkillController")
local RunService = game:GetService("RunService")
local timer = math.huge

local function billWithImage(par)
	local billBoard = Instance.new("BillboardGui",par)
	billBoard.Size = UDim2.new(20,0,20,0)
	billBoard.Adornee = par
	local ImageL = Instance.new("ImageLabel",billBoard)
	ImageL.Image = "rbxassetid://913389092"
	ImageL.Size = UDim2.new(0.1,0,0.1,0)
	ImageL.Position = UDim2.new(0.45,0,0.3,0)
	local plr = game.Players:GetPlayerFromCharacter(par.Parent)
	ImageL.ImageColor3 = plr.TeamColor.Color or Color3.new(255,255,255)
	ImageL.BackgroundTransparency = 1
end

local function weldTo(char)
	local torso = char:WaitForChild("Torso")
	local y = 2
	y = (torso.Size.Y / 2 + char:WaitForChild("Right Leg").Size.Y) - 1.0
	local grip = CFrame.new(0,y,1.6)
	local weld = Instance.new("ManualWeld")
	
    weld.Part0 = torso
    weld.Part1 = handle
    --Get the CFrame of b relative to a.
--    weld.C0 = a.CFrame:inverse() * b.CFrame
	weld.C1 = grip
    --Return the reference to the weld so that you can change it later.
	weld.Name = "BallWeld"
	weld.Parent = torso
	
	billWithImage(char.Head)
end


handle.Touched:connect(function(part)
	--First simple set of checks
	if debounce2 == false and not debounce and part.Parent:FindFirstChild("Humanoid")  then
		-- Check if passes the more advanced set of checks
		local character = part.Parent
		local player = game.Players:GetPlayerFromCharacter(character)
		if not character:WaitForChild("Torso"):FindFirstChild("BallWeld") and character:WaitForChild("Header").Value == false and script.Disabled == false then
			local classfolder = game.ReplicatedStorage:WaitForChild("ClassInformation"):WaitForChild(tostring(player:WaitForChild("CurrentClass").Value ))
			local tackleval = classfolder:WaitForChild("Tackle").Value
			local tackletimer = (tackleval)*(-0.50/20) + 0.75
			if timer < tackletimer then
				return
			end
			
			if skillController.Value == player then
				return
			else
				skillController.Value = nil
			end
			
			debounce = true
			if playeronball.Value ~= nil then
				local player = playeronball.Value
				local torso = player.Character:WaitForChild("Torso")
				if torso:FindFirstChild("BallWeld") then
					torso.BallWeld:Destroy()
				end
			end
			
			
			if c then
				c:Disconnect()
			end
			
			local player = game.Players:GetPlayerFromCharacter(character)
			handle:FindFirstChild("PlayerOnBall").Value = player
			
			weldTo(character)
			--Physical setup
			local curve = handle:FindFirstChild("Curve")
			if curve then
				curve:Destroy()
			end
			
			handle:WaitForChild("Trail").Color = ColorSequence.new(player.TeamColor.Color)
			handle:SetNetworkOwner(player)
			timer = 0
			debounce = false
			c = RunService.Heartbeat:Connect(function(step)
				timer = timer + step
			end)
			
			debounce = false
		end
	elseif part.Name == "hitspace" then
		local obj = part:FindFirstChild("HeadPlayer")
		if obj and obj.Value and obj.Value.Character and handle.PlayerOnBall.Value == nil and debounce2 == false and not debounce then
			debounce2 = true
			obj.Value.Character.Header.HeaderEvent:Fire(handle)
			wait(1)
			debounce2 = false
		end
	end
end)
	
	

	
	
	
	
	
	
	
	

