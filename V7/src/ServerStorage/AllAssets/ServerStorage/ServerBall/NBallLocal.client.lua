--[[
	New ServerBall script remade by IcedVapour 1/11/2018
--]]

local Tool = script.Parent
local enabled = true
local human = nil 
local shooting = false
local headDebounce = false
local kick = nil
local hstand = nil
local hjump = nil
local userInput = game:GetService("UserInputService")
script.Parent:WaitForChild("NBallServer")
local player = game.Players.LocalPlayer
repeat wait() until player.Character
local character = player.Character
local driven_shot = false
local holdMax = 3
local edown = false
local rdown = false
local torso = character:WaitForChild("Torso")
local shotcancelled = false

--Generate a -1 or a 1
local function CustomRand()
	return math.ceil(math.random() + 0.5 ) * 2 - 3
end

--[[
--make sure its a unit vector
local function addInAccuracy(vector, accuracyMult)
	--Multiplied by 100 to increase the range of decimals we get
	local charVel = (torso.Velocity.Magnitude) * 10
	
	local xdelta = CustomRand()
	local ydelta = CustomRand()
	local zdelta = CustomRand()
	
	if charVel >= 280 then
		xdelta = xdelta * math.random(charVel/1.3, charVel) / (3000 * accuracyMult)
		ydelta = ydelta * math.random(charVel/1.3, charVel) / (3000 * accuracyMult)
		zdelta = zdelta * math.random(charVel/1.3, charVel) / (3000 * accuracyMult)
	elseif charVel >= 40 then
		xdelta = xdelta * math.random(charVel/1.15, charVel) / (3000 * accuracyMult)
		ydelta = ydelta * math.random(charVel/1.15, charVel) / (3000 * accuracyMult)
		zdelta = zdelta * math.random(charVel/1.15, charVel) / (3000 * accuracyMult)
	else
		xdelta = xdelta * math.random(0, 4) / (3000 * accuracyMult)
		ydelta = ydelta * math.random(0, 4) / (3000 * accuracyMult)
		zdelta = zdelta * math.random(0, 4) / (3000 * accuracyMult)
	end
	
	return Vector3.new(vector.x + xdelta, vector.y + ydelta, vector.z + zdelta).unit
end
]]--

local function crossproduct(vec1, vec2)
	local newvec = Vector3.new(vec1.Y*vec2.Z-vec1.Z*vec2.Y , vec1.Z*vec2.X-vec1.X*vec2.Z , vec1.X*vec2.Y-vec1.Y*vec2.X)
	return newvec
end

function driven(power)
	local UDVector = mouse.UnitRay.Direction
	local torsodir = character.Torso.CFrame.LookVector
	local compvec = Vector3.new(UDVector.X, torsodir.Y, UDVector.Z)
	local forcedir = nil
	
	local frac = (torsodir:Dot(compvec) / (compvec.Magnitude * torsodir.Magnitude))
	local angle = math.deg(math.acos(frac))
	if angle > 3 then
		local vec1 = crossproduct(torsodir,compvec)
		local increase = 0.5 + (0.5 * (1-frac))
		if vec1.Y > 0 then
			forcedir = -CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		else
			forcedir = CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		end
	end
	
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	
	kick:Play()
	--local newVec = addInAccuracy(UDVector, 1)
	
	if torso:FindFirstChild("BallWeld") then
		local rLeg = character:FindFirstChild("Right Leg")
		script.Parent.NBallServer.BridgeEvent:FireServer('DrivenShot',UDVector,rLeg.Position,power,character,forcedir)
	end
	
	wait(0.1)
	enabled = true
	driven_shot = false
	
end

function onMouse1ButtonDown(mouse)
	--power calculation
	if held2 then
		driven_shot = true
		return
	end
	if held1 or held2 or held3 or header_down or not enabled then return end
	local power = 0
	held1 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1, true)
	while held1 and not shotcancelled do
		if power < 3 then
			power = power + .3
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/3)
		wait(.1)
	end
	
	--shoot
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	held1 = false
	
	if shotcancelled then
		driven_shot = false
		shotcancelled = false
		return
	end
	
	enabled = false
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	if driven_shot == true then
		driven(power)
		return
	end
	
	local UDVector = mouse.UnitRay.Direction
	local torsodir = character.Torso.CFrame.LookVector
	local compvec = Vector3.new(UDVector.X, torsodir.Y, UDVector.Z)
	local forcedir = nil
	
	local frac = (torsodir:Dot(compvec) / (compvec.Magnitude * torsodir.Magnitude))
	local angle = math.deg(math.acos(frac))
	if angle > 3 then
		local vec1 = crossproduct(torsodir,compvec)
		local increase = 0.5 + (0.5 * (1-frac))
		if vec1.Y > 0 then
			forcedir = -CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		else
			forcedir = CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		end
	end
	
	
	kick:Play()
	--local newVec = addInAccuracy(UDVector, 1.3)
	if torso:FindFirstChild("BallWeld") then
		local rLeg = character:FindFirstChild("Right Leg")
		script.Parent.NBallServer.BridgeEvent:FireServer('LClick',UDVector,rLeg.Position,power,character,forcedir)
	end
	
	wait(0.1)
	enabled = true
	driven_shot = false
end

function onMouse2ButtonDown(mouse)
	if held1 then
		driven_shot = true
		return
	end
	if held1 or held2 or held3 or header_down or not enabled then return end
	--power calculation
	local power = 0
	held2 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1, true)
	while held2 and not shotcancelled do
		if power < 3 then
			power = power + .3
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/3)
		wait(.1)
	end
	
	--shoot
	
	held2 = false
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	
	if shotcancelled then
		driven_shot = false
		shotcancelled = false
		return
	end
	
	enabled = false
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	if driven_shot == true then
		driven(power)
		return
	end
	
	local UDVector = mouse.UnitRay.Direction
	local torsodir = character.Torso.CFrame.LookVector
	local compvec = Vector3.new(UDVector.X, torsodir.Y, UDVector.Z)
	local forcedir = nil
	
	local frac = (torsodir:Dot(compvec) / (compvec.Magnitude * torsodir.Magnitude))
	local angle = math.deg(math.acos(frac))
	if angle > 3 then
		local vec1 = crossproduct(torsodir,compvec)
		local increase = 0.5 + (0.5 * (1-frac))
		if vec1.Y > 0 then
			forcedir = -CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		else
			forcedir = CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		end
	end
	
	
	kick:Play()
	--local newVec = addInAccuracy(UDVector, 0.85)
	if torso:FindFirstChild("BallWeld") then
		local rLeg = character:FindFirstChild("Right Leg")
		script.Parent.NBallServer.BridgeEvent:FireServer('RClick',UDVector,rLeg.Position,power,character,forcedir)
	end
	
	wait(0.1)
	enabled = true
	driven_shot = false
end


function onScrollButtonDown(mouse)
	local super_kick_max = 5
	if held1 or held2 or held3 or header_down or not enabled then return end
	--power calculation
	local power = 0
	held3 = true
	character.Humanoid.WalkSpeed = 0
	speed_enforce = character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			character.Humanoid.WalkSpeed = 0
	end)
	charge:Play()
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",5.5, true)
	while held3 do
		if power < 5  then
			power = power + .1
		else
			power = 5
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/5)
		wait(.05)
	end
	--shoot only if power >= 5
	if power < 5 then 
		held3 = false
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
		player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
		return
	end
	
	held3 = false
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	enabled = false
	local UDVector = mouse.UnitRay.Direction
	local torsodir = character.Torso.CFrame.LookVector
	local compvec = Vector3.new(UDVector.X, torsodir.Y, UDVector.Z)
	local forcedir = nil
	
	local frac = (torsodir:Dot(compvec) / (compvec.Magnitude * torsodir.Magnitude))
	local angle = math.deg(math.acos(frac))
	if angle > 3 then
		local vec1 = crossproduct(torsodir,compvec)
		local increase = 0.5 + (0.5 * (1-frac))
		if vec1.Y > 0 then
			forcedir = -CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		else
			forcedir = CFrame.new(workspace.CurrentCamera.CFrame.Position, mouse.Hit.Position).RightVector * increase
		end
	end
	
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	kick:Play()
	
	if torso:FindFirstChild("BallWeld") then
		local rLeg = character:FindFirstChild("Right Leg")
		script.Parent.NBallServer.BridgeEvent:FireServer('MClick',UDVector,rLeg.Position,power,character,forcedir)
	end
	
	wait(0.1)
	enabled = true
end



function onHeaderDown(mouse)
	if held1 or held2 or held3 or header_down or not enabled then return end
	local power = 0
	header_down = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1, true)
	while header_down do
		if power < 3 then
			power = power + .3
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/3)
		wait(.1)
	end
	
	header_down = false
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	--shoot
	local UDVector = mouse.UnitRay.Direction
	enabled = false
	
	
	if power > 0.7 * 2 then
		hjump:Play()
	else
		hstand:Play()		
	end
	
	local rLeg = character:FindFirstChild("Right Leg")
	script.Parent.NBallServer.BridgeEvent:FireServer('Header',UDVector,rLeg.Position,power,character)
	
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	
	wait(0.1)
	enabled = true
end

function onButton1Up()
	if held1 then
		held1 = false
	end
end



function onButton2Up()
	if held2 then
		held2 = false
	end
end


function onButton3Up()
	if held3 then
		held3 = false
	end
	charge:Stop()
	--if speed_enforce then
	speed_enforce:Disconnect()
	character.Humanoid.WalkSpeed = 21
	--end
end


function onHeaderUp()
	if header_down then
		header_down = false
	end
end

function inputChanged(IO,gPE,mouse)
--	print(tostring(IO.UserInputState).." : "..tostring(IO.UserInputType))
	if IO.UserInputType == Enum.UserInputType.MouseButton1 then -- LeftClick
		if IO.UserInputState == Enum.UserInputState.Begin then
			onMouse1ButtonDown(mouse);
		else
			onButton1Up(mouse);
		end
	elseif IO.UserInputType == Enum.UserInputType.MouseButton2 then -- RightClick
		if IO.UserInputState == Enum.UserInputState.Begin then
			onMouse2ButtonDown(mouse);
		else
			onButton2Up(mouse);
		end	
	elseif IO.UserInputType == Enum.UserInputType.MouseButton3 then -- MiddleClick
		if IO.UserInputState == Enum.UserInputState.Begin then
			onScrollButtonDown(mouse);
		else
			onButton3Up(mouse);
		end
	elseif IO.KeyCode == Enum.KeyCode.Q then -- Q
		if IO.UserInputState == Enum.UserInputState.Begin then
			onHeaderDown(mouse)
		else
			onHeaderUp(mouse)
		end
	elseif IO.KeyCode == Enum.KeyCode.X then
		if IO.UserInputState == Enum.UserInputState.Begin and not gPE then
			if held1 or held2 or held3 or header_down then
				shotcancelled = true
			end
		end
	end
end

function loadTool()
	mouse = player:GetMouse()
	if mouse == nil then
		return
	end
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	conn1 = userInput.InputBegan:Connect(function(I,G) inputChanged(I,G,mouse)end)
	conn2 = userInput.InputEnded:Connect(function(I,G) inputChanged(I,G,mouse)end)
	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	human = character:WaitForChild("Humanoid")
	kick = human:LoadAnimation(Tool.soccerkick)
	charge = human:LoadAnimation(Tool.chargekick)
	hstand = human:LoadAnimation(Tool.headerstand)
	hstand.Priority = Enum.AnimationPriority.Action
	hjump = human:LoadAnimation(Tool.headerjump)
	hjump.Priority = Enum.AnimationPriority.Action	
end


--[[
function onTouched(part)
	if human then
	human.WalkSpeed = 16
	end
	if shooting then
		local pos = Tool.Handle.Position
		Tool.Parent = game.Workspace
		Tool.Handle.Position = pos
		return
	end
end]]--

function unloadTool()
	held1 = false
	held2 = false
	held3 = false
	header_down = false
	conn1:Disconnect()
	conn2:Disconnect()
	mouse.Icon = "rbxasset://textures\\advancedMove.png"
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.08, 0),"In","Linear",0.1, true)	
end

--Tool.Handle.Touched:connect(onTouched)
Tool.Equipped:connect(loadTool)
Tool.Unequipped:connect(unloadTool)
--Tool.Unequipped:connect(onUnequippedLocal)