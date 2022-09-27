local tier2 = game.ServerStorage:WaitForChild("Tier2", 5)
if tier2 then
	script:Destroy()
end

local teampositions = {}
local closestb = math.huge
local closestr = math.huge
local handle = script.Parent
local plronball = handle:WaitForChild("PlayerOnBall")
local lastshot = handle:WaitForChild("LastShot")
local bgoaldetection = workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):WaitForChild("GoalBlue"):WaitForChild("GoalDetection")
local rgoaldetection = workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):WaitForChild("GoalRed"):WaitForChild("GoalDetection")
local yellowteam = -1
local event = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local def = game.ReplicatedStorage:WaitForChild("YellowDefBlue")

local function offsidetrigger()
	event:FireAllClients("message", "Offside!")
end

function reset()
	closestb = math.huge
	closestr = math.huge
	teampositions = {}
	yellowteam = -1
end

plronball.Changed:Connect(function(prop)
	if plronball.Value == nil then
		--initialise data for offside checking
		local plrshot = game.Players:FindFirstChild(lastshot.Value)
		if not plrshot then
			return
		end
		
		if plrshot.TeamColor == BrickColor.new("Bright yellow") then
			for i,each in pairs(game.Players:GetPlayers()) do
				if each.Team == plrshot.Team then
					teampositions[each.Name] = each.Character.HumanoidRootPart.Position
				end
			end
			for _,each in pairs(game.Players:GetPlayers()) do
				--get closest to goal line
				if each.TeamColor == BrickColor.new("Bright red") and (not each.Backpack:FindFirstChild("Keeper")) and (not each.Character:FindFirstChild("Keeper")) then
					local playerpos = each.Character.HumanoidRootPart.Position
					if def.Value == 0 then
						local parallelposb = Vector3.new(playerpos.x, bgoaldetection.Position.y, bgoaldetection.Position.z)
						local distanceb = (playerpos - parallelposb).magnitude
						
						if distanceb < closestb then
							closestb = distanceb
						end
					else
						local parallelposr = Vector3.new(playerpos.x, rgoaldetection.Position.y, rgoaldetection.Position.z)
						local distancer = (playerpos - parallelposr).magnitude
						
						if distancer < closestr then
							closestr = distancer
						end
					end
				end
			end
			yellowteam = 0
		elseif plrshot.TeamColor == BrickColor.new("Bright red") then
			--store positions of each member of the team
			for i,each in pairs(game.Players:GetPlayers()) do
				if each.Team == plrshot.Team then
					teampositions[each.Name] = each.Character.HumanoidRootPart.Position
				end
			end
			-- retrieve closest player to goal line.
			
			for _,each in pairs(game.Players:GetPlayers()) do
				if each.TeamColor == BrickColor.new("Bright yellow") and (not each.Backpack:FindFirstChild("Keeper")) and (not each.Character:FindFirstChild("Keeper")) then
					local playerpos = each.Character.HumanoidRootPart.Position
					if def.Value == 1 then
						local parallelposb = Vector3.new(playerpos.x, bgoaldetection.Position.y, bgoaldetection.Position.z)
						local distanceb = (playerpos - parallelposb).magnitude
						
						if distanceb < closestb then
							closestb = distanceb
						end
					else
						local parallelposr = Vector3.new(playerpos.x, rgoaldetection.Position.y, rgoaldetection.Position.z)
						local distancer = (playerpos - parallelposr).magnitude
						
						if distancer < closestr then
							closestr = distancer
						end
					end
				end
			end
			yellowteam = 1
		end
	else
		--check initialised data to see if it violates offside rule.
		local plrwhotouched = plronball.Value
		if yellowteam == 1 then
			if (plrwhotouched.TeamColor == BrickColor.new("Bright yellow")) or (plrwhotouched == game.Players:FindFirstChild(lastshot.Value)) then
				reset()
				return
			end
			
			local playerpos = teampositions[plrwhotouched.Name]
			if playerpos == nil then
				reset()
				return
			end
			
			--check player who shot and see if he is offside
			local playerwhoshot = teampositions[lastshot.Value]
			
			if def.Value == 1 then
				local parallelposb = Vector3.new(playerpos.x, bgoaldetection.Position.y, bgoaldetection.Position.z)
				local distanceb = (playerpos - parallelposb).magnitude + 5
				local parallelposb2 = Vector3.new(playerwhoshot.x, bgoaldetection.Position.y, bgoaldetection.Position.z)
				local distanceb2 = (playerwhoshot - parallelposb2).magnitude + 5
				
				if distanceb > 304 then
					reset()
					return
				end
				
				if (distanceb < closestb) and (distanceb2 > closestb) then
					offsidetrigger()
				end
			else
				local parallelposr = Vector3.new(playerpos.x, rgoaldetection.Position.y, rgoaldetection.Position.z)
				local distancer = (playerpos - parallelposr).magnitude + 5
				local parallelposr2 = Vector3.new(playerwhoshot.x, rgoaldetection.Position.y, rgoaldetection.Position.z)
				local distancer2 = (playerwhoshot - parallelposr2).magnitude + 5
				
				if distancer > 304 then
					reset()
					return
				end
				
				if (distancer < closestr) and (distancer2 > closestr) then
					offsidetrigger()
				end
			end			
		else
			if (plrwhotouched.TeamColor == BrickColor.new("Bright red")) or (plrwhotouched == game.Players:FindFirstChild(lastshot.Value)) then
				reset()
				return
			end
			
			local playerpos = teampositions[plrwhotouched.Name]
			if playerpos == nil then
				reset()
				return
			end
			
			local playerwhoshot = teampositions[lastshot.Value]
			
			if def.Value == 0 then
				local parallelposb = Vector3.new(playerpos.x, bgoaldetection.Position.y, bgoaldetection.Position.z)
				local distanceb = (playerpos - parallelposb).magnitude + 5
				local parallelposb2 = Vector3.new(playerwhoshot.x, bgoaldetection.Position.y, bgoaldetection.Position.z)
				local distanceb2 = (playerwhoshot - parallelposb2).magnitude + 5
				
				if distanceb > 304 then
					reset()
					return
				end
				
				if (distanceb < closestb) and (distanceb2 > closestb) then
					offsidetrigger()
				end
			else
				local parallelposr = Vector3.new(playerpos.x, rgoaldetection.Position.y, rgoaldetection.Position.z)
				local distancer = (playerpos - parallelposr).magnitude + 5
				local parallelposr2 = Vector3.new(playerwhoshot.x, rgoaldetection.Position.y, rgoaldetection.Position.z)
				local distancer2 = (playerwhoshot - parallelposr2).magnitude + 5
				
				if distancer > 304 then
					reset()
					return
				end
				
				if (distancer < closestr) and (distancer2 > closestr) then
					offsidetrigger()
				end
			end
		end
		reset()
	end		
end)