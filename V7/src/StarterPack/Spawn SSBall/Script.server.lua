local ball = game.ServerStorage.SSBall


script.Parent.RemoteEvent.OnServerEvent:connect(function(plr,arg)
	if not plr:FindFirstChild("BallObject") then
		local BallObject = Instance.new("ObjectValue")
		BallObject.Parent = plr
		BallObject.Name = "BallObject"
		plr.CharacterRemoving:connect(function()
			if plr.BallObject.Value then
				plr.BallObject.Value:Destroy() 
				plr.BallObject.Value = nil				
			end
		end)
	end
	if arg == "Spawn" then
		local c = nil
		if plr:FindFirstChild("BallObject") then
			if plr.BallObject.Value  and plr.BallObject.Value.Parent ~= nil then
				c = plr.BallObject.Value
			else
				plr.BallObject.Value = nil
				c = ball:Clone()
				plr.BallObject.Value = c
			end
		end
		c.Velocity = Vector3.new(0,0,0)
		c.RotVelocity = Vector3.new(0,0,0)
		c.Parent = workspace
		c.Position = plr.Character.Head.Position	
	elseif arg == "DestroyGlobal" then
		if plr:FindFirstChild("BallObject") then
			if plr.BallObject.Value then
				plr.BallObject.Value:Destroy()
			end
		end	
	elseif arg == "DestroyLocal" then
		if plr.Character then
			if plr.Character:FindFirstChild("Torso") then
				if plr.Character.Torso:FindFirstChild("BallWeld") then
					plr.Character.Torso.BallWeld.Part1:Destroy()
				end
			end
		end
	end
end)

