local camera = workspace.CurrentCamera
local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

tool.Activated:Connect(function()
	local part = mouse.Target
	local playertospectate = game.Players:GetPlayerFromCharacter(part.Parent)
	if playertospectate and part.Parent:FindFirstChild("Humanoid") and playertospectate.Team ~= game.Teams.Crowd then
		camera.CameraSubject = part.Parent.Humanoid
		camera.CameraType = Enum.CameraType.Follow
	end
end)

tool.Equipped:Connect(function()
	local numplayers = #game.Players:GetPlayers()
	local player = game.Players:GetPlayers()[math.random(1,numplayers)]
	local found = false
	while found == false do
		if numplayers > 0 and player.Team ~= game.Teams.Crowd and player.Team ~= game.Teams["Stadium Pass"] then
			found = true
			camera.CameraSubject = player.Character.Humanoid
			camera.CameraType = Enum.CameraType.Follow
			wait()
		else
			player = game.Players:GetPlayers()[math.random(1,numplayers)]
			wait()
		end
	end
end)

tool.Unequipped:Connect(function()
	camera.CameraSubject = player.Character.Humanoid
	camera.CameraType = Enum.CameraType.Custom
end)
