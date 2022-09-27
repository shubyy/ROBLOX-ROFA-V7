local tool = script.Parent
local player = game.Players.LocalPlayer
repeat wait() until player.Character
local character = player.Character
local hrp = character:WaitForChild("HumanoidRootPart")
local hum = character:WaitForChild("Humanoid")

local mouse = player:GetMouse()
local event = tool:WaitForChild("RemoteEvent")
local equipped = false

tool.Equipped:Connect(function()
	equipped = true
end)

tool.Unequipped:Connect(function()
	equipped = false
end)

--Trip player
mouse.Button1Down:Connect(function()
	if not equipped then return end
	local target = mouse.Target
	if target.Parent:FindFirstChild("Humanoid") then
		local plr = game.Players:GetPlayerFromCharacter(target.Parent)
		if plr and (hrp.Position - target.Position).Magnitude < 7 then
			character.Humanoid.WalkSpeed = 0
			event:FireServer("Grab", plr)
			local speed_enforce = character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				character.Humanoid.WalkSpeed = 0
			end)
			wait(3.5)
			speed_enforce:Disconnect()
		end
	end
end)


