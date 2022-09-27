
local goalsFolder = script.Parent.Parent.Parent.Goals

local def = game.ReplicatedStorage:WaitForChild("YellowDefBlue")

local mode = true

function swapsides()
	local pos = workspace:FindFirstChild("RedDefense").CFrame
	workspace:FindFirstChild("RedDefense").CFrame = workspace:FindFirstChild("BlueDefense").CFrame
	workspace:FindFirstChild("BlueDefense").CFrame = pos
	
	if def.Value == 1 then
		def.Value = 0
	else
		def.Value = 1
	end
end

script.Parent.Parent.Event.Event:connect(function(argument,arg2)
	print(argument,arg2)
	if argument == "Swap" then
		local tgr = goalsFolder.GoalRed.Score.Value
		local tgb = goalsFolder.GoalBlue.Score.Value
		goalsFolder.GoalRed.Score.Value = tgb
		goalsFolder.GoalBlue.Score.Value = tgr
		swapsides()
	end
	if arg2 == 'Score' then
		local goalsRed = goalsFolder.GoalRed.Score.Value
		local goalsBlue = goalsFolder.GoalBlue.Score.Value
		script.Parent.SurfaceGui.TextLabel.Text = tostring(goalsRed)..'-'..tostring(goalsBlue)
	end
end)
--local winCondition = 10 --Max amount of goals

--script.Parent.Event.Event:connect(function(argument)
----	if argument == 'winRed' then
----		win('Red')
----		return
----	elseif argument == 'winBlue' then
----		win('Blue')
----		return
----	elseif argument == 'Tied' then
----		win('Tied')
----		return
----	end
--	local goalRed = script.Parent.Parent.GoalRed.Score.SurfaceGui.TextLabel.Text
--	local goalBlue = script.Parent.Parent.GoalBlue.Score.SurfaceGui.TextLabel.Text
--	script.Parent.SurfaceGui.TextLabel.Text = tostring(goalBlue)..'-'..tostring(goalRed)
----	if tonumber(goalRed) >= winCondition then
----		win('Red')
----	elseif tonumber(goalBlue) >= winCondition then
----		win('Blue')
----	end
--end)

--function win(team)
--	if team == 'Red' then
--		winGui.Visible = true
--		winGui.BackgroundColor3 = BrickColor.Red().Color
--		winGui.Text = 'Red has won this game!'
--	elseif team == 'Blue' then
--		winGui.Visible = true
--		winGui.BackgroundColor3 = BrickColor.Blue().Color
--		winGui.Text = 'Blue has won this game!'	
--	elseif team == 'Tied' then
--		winGui.Visible = true
--		winGui.BackgroundColor3 = BrickColor.Green().Color
--		winGui.Text = 'It was a tie!'		
--	end
--	script.Parent.Parent.Time.Event:Fire('Reset')
--	script.Parent.SurfaceGui.TextBox.Text = 'Resetting...'
--	wait(5)
--	winGui.Visible = false
--	goalRed.Text = 0
--	goalBlue.Text = 0
--	script.Parent.SurfaceGui.TextLabel.Text = '0-0'
--	script.Parent.SurfaceGui.TextBox.Text = 'Score'
--end