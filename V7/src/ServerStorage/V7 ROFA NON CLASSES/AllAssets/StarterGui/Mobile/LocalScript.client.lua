--[[
	Remake to work with the old legacy code so therefore is scrappy at places
	--IcedVapour
--]]

local player = game.Players.LocalPlayer
repeat wait() until player.Character
local character = player.Character
local rLeg = character:FindFirstChild("Right Leg")

local camera = workspace.CurrentCamera

local uis = game:GetService("UserInputService")
local frame = script.Parent:WaitForChild("Frame")

local shoot = frame:WaitForChild("Shoot")
local sprintbutton = frame:WaitForChild("Sprint")
local switchleg = frame:WaitForChild("SwitchShot")
local leftImage = 'rbxassetid://982594859'
local rightImage = 'rbxassetid://982596117'
local leftleg = true


local PlayerGui = script.Parent.Parent

local held1 = false
local held2 = false
local empty = false
local hum = character:WaitForChild("Humanoid")
local sprinting = false
local recharging = false
local stamina = 40
local isprinting = false
local kick = hum:LoadAnimation(character:WaitForChild("soccerkick"))

local event = character:WaitForChild("NBallServer"):WaitForChild("BridgeEvent")

if not uis.TouchEnabled then
	script:Destroy()
else
	frame.Visible = true
end

function sprinty(a,b,c)
--	print(tostring(a)..'-'..tostring(b)..'-'..tostring(c))
	while sprinting do
		stamina = stamina - 1
		wait(.1)
		if stamina <= 0 then
		    hum.WalkSpeed = 21
			sprinting = false
			empty = true
			recharge()
		end
	end
end


shoot.MouseButton1Down:Connect(function()
	if held1 == true then return end
	held1 = true
	local power = 0
	held1 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1.5, true)
	while held1 do
		if power < 3 then
			power = power + .2
		end
		wait(.1)
	end
	held1 = false
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0,0,0.05,0),"In","Linear",0.1,true)
	local UDVector = camera.CFrame.LookVector
	kick:Play()
	if leftleg == true then
		event:FireServer('LClick',UDVector,rLeg,power,character)
	else
		event:FireServer('RClick',UDVector,rLeg,power,character)
	end
	wait(0.1)
end)

shoot.MouseButton1Up:Connect(function()
	held1 = false
end)

switchleg.Activated:Connect(function()
	if leftleg == true then
		leftleg = false
		switchleg.Image = rightImage
	else
		leftleg = true
		switchleg.Image = leftImage
	end
end)

function recharge()
	player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",(40-stamina)/40 * 2,true)
	while stamina < 40 do
		if empty == true then
			--player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.new(1, 0, 0)
			if sprinting then recharging = false return end
			recharging = true
			stamina = stamina + 2
		elseif empty == false then
			--player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.fromRGB(0, 170, 255)	
			if sprinting then recharging = false return end
			recharging = true
			stamina = stamina + 2
		end
		wait(.1)
	end
	recharging = false
	empty = false
end

local function sprinty(a,b,c)
--	print(tostring(a)..'-'..tostring(b)..'-'..tostring(c))
	while sprinting do
		stamina = stamina - 1
		wait(.1)
		if stamina <= 0 then
			if hum.WalkSpeed ~= 0 then
		     	hum.WalkSpeed = 21 
			end
			sprinting = false
			empty = true
			recharge()
		end
	end
end

function sprint(b)
	if b == false then --
		hum.WalkSpeed = 21
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
			hum.WalkSpeed = 32	
			sprinty()	
		end
	end
end

sprintbutton.Activated:Connect(function()
	if isprinting == false then
		sprintbutton.Image = 'rbxassetid://987790167'
		isprinting = true
	else
		sprintbutton.Image = 'rbxassetid://987789884'
		isprinting = false
	end
	sprint(isprinting)
end)





