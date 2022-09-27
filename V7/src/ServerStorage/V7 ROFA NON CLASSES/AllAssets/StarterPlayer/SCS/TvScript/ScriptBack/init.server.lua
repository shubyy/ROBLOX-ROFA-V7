
event = script.Parent:WaitForChild("Event")

event.OnServerEvent:connect(function(player, Command)
	
	if Command == "Back" and player.Name == script.Parent.Parent.Name then
	
		player.Character.TvScript.WatchingTv.Value = false
	  	
	end
end)
