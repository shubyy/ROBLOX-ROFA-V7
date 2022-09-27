--Credit to Madattak on the dev forums for the system
local ClickPart = script.Parent --Rename to whichever part has the clickdetector



ClickPart.ClickDetector.MouseClick:connect(function(p)
	if p.TeamColor == BrickColor.new('Bright green') then
		changeScore(-1,'Blue')
		script.Parent.Parent.Parent.Scoreboard.Event:Fire(nil,'Score')
	end
end)

function changeScore(val,team)
	local map = script.Parent.Parent.Parent.Goals
	for i, part in pairs(map:GetChildren()) do
		if string.find(part.Name,team) then
			local score = part.Score
			score.Value = score.Value + val
		end
	end
end