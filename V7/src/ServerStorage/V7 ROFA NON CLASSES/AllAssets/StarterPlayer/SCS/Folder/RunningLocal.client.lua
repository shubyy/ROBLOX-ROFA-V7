local pingevent = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild(script.Name)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
repeat wait() until player.Character and player.Character:FindFirstChild("Humanoid")
local char = player.Character
local stamina = 40
local hum = char.Humanoid
local event = game.ReplicatedStorage:WaitForChild("GameEvents")
local walkspeed = 24
local runspeed = 35
local recharging = false
--local coro = true
local gui = player:WaitForChild("PlayerGui")
local empty = false
local contextAction = game:GetService("ContextActionService")
local num = 0
local connection = nil
local humanoidbool = true

function sprinty(a,b,c)
--	print(tostring(a)..'-'..tostring(b)..'-'..tostring(c))
	while sprinting do
		stamina = stamina - 1
		wait(.1)
		if stamina <= 0 then
		    hum.WalkSpeed = walkspeed
			sprinting = false
			empty = true
			recharge()
		end
	end
end

function sprint(a,b,c)
	if b == Enum.UserInputState.End then --
		hum.WalkSpeed = walkspeed
		sprinting = false
		player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",(40-stamina)/40 * 2,true)
		if empty then return end
		if recharging == true then return end
		recharge()
	else --	
		if stamina > 0 and hum.WalkSpeed ~= 0 then
			if empty then return end
			sprinting = true
			player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new(0 , 0, 0.05, 0),"In","Linear",stamina/40 * 4,true)
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
	player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",(40-stamina)/40 * 2,true)
	while stamina < 40 do
		if empty == true then
			--player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.new(120, 0, 0)
			if sprinting then recharging = false return end
			recharging = true
			stamina = stamina + 1.3
		elseif empty == false then
			--player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.fromRGB(120, 0, 0)	
			if sprinting then recharging = false return end
			recharging = true
			stamina = stamina + 1.3
		end
		wait(.1)
	end
	recharging = false
	empty = false
end

hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
	if char:FindFirstChild("Humanoid") and not player:FindFirstChild("Mobile") then
		local currentwalkspeed = char.Humanoid.WalkSpeed
		if sprinting then
			if currentwalkspeed > (runspeed + .1) then
				pingevent:FireServer("Chk", 3, currentwalkspeed)
			end
		else
			if currentwalkspeed > (walkspeed + .1) then
				pingevent:FireServer("Chk", 3, currentwalkspeed)
			end
		end
		--event:FireServer("Clientside character walkspeed tampering detected.")
	end
end)



pingevent.OnClientEvent:Connect(function(msg)
	if msg == "Ping" then
		pingevent:FireServer("Ping")
	end
end)

for _, each in pairs(char:GetDescendants()) do
	if each:IsA("BasePart") then
		each:GetPropertyChangedSignal("Size"):Connect(function()
			if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
				local datatable = {}
				event:FireServer("Chk", 1, each, each.Size)
			end
		end)
	end
end

char.DescendantAdded:Connect(function(desc)
	if desc:IsA("BasePart") then
		if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
			--event:FireServer("Clientside character tampering detected.")
			
			local datatable = {}
			datatable["Name"] = desc
			datatable["Size"] = desc.Size
			event:FireServer("Chk", 1, desc, desc.Size)
		end
	end
end)


local function setupconn(desc)
	desc.DescendantAdded:Connect(function(obj)
		if obj.ClassName == "BodyAngularVelocity" or obj.ClassName == "BodyForce" or obj.ClassName == "BodyGyro" or obj.ClassName == "BodyPosition" or obj.ClassName == "BodyThrust" or obj.ClassName == "BodyVelocity" then
			local datatable = {}
			event:FireServer("Chk", 2, obj)
		end
	end)
end

game.Players.PlayerAdded:Connect(function(plr)
	if plr ~= player then
		plr.CharacterAdded:Connect(function(char)
			setupconn(char)
		end)
	end
end)

for _,each in pairs(game.Players:GetPlayers()) do
	if each and each ~= player and each.Character then
		setupconn(each.Character)
	end
	each.CharacterAdded:Connect(function(char)
		setupconn(char)
	end)
end


--[[
	Violations:
	1.1 WalkSpeed > highest value
--]]


--function sprinty(a,b,c)
----	print(tostring(a)..'-'..tostring(b)..'-'..tostring(c))
--while sprinting do
--	stamina = stamina - 1
--	wait(.1)
--	check()
--	if stamina <= 0 then
--		
--		hum.WalkSpeed = 21
--		sprinting = false
--		empty = true
--		recharge()
--	end
--end
--end


----function findSpark(player)
----	local id = player.UserId
----	
----	if id == 15804769 then --				Alib432
----		return 'rbxassetid://499621264'
----	elseif id == 151871260 then --			RO-Football
----		return 'rbxassetid://500707336'
----	else --									Default
----		return 'rbxassetid://489920501'	
----	end		
----end



----function sparkle(arg)
----	print(arg)
----	if arg == 'full' then
----		local spark = game.ReplicatedStorage.ParticleEmitter:Clone()
------		if player.UserId == 15804769 then
------			spark.Texture = 'rbxassetid://499621264'
------		end
----		spark.Texture = findSpark(player)
----		spark.Parent = char.Torso
----		spark.Color = ColorSequence.new(player.TeamColor.Color,player.TeamColor.Color)
----		game.Debris:AddItem(spark,1)
----	elseif arg == 'empty' then
----		local spark = game.ReplicatedStorage.ParticleEmitter:Clone()
------		if player.UserId == 15804769 then
------			spark.Texture = 'rbxassetid://499621264'
------		end
----		spark.Texture = findSpark(player)
----		spark.Parent = char.Torso
----		spark.Color = ColorSequence.new(Color3.new(0,0,0),Color3.new(0,0,0))
----		game.Debris:AddItem(spark,1)		
----	end
----end
