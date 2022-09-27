local tool = script.Parent
local animation = tool:WaitForChild("Celebration")
repeat wait() until tool.Parent.Name == "Backpack"
local player = tool.Parent.Parent
repeat wait() until player.Character
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")

tool.Activated:Connect(function()
	local loadedanim = humanoid:LoadAnimation(animation)
	loadedanim:Play()
	for _, each in pairs(player.Backpack:GetChildren()) do
		if each:FindFirstChild("Celebration") then
			each:Destroy()
		end
	end
	tool:Destroy()
end)

wait(5)
tool:Destroy()