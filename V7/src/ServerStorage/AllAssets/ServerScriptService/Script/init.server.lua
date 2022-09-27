
local start = workspace:WaitForChild("Sounds"):WaitForChild("Start")
local event = game.ReplicatedStorage:WaitForChild("GameEvents")

game.Players.PlayerAdded:connect(function(p)
	local rank = p:GetRankInGroup(2912781)
	if p.Name == "alib432" or p.Name == "RO_FOOTBALL" or p.Name == "player1" then
		p.CharacterAdded:connect(function(c)
			game.ServerStorage["Spawn SSBall"]:Clone().Parent = p.Backpack			
		end)
	elseif p.Name == "Player1" or p.Name == "Player" then
		p.TeamColor = BrickColor.new("Bright green")
		p.CharacterAdded:connect(function(c)
			game.ServerStorage["Spawn SSBall"]:Clone().Parent = p.Backpack			
		end)
	elseif rank == 2 then
		p:WaitForChild("Backpack"):WaitForChild("ServerBall"):Destroy()
	end
	if #game.Players:GetPlayers() > 18 and #game.Teams.Referee:GetPlayers() > 0 and start.Playing ~= true then
		start:Play()
	end
end)
	
wait(2)

if not game.StarterPack:FindFirstChild("ClickDetectorScript") then
	clickScript = script.ClickDetectorScript
	clickScript:Clone().Parent = game.StarterPack
end