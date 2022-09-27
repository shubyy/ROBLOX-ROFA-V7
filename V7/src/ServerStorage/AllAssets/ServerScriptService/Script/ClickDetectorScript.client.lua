repeat wait() until game.Players.LocalPlayer
player = game.Players.LocalPlayer
Mouse = player:GetMouse()

Mouse.Button1Down:connect(function ()
	if Mouse.Target then
		if Mouse.Target:FindFirstChild("ClickEvent") and player:DistanceFromCharacter(Mouse.Target.Position) <= Mouse.Target.ClickDetector.MaxActivationDistance then
		--Found clickable object
			Mouse.Target.ClickEvent:FireServer(player)
		end
	end
end)