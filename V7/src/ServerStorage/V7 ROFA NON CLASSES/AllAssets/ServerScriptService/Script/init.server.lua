
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

event.OnServerEvent:Connect(function(plr, cmd, chk, obj, size)
	print(obj)
	
	if cmd == "Chk" then
		if chk == 1 then
			if plr and plr.Character then
				if obj then
					if obj.Size ~= size then
						plr:Kick()
						print("Size difference: " .. tostring(obj.Size) .. " : " .. tostring(size) )
						event:FireAllClients(plr.Name .. " attempted using clientside HBE.")
					end
				else
					plr:Kick()
					print("unknown object added: " )
					event:FireAllClients(plr.Name .. " attempted using clientside HBE.")
				end
			end
		elseif chk == 2 then
			if obj == nil then
				plr:Kick()
				print("attempted clientside fling" .. tostring(plr.Name) )
				event:FireAllClients(plr.Name .. " attempted clientside flinging")
			end
		end
	end
end)
	
wait(2)

if not game.StarterPack:FindFirstChild("ClickDetectorScript") then
	clickScript = script.ClickDetectorScript
	clickScript:Clone().Parent = game.StarterPack
end