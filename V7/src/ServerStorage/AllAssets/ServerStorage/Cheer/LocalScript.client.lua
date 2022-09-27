local tool = script.Parent
local re = game.ReplicatedStorage:WaitForChild("Sounds")

tool.Activated:Connect(function()
	re:FireServer("Cheer")
end)

