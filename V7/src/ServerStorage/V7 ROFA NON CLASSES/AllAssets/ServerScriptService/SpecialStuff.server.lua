
local module = require(2582963263)
local ss = game:GetService("ServerStorage")
local airpods = ss:WaitForChild("AirPods")
local leagueName = game.ReplicatedStorage:WaitForChild("LeagueName")
local event = game.ReplicatedStorage:WaitForChild("GameEvents")
local logs = game.ServerStorage:WaitForChild("ExploitLogs")

game.Players.PlayerAdded:Connect(function(player)

	for _,each in pairs(module.stadiumpass) do
		if game.Players:GetUserIdFromNameAsync(each) == player.UserId then
			player.Team = game.Teams:WaitForChild("Stadium Pass")
			break
		end
	end
	for _,each in pairs(module.adminstadiumpass) do
		if game.Players:GetUserIdFromNameAsync(each) == player.UserId then
			player.Team = game.Teams:WaitForChild("Stadium Pass")
			break
		end
	end
	for _,each in pairs(module.airpods) do
		if game.Players:GetUserIdFromNameAsync(each) == player.UserId then
			player.CharacterAdded:Connect(function(char)
				local Hat = Instance.new("Hat")
				Hat.Name = "Headphones"
				Hat.AttachmentForward = Vector3.new(0, 0, 1)
				Hat.AttachmentPos = Vector3.new(0, 0.300000012, 0)
				Hat.AttachmentRight = Vector3.new(1, 0, 0)
				Hat.AttachmentUp = Vector3.new(0, 1, 0)
				local Handle = airpods:Clone()
				Handle.Anchored = false
				Handle.Locked = true
				Handle.CanCollide = true
				Handle.Name = "Handle"
				Handle.Parent = Hat
				Hat.Parent = char
			end)
		end
	end
end)

game.Teams:WaitForChild("Stadium Pass").PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		ss:WaitForChild("Spectate"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Boo"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Cheer"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Ace Brew"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Mike Ashley Special"):Clone().Parent = player:WaitForChild("Backpack")
	end)
end)

game.Teams:WaitForChild("Referee").PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if string.lower(string.sub(msg, 1, 8)) == ":toggle " then
			local league = string.lower(string.sub(msg, 9))
			leagueName.Value = league
		--[[elseif string.lower(string.sub(msg, 1, 7)) == ":exlogs" then
			print("cmd logs")
			local info = {}
			for _,each in pairs(logs:GetChildren()) do
				info[each.Name] = each.Value
			end
			event:FireClient(player, "exlogs")]]--
		end
	end)
end)




