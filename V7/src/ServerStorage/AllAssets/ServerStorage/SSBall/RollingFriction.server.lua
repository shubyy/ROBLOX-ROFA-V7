local handle = script.Parent
local playeronball = handle:WaitForChild("PlayerOnBall")

playeronball.Changed:Connect(function(prop)
	wait(0.05)
	while playeronball.Value == nil do
		local parts = #handle:GetTouchingParts()
		if(parts > 0) then
			
			--calculate value for dampness from the velocity
			local scale = (handle.Velocity.Magnitude) * (0.9-0.96)/(200) + 0.95
			handle.Velocity = handle.Velocity * scale
		else
			local scale = (handle.Velocity.Magnitude) * (0.9825-0.995)/(200) + 0.995
			handle.Velocity = handle.Velocity * scale
		end
		wait(0.06)
	end
end)