script.Parent.ClickDetector.MouseClick:connect(function(plr)
	if plr.TeamColor == BrickColor.new('Bright green') then
		script.Parent.Parent.Parent.Scoreboard.Event:Fire('Reset')
	end
end)