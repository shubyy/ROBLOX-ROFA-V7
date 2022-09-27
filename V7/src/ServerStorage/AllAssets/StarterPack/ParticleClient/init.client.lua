local player = game.Players.LocalPlayer
local gui = player.PlayerGui
script:WaitForChild("RemoteEvent")
script.RemoteEvent.OnClientEvent:connect(function()
	local particle = gui:WaitForChild("ParticleGui")
	for i, button in pairs(particle.ParticleMenu:GetChildren()) do
		button.MouseButton1Down:connect(function()
			script.RemoteEvent:FireServer(button)
			particle:Destroy()
		end)
	end
end)