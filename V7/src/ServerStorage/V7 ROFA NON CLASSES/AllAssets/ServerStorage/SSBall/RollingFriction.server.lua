local handle = script.Parent
local playeronball = handle:WaitForChild("PlayerOnBall")
local lastvel = math.huge

playeronball.Changed:Connect(function(prop)
	wait(0.05)
	while playeronball.Value == nil do
		local parts = #handle:GetTouchingParts()
		if(parts > 0) then
			--calculate value for dampness from the velocity
			local dampening =  handle.Velocity.Magnitude / 100
			if dampening > 1.17 then
				dampening = 1.17
			elseif dampening < 1.07 then
				dampening = 1.07
			end
			handle.Velocity = handle.Velocity * (1-(dampening-1))
		end
		wait(0.06)
		lastvel = handle.Velocity.Magnitude
	end
	lastvel = math.huge
end)