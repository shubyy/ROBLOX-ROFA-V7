--local goalRed = script.Parent.Parent.GoalRed.Score.SurfaceGui.TextLabel
--local goalBlue = script.Parent.Parent.GoalBlue.Score.SurfaceGui.TextLabel

--local winGui = script.Parent.Parent.WinCondition.SurfaceGui.WinCondition
local maxTime = 7 --In seconds
local maxTime = maxTime * 60 --If you want to edit it with minutes instead, uncomment this one
local stime = maxTime
local mTiS = tostring(math.floor(maxTime/60))..':'..tostring(maxTime-(math.floor(maxTime/60)*maxTime))
--maxTime in String


script.Parent.Parent.Event.Event:connect(function(argument)
	if argument == 'Reset' then
		reset()
	elseif argument == 'Start' then
		if not playing then
			playing = true
			start()
		end
	elseif argument == 'Pause' then
		if playing then
			playing = false
			start()
		end
	elseif argument == 'Unpause' then
		if not playing then
			playing = true
			start()
		end
	elseif argument == 'FixGLT' then
		for i, part in pairs(workspace:GetChildren()) do
			if part.Name == "SSBall" then
				part:Destroy()
			end
		end
	end
end)




function reset()
	playing = false
	stime = maxTime
	script.Parent.SurfaceGui.TextLabel.Text = tostring(maxTime)..":00"
	script.Parent.SurfaceGui.TextBox.Text = 'Time'
end

function start()
	while playing do
		stime = stime - 1
		wait(1)
		local sec = stime-(math.floor(stime/60)*60)
		local TiS
		if sec < 10 then
			TiS = tostring(math.floor(stime/60))..':'..'0'..tostring(sec)
		else
			TiS = tostring(math.floor(stime/60))..':'..tostring(sec)	
		end
		script.Parent.SurfaceGui.TextLabel.Text = TiS
		if stime <= 0 then
			playing = false
			reset()			
--			local rg = tonumber(goalRed.Text)
--			local bg = tonumber(goalBlue.Text)
--			if rg > bg then
--					script.Parent.Parent.Score.Event:Fire('winRed')
--			elseif bg > rg then
--				script.Parent.Parent.Score.Event:Fire('winBlue')
--			elseif bg == rg then
--				script.Parent.Parent.Score.Event:Fire('Tied')
--			end
		end
	end
end