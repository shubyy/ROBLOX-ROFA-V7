wait(10)
local player = game.Players.LocalPlayer
repeat wait() until player.Character
local event = game.ReplicatedStorage:WaitForChild("GameEvents")
local char = player.Character
local actualsizes = {}

repeat wait() until player:HasAppearanceLoaded()


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

	
