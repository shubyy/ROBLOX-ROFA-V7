local saved = workspace:WaitForChild("Sounds"):WaitForChild("Saved")
local start = workspace:WaitForChild("Sounds"):WaitForChild("Start")
local goal = workspace:WaitForChild("Sounds"):WaitForChild("GoalScored")


wait(3)
for _, each in pairs(script.Parent:GetChildren()) do
	if each.Name == "GoalMiss" then
		each.Touched:Connect(function(hit)
			if hit.Name == "SSBall" then
				local speed = hit.Velocity.Magnitude
				if speed > 41 then
					if saved.IsPlaying ~= true and goal.IsPlaying ~= true and start.Playing == true then
						saved.Volume = start.Volume + 0.2
						saved:Play()
					end
				end
			end
		end)
	end
end