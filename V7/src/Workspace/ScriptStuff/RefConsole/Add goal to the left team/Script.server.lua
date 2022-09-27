script.Parent.ClickDetector.MouseClick:connect(function(plr)
	if plr.TeamColor == BrickColor.new('Bright green') then
		changeScore(1,'Blue')
		script.Parent.Parent.Parent.Scoreboard.Score.Event:Fire()
	end
end)

function changeScore(val,team)
	local map = script.Parent.Parent
	for i, part in pairs(map:GetChildren()) do
		if string.find(part.Name,team) then
			local score = part.Score
			score.Value = score.Value + val
		end
	end
end