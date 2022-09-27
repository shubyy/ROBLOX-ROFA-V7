player = game:WaitForChild("Players").LocalPlayer
char = player.Character
Watching = false
wait(1)
script:FindFirstChild("RatingLaptop").Changed:connect(function(value)
	if value == true then
		Watching = true
		char.Torso.Anchored = true
		local target = workspace.RatingLaptop.Screen
		local camera = workspace.CurrentCamera
		camera.CameraType = Enum.CameraType.Scriptable
		camera.CameraSubject = target
		camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(0,0,5)* CFrame.Angles(0,math.pi*2,0)
		wait(.5)
		for x =1,23 do
	    	camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(0, 0, 5-x/5)* CFrame.Angles(0,math.pi*2,0)
			wait()  
		end
		wait(.5)
		target.BrickColor = BrickColor.new("Lapis")
		player.PlayerGui.RatingLP.Enabled = true
		wait(.5)
		while Watching == true do
			if char.Humanoid.Health <=0 then
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
				game.Workspace.CurrentCamera.CameraType = "Custom"
				char.Torso.Anchored = false
				player.PlayerGui.RatingLP.Enabled = false
				workspace.RatingLaptop.Screen.BrickColor = BrickColor.new("Really black")
				break
			end
			wait(.1)
		end
		wait(.5)
		for x =1,23 do
			camera.CoordinateFrame = CFrame.new(target.Position)  * CFrame.new(0, 0, .4+x/5)* CFrame.Angles(0,math.pi*2,0)
			wait()  
			if char.Humanoid.Health <=0 then
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
				game.Workspace.CurrentCamera.CameraType = "Custom"
				char.Torso.Anchored = false
				player.PlayerGui.RatingLP.Enabled = false
				workspace.RatingLaptop.Screen.BrickColor = BrickColor.new("Really black")
				break
			end
			
		end
		wait(.5)
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		game.Workspace.CurrentCamera.CameraType = "Custom"
		char.Torso.Anchored = false
		
	elseif value == false then
		Watching = false
		workspace.RatingLaptop.Screen.BrickColor = BrickColor.new("Really black")
		
	end
	
end)

