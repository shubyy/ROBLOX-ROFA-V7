local sparkleevent = game.ReplicatedStorage:WaitForChild("SparkleEvent")

--function findSpark(player)
--	local id = player.UserId
--	
--	if id == 15804769 then --				Alib432
--		return 'rbxassetid://499621264'
--	elseif id == 151871260 then --			RO-Football
--		return 'rbxassetid://500707336'
--	else --									Default
--		return 'rbxassetid://489920501'	
--	end		
--end

sparkleevent.OnServerEvent:connect(function(player,arg,char)
	local sparkId = player.SparkImage.Value
	if arg == 'full' then
		local spark = game.ReplicatedStorage.ParticleEmitter:Clone()
--		if player.UserId == 15804769 then
--			spark.Texture = 'rbxassetid://499621264'
--		end
		spark.Texture = sparkId
--		spark.Texture = findSpark(player)
		spark.Parent = char.Torso
		spark.Color = ColorSequence.new(player.TeamColor.Color,player.TeamColor.Color)
		game.Debris:AddItem(spark,2)
	elseif arg == 'empty' then
		local spark = game.ReplicatedStorage.ParticleEmitter:Clone()
--		if player.UserId == 15804769 then
--			spark.Texture = 'rbxassetid://499621264'
--		end
		spark.Texture = sparkId
		spark.Parent = char.Torso
		spark.Color = ColorSequence.new(Color3.new(0,0,0),Color3.new(0,0,0))
		game.Debris:AddItem(spark,2)		
	end	
end)