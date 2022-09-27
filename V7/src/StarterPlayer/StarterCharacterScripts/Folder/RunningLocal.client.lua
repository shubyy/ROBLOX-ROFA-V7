local pingevent = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild(script.Name)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
repeat wait() until player.Character and player.Character:FindFirstChild("Humanoid")
local char = player.Character
local stamina = 40
local hum = char.Humanoid
local event = game.ReplicatedStorage:WaitForChild("GameEvents")
local sparkleevent = game.ReplicatedStorage:WaitForChild("SparkleEvent")
hum.WalkSpeed = 21
local recharging = false
local class = game.Players.LocalPlayer:WaitForChild("CurrentClass")
--local coro = true
local gui = player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("ImageLabel")

local empty = false
local contextAction = game:GetService("ContextActionService")
local num = 0
local connection = nil
local humanoidbool = true
local maxJump = 100

local maxstam = 70
local stamdepscale = 1
local stamina = maxstam

local jumping = false
local entered = false
local execcounter = 0

local runspeed = 31
local normspeed = 24
local normjumppower = 50


function sprinty(a,b,c)
--	print(tostring(a)..'-'..tostring(b)..'-'..tostring(c))
	while sprinting do
		stamina = stamina - stamdepscale
		player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new( stamina/maxstam * 0.46 ,0, 0.05, 0),"In","Linear", .07,true)
		wait(.1)
		if stamina <= 0 then
			hum.WalkSpeed = normspeed
			sprinting = false
			empty = true
		end
	end
	recharge()
end


function sprint(a,b,c)
	if b == Enum.UserInputState.End then --
		hum.WalkSpeed = normspeed
		sprinting = false
		recharge()
	else --	
		if stamina > 0 and hum.WalkSpeed ~= 0 then
			if empty == true then
				if stamina < 15 then
					return
				end
			end
			sprinting = true
			hum.WalkSpeed = runspeed
			sprinty()	
		end
	end
end

contextAction:BindAction(
    'SprintButton',
    sprint,
    true,
    'f'
)

contextAction:BindAction(
    'SprintButton2',
    sprint,
    false,
    Enum.KeyCode.LeftControl
)	
local udimX = UDim.new(2,0)
local udimY = UDim.new(2,0)
contextAction:SetPosition('SprintButton',UDim2.new(udimX,udimY))


function recharge()
	if recharging == true then return end
	
	execcounter = execcounter + 1
	wait(.3)
	execcounter = execcounter - 1
	if execcounter > 0 then
		return
	end
	
	if recharging == true then return end
	recharging = true
	while stamina < maxstam do
			--gui.InfoGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if sprinting then 
			recharging = false 
			return 
		end
		
		if stamina > 8 then
			empty = false
		end
		
		stamina = stamina + 1.5
		player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new( stamina/maxstam * 0.46 ,0, 0.05, 0),"In","Linear", .09,true)
		wait(.1)
	end
	recharging = false
	empty = false
end



hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
	if char:FindFirstChild("Humanoid") then
		local currentwalkspeed = char.Humanoid.WalkSpeed
		if sprinting then
			if currentwalkspeed > (runspeed + .1) then
				pingevent:FireServer("Chk", 3, currentwalkspeed)
			end
		else
			if currentwalkspeed > (normspeed + .1) then
				pingevent:FireServer("Chk", 3, currentwalkspeed)
			end
		end
		--event:FireServer("Clientside character walkspeed tampering detected.")
	end
end)

--[[
hum:GetPropertyChangedSignal("JumpPower"):Connect(function()
	if char:FindFirstChild("Humanoid") and char.Humanoid.JumpPower >  then
		print(maxJump)
		print(char.Humanoid.JumpPower)
		--player:Kick("Violation 1.2")
		--event:FireServer("Clientside character jumppower tampering detected.")
	end
end)
]]--

function sparkle(arg)
	sparkleevent:FireServer(arg, char)
end

local function updateclass()
	repeat wait() until class.Value ~= "0"
	local classfolder = game.ReplicatedStorage:WaitForChild("ClassInformation"):WaitForChild(tostring(class.Value))
	
	
	local stamval = classfolder:WaitForChild("Stamina").Value
	local speedval = classfolder:WaitForChild("Speed").Value 
	
	local jumpVal = classfolder:WaitForChild("Agility").Value 
	maxJump = (jumpVal)*1.2 + 40
	
	local speedscale = (speedval) * 0.37
	stamdepscale = stamval * (0.5-2.3)/20 + 2.3
	
	runspeed = 31 + speedscale
	normjumppower = maxJump
end

updateclass()



pingevent.OnClientEvent:Connect(function(msg)
	if msg == "Ping" then
		pingevent:FireServer("Ping")
	end
end)


if player:GetRankInGroup(2912781) < 3 then
	hum.Touched:Connect(function(hit)
		if hit.Name == "Field" and player.Team.Name ~= "Referee" then
			player:Kick("Pitch Invading")
		end
	end)
end

--[[
	Violations:
	1.1 WalkSpeed > highest value
--]]

event.OnClientEvent:Connect(function(msg)
	if msg == "CharLoad" then
		print("CHARLOAD")
		local char = player.Character
		
		for _, each in pairs(char:GetDescendants()) do
			if each:IsA("BasePart") then
				each:GetPropertyChangedSignal("Size"):Connect(function()
					if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
						pingevent:FireServer("Chk", 1, each, each.Size)
					end
				end)
			end
		end

		char.DescendantAdded:Connect(function(desc)
			if desc:IsA("BasePart") then
				if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
					--event:FireServer("Clientside character tampering detected.")
					pingevent:FireServer("Chk", 1, desc, desc.Size)
				end
			end
		end)
		
	end
end)



