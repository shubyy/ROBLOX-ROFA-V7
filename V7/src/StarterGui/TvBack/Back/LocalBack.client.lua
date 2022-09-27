wait(1)
event = game.Players.LocalPlayer.Character:WaitForChild("TvScript"):WaitForChild("Event")
script.Parent.MouseButton1Click:connect(function()
	event:FireServer("Back")
	script.Parent.Parent.Enabled = false
end)
