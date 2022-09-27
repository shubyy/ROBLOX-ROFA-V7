player = game:WaitForChild("Players").LocalPlayer
char = player.Character
Watching = false
wait(1)
script:FindFirstChild("WatchingTv").Changed:connect(function(value)
	if value == true then
		if player.PlayerGui:FindFirstChild("Stamina") then
			player.PlayerGui.Stamina.Back.Visible = false
		end
		if player.PlayerGui:FindFirstChild("ChargeShot") then
			player.PlayerGui.ChargeShot.Back.Visible = false
		end
		Watching = true
		char.Torso.Anchored = true
		local target = workspace.TvFrame.TvScreen
		local camera = workspace.CurrentCamera
		camera.CameraType = Enum.CameraType.Scriptable
		camera.CameraSubject = target
		camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(15, 0, 0)* CFrame.Angles(math.pi,math.pi/2,math.pi)
--		camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(0, 0, -15)
		wait(.5)
		target.BrickColor = BrickColor.new("Lapis")
		
		wait(.5)
		for x =1,45 do
--	    	camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(0, 0, -15+x/5)* CFrame.Angles(math.pi,0,math.pi)
			camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(15-x/5, 0, 0)* CFrame.Angles(math.pi,math.pi/2,math.pi)
--			camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(0, 0, -15+x/5)
			wait()  
		end	
		wait(.5)
		
		target = workspace.Cameras.Camera
		camera.CameraSubject = target
		camera.CoordinateFrame =  CFrame.new(target.Position, Vector3.new(0,0,0))
		workspace.TvFrame.TvScreen.BrickColor = BrickColor.new("Really black")
		player.PlayerGui.TvBack.Enabled = true
		local closest = nil
		local person = nil
		while Watching == true do
			person = nil
			if workspace:FindFirstChild("SSBall") then
					person = workspace:FindFirstChild("SSBall")
			else
				local peeps = workspace:GetChildren()
				for e =1,#peeps do
					if peeps[e]:FindFirstChild("DevBall") and peeps[e]:FindFirstChild("Humanoid") and peeps[e]:FindFirstChild("DevBall"):FindFirstChild("Handle") then
						person = peeps[e].DevBall.Handle
					end
				end
				if person == nil then
					local peeps = game.Players:GetChildren()
					for e =1,#peeps do
						if peeps[e].TeamColor==BrickColor.new("Bright green")  then
							person = peeps[e].Character.Torso
						end
					end
				end
				if person == nil then 
					person = workspace.Cameras.DefaultPos
				end
			end
			
			
			local cams = workspace.Cameras:GetChildren()			
			for i = 1,#cams do
				if cams[i].Name ~= "DefaultPos" and person ~= nil then
					if closest == nil then
						closest = cams[i]
					else if (closest.Position -person.Position).magnitude >= (cams[i].Position -person.Position).magnitude + 10 then
						closest = cams[i]					
					end
				end
				
			end
			target = closest
			if person ~= nil then
			camera.CoordinateFrame =  CFrame.new(target.Position,person.Position)
			end
			if char.Humanoid.Health <=0 then
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
				game.Workspace.CurrentCamera.CameraType = "Custom"
				char.Torso.Anchored = false
				player.PlayerGui.TvBack.Enabled = false
				break
			end
			game:GetService("RunService").RenderStepped:wait()
		end
		end
		target = workspace.TvFrame.TvScreen
		for x =1,45 do
--	    	camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(0, 0, -6-x/5)* CFrame.Angles(math.pi,0,math.pi)
			camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new((x/5), 0, 0)* CFrame.Angles(math.pi,math.pi/2,math.pi)
			wait()  
			if char.Humanoid.Health <=0 then
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
				game.Workspace.CurrentCamera.CameraType = "Custom"
				char.Torso.Anchored = false
				player.PlayerGui.TvBack.Enabled = false
				break
			end
			
		end
		wait(.5)
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		game.Workspace.CurrentCamera.CameraType = "Custom"
		char.Torso.Anchored = false
		
	elseif value == false then
		if player.PlayerGui:FindFirstChild("Stamina") then
			player.PlayerGui.Stamina.Back.Visible = true
		end
		Watching = false
		
	end
	
end)

