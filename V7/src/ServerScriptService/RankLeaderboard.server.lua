local playerStats = {} --this keeps a list of the stats for each player that enters the game
 
local divBId = 3110794
local divOneId = 3262216
local divTwoId = 3262217
local divXId = 3541308
local divAlId = 3822834
local divSuperId = 3822764
local divZId = 3822815
local divSuperBId = 3822800
local divBravoId = 3822838

 game.Players.PlayerAdded:connect(function(player)
     local leaderstats = Instance.new("Model", player)
     leaderstats.Name = "leaderstats"
 
     local grouprole = Instance.new("StringValue", leaderstats)
	 grouprole.Name = "Role"
	 
	 local grouprank = Instance.new("IntValue", leaderstats)
	 grouprank.Name = "Rank"
	
	 local role = player:GetRoleInGroup(2912781) -- Insert the group ID for whatever group you want ranks displayed for here. 
	 grouprole.Value = role
	
	 local rank = player:GetRankInGroup(2912781)
	 grouprank.Value = rank
     if rank ~= 0 then
		if role == "Other Division Player" or rank == 3 then
			if player:GetRankInGroup(divBId) >= 2 then
				grouprole.Value = player:GetRoleInGroup(divBId)
			elseif player:GetRankInGroup(divOneId) >= 2 then
				grouprole.Value = player:GetRoleInGroup(divOneId)				
			elseif player:GetRankInGroup(divTwoId) >= 2 then
				grouprole.Value = player:GetRoleInGroup(divTwoId)
			elseif player:GetRankInGroup(divXId) >= 2 then
				grouprole.Value = player:GetRoleInGroup(divXId)
			elseif player:GetRankInGroup(divAlId) >= 2 then
				grouprole.Value = player:GetRoleInGroup(divAlId)	
			elseif player:GetRankInGroup(divSuperId) >= 2 then
				grouprole.Value = player:GetRoleInGroup(divSuperId)	
			elseif player:GetRankInGroup(divZId) >= 2 then
				grouprole.Value = player:GetRoleInGroup(divZId)	
			elseif player:GetRankInGroup(divSuperBId) >= 2 then 
				grouprole.Value = player:GetRoleInGroup(divSuperBId)
			elseif player:GetRankInGroup(divBravoId) >= 2 then 
				grouprole.Value = player:GetRoleInGroup(divBravoId)				
			else	
				grouprole.Value = "Other Division Player"
			end			
		elseif rank == 0 then
			grouprole.Value = "Visitor"
 		 else
			 grouprole.Value = role
		 end		
	 end
     playerStats[player] = leaderstats 
 end)
