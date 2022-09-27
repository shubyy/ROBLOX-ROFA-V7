
local tool = script.Parent
local gui = tool:WaitForChild("Info")
local player = game.Players.LocalPlayer
local debounce = true


tool.Activated:Connect(function()
	if debounce then
		debounce = false
		local newgui = gui:Clone()
		local timetable = os.date("*t")
		local timetext = timetable.hour .. ":" .. timetable.min .. ":" .. timetable.sec 
		local datetext = timetable.day .. "/" .. timetable.month .. "/" .. timetable.year
		newgui:WaitForChild("Time").Text = "Time: " .. timetext .. "   " .. datetext 
		newgui:WaitForChild("Stadium").Text = "Stadium: " .. game.Name
		newgui:WaitForChild("User").Text = "Player: " .. player.Name
		local reftext = ""
		for i, each in pairs(game.Teams:WaitForChild("Referee"):GetPlayers()) do
			if i > 1 then
				reftext = reftext .. ","
			end
			reftext = reftext .. each.Name
		end
		newgui:WaitForChild("Ref").Text = "Referee(s): " .. reftext
		newgui.Parent = player:WaitForChild("PlayerGui")
		wait(10)
		newgui:Destroy()
		debounce = true
	end
end)