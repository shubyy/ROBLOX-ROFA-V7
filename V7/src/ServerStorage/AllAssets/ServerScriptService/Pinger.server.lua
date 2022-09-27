local remotes = game.ReplicatedStorage:WaitForChild("Remotes")
local pingevent = remotes:WaitForChild("PingEvent")
local event = game.ReplicatedStorage:WaitForChild("GameEvents")
local pingstore = {}
local misscounter = {}
local asciiletters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
local strlength = 8

local function generateName()
	local namestring = ""
	for i=1,strlength,1 do
		local position = math.random(1, #asciiletters)
		namestring = namestring .. string.sub(asciiletters, position , position)
	end
	return namestring
end


pingevent.OnServerEvent:Connect(function(plr, cmd, chk, obj, size)
	print(obj)
	
	if cmd == "Chk" then
		if chk == 1 then
			if plr and plr.Character then
				if obj then
					if obj.Size ~= size then
						plr:Kick()
						print("Size difference: " .. tostring(obj.Size) .. " : " .. tostring(size) )
						event:FireAllClients("message", plr.Name .. " attempted using clientside HBE.")
					end
				else
					plr:Kick()
					print("unknown object added: " )
					event:FireAllClients("message", plr.Name .. " attempted using clientside HBE.")
				end
			end
		elseif chk == 2 then
			if obj == nil then
				plr:Kick()
				print("attempted clientside fling" .. tostring(plr.Name) )
				event:FireAllClients("message", plr.Name .. " attempted clientside flinging")
			end
		elseif chk == 3 then
			if plr.Character and plr.Character:FindFirstChild("Humanoid") then
				if plr.Character.Humanoid.WalkSpeed ~= obj then
					plr:Kick()
					print("attempted speed tampering" .. tostring(plr.Name) )
					event:FireAllClients("message", plr.Name .. " attempted clientside speed tampering")
				end
			end
		end
	end
end)


pingevent.OnServerEvent:Connect(function(plr, msg)
	if msg == "Ping" then
		if pingstore[plr.Name] then
			local ping = math.floor((tick() - pingstore[plr.Name]) * 1000)
			pingstore[plr.Name] = nil
			misscounter[plr.Name] = nil
			plr:WaitForChild("leaderstats"):WaitForChild("Ping").Value = ping
		end
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	local ping = Instance.new("IntValue")
	ping.Name = "Ping"
	ping.Parent = player:WaitForChild("leaderstats")
	ping.Value = 0
end)

game.Players.PlayerRemoving:Connect(function(player)
	if pingstore[player.Name] then
		pingstore[player.Name] = nil
		misscounter[player.Name] = nil
	end
end)

local function obsecure()
	local folder = game.StarterPlayer.StarterCharacterScripts:WaitForChild("Folder")
	local realrunninglocal = folder:WaitForChild("RunningLocal")
	local fakerunninglocal = folder:WaitForChild("FakeRunningLocal")
	
	local realName = generateName()
	realrunninglocal.Name = realName
	pingevent.Name = realName
	realrunninglocal.Disabled = false
	
	for i=1,100,1 do
		local fakename = generateName()
		local clonescript = fakerunninglocal:Clone()
		clonescript.Name = fakename
		clonescript.Parent = folder
		
		local fakeevent = Instance.new("RemoteEvent")
		fakeevent.Name = generateName()
		fakeevent.Parent = remotes
	end
	
	fakerunninglocal:Destroy()
end

obsecure()

while true do
	for _, each in pairs(game.Players:GetPlayers()) do
		if not pingstore[each.Name] then
			pingstore[each.Name] = tick()
			pingevent:FireClient(each, "Ping")
		else
			local lastpingseconds = tick() - pingstore[each.Name]
			local lastping = math.floor(lastpingseconds * 1000)
			
			print("last ping seconds " .. tostring(lastpingseconds))
			
			if lastpingseconds > 1 then
				pingstore[each.Name] = nil
				if misscounter[each.Name] then
					misscounter[each.Name] = misscounter[each.Name] + 1
				else
					misscounter[each.Name] = 1
				end
				
				if misscounter[each.Name] >= 25 then
					each:Kick("Integrity Check Failed.")
				end
				each:WaitForChild("leaderstats"):WaitForChild("Ping").Value = 500
			end
		end
		wait()
	end
	wait(.5)
end