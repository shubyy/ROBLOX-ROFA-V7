ap = require(game.ReplicatedFirst.TrelloAPI)
BoardID = ap:GetBoardID("Ratings Database")
event = script.Parent:WaitForChild("Event")

event.OnServerEvent:connect(function(player, Command, Name)
	
	if Command == "Back" and player.Name == script.Parent.Parent.Name then
	
		player.Character.LaptopScript.RatingLaptop.Value = false
		wait(1)
		script.Parent.Stuff.Value = ""
	  	
	elseif Command == "Search" and player.Name == script.Parent.Parent.Name  then
	
		local ListID = ap:GetListID("Rating",BoardID)
		if ap:GetCardID(Name,BoardID) == nil then
			
			script.Parent.Stuff.Value = Name.." doesn't exist, or has no assigned rating"
			event:FireClient(player)
		else		
			local CardID = ap:GetCardID(Name,BoardID)
			local info = ap:GetCardInfo(CardID,BoardID)
			script.Parent.Stuff.Value = Name.." rating is: "..info["desc"]
			event:FireClient(player)
		end
		
	  	
	end
end)
