local sounds = script.Parent
local crowd = sounds:WaitForChild("Start")
local goal_scored = sounds:WaitForChild("GoalScored")

goal_scored.Played:Connect(function()
	wait(13)
	while goal_scored.Volume > 0 do
		goal_scored.Volume = goal_scored.Volume - 0.005
		if goal_scored.Volume <= 0.02 then
			goal_scored:Stop()
		end
		wait(.1)
	end
end)


function updatevol(vol)
	if vol < crowd.Volume then
		while vol < crowd.Volume do
			crowd.Volume = crowd.Volume - 0.05
			wait(0.7)
		end
	elseif vol > crowd.Volume then
		while vol > crowd.Volume do
			crowd.Volume = crowd.Volume + 0.05
			wait(0.7)
		end
	end
end


while true do
	local crowdnum = #game.Players:GetPlayers()
	if crowd.IsPlaying ~= true then
		wait(10)
	else
		if crowdnum < 16 then		
			updatevol(0.2)
		elseif crowdnum > 30 then
			updatevol(0.6)
		else
			vol = (crowdnum / 30) * 0.6
			updatevol(vol)
		end
		wait(10)
	end
end
	

	
	
	
	
	