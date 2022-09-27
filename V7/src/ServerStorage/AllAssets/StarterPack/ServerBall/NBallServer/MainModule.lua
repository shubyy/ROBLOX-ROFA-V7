script = nil

local ball = {}

--local trelloApi = require(game.ServerScriptService.TrelloAPI)

--function ball.RR(part,Tool,db,human,max)
--	local humanoid = part.Parent:FindFirstChild("Humanoid")
--	
--	if humanoid ~= nil and humanoid ~= human then
--		if Tool.Parent ~= workspace then
--			if (Tool.Handle.Position - Tool.Parent.Torso.Position).magnitude >= max then return end		
--		end
--		if (Tool.Handle.Position - part.Position).magnitude >= max then return end		
--		if db == true then
--			Tool.Parent = humanoid.Parent
--			db = false
--			wait(1)	
--			db = true	
--		end
--
--	end
--	if Tool:FindFirstChild("Handle") then
--		if Tool.Handle:FindFirstChild("BodyPosition") then		
--			Tool.Handle.BodyPosition:Destroy()
--		end
--	end	
--end

--function checkSuspended(plr)
--	if trelloApi then
--		local boardId = trelloApi:GetBoardID("Ratings Database")
--		local playerList = trelloApi:GetListID("Blacklist",boardId)
--		local groupList = trelloApi:GetListID("Blacklisted Groups",boardId)
--		local groupIds = {}
--		for i, card in pairs(trelloApi:GetCardsInList(groupList)) do
--			local Id = string.sub(card["name"],1,7)
--			if plr:GetRankInGroup(Id) > 0 then
--				return true
--			end
--		end
--		for i, card in pairs(trelloApi:GetCardsInList(playerList)) do
--			local cardname = card["name"]
--			if plr.Name == card["name"] and (plr:GetRankInGroup(2912781) == 0 or plr:GetRankInGroup(2912781) == 2) then
--				return true
--			end

function ball.LClick(vector,char,rLeg,plr,temptime,forcedir) -- Left Click
	local torso = char:FindFirstChild("Torso")
	local head = char:FindFirstChild("Head")
	local human = char:FindFirstChild("Humanoid")
	--if checkSuspended(plr) then
		--human:Destroy()
		--head:Destroy()
		--return
	--end
	local weld = torso:FindFirstChild("BallWeld")
	if weld then
		ball = weld.Part1
		if ball then
--			local newTime = time() - temptime
--			if newTime > 3 then
--				if (math.floor(newTime/3)% 2 == 0) then
--					newTime = newTime%3	
--				else
--					newTime = 3 - (newTime%3)					
--				end
--			end
			local newTime = temptime
			local power = Xpower(newTime)
			
			local targetPos = human.TargetPoint
			local v = (targetPos - char.Head.Position).unit
		
			local lookAt = torso.CFrame.lookVector.unit
			local outFrontBuffer = 5
			local denom = math.abs(lookAt.x) + math.abs(lookAt.z)
		
			local xPos = (lookAt.x/denom) * outFrontBuffer
			local zPos = (lookAt.Z/denom) * outFrontBuffer

			local nPos = Vector3.new(ball.Position.x + xPos, rLeg.Position.y, ball.Position.z + zPos)
			weld:Destroy()
			return	(vector * power * 0.94),nPos,ball,false,forcedir	
					
		end --Ballend
	end --WeldEnd
end --FunctionEnd



function ball.MClick(vector,char,rLeg,plr,temptime,forcedir) -- Middle Click
	local human = char:FindFirstChild("Humanoid")
	local torso = char:FindFirstChild("Torso")
	local head = char:FindFirstChild("Head")	
	--if checkSuspended(plr) then
		--human:Destroy()
		--head:Destroy()
		--return
	--end
	local weld = torso:FindFirstChild("BallWeld")
	if weld then
		ball = weld.Part1
		if ball then
--			local newTime = time() - temptime
			local newTime = temptime
			if newTime < 5 then	human.WalkSpeed = 21 return end
			
			
			local newVel = 1.2 * 100
			local nVY = 1.2 * 600

			if math.abs(vector.X) * newVel > vector.Y * nVY then
				nVY = (math.abs(vector.X)+vector.Y)/2 * nVY
			elseif math.abs(vector.Z) * newVel > vector.Y * nVY then
				nVY = (math.abs(vector.Z)+vector.Y)/2 * nVY
			end

			nVY = nVY * 10
			
			local absVel = Vector3.new(vector.X * newVel,math.abs(vector.Y * nVY),vector.Z * newVel)
			if math.abs(vector.Y * nVY) < 40 then
				absVel = Vector3.new(vector.X * newVel, 40,vector.Z * newVel)
			elseif math.abs(vector.Y * nVY) < 200 then
				absVel = Vector3.new(vector.X * newVel,math.abs(vector.Y * nVY),vector.Z * newVel)
			elseif 	vector.Y * nVY > 200 then							
				absVel = Vector3.new(vector.X * newVel,200,vector.Z * newVel)
			else 
				absVel = Vector3.new(vector.X * newVel,40,vector.Z * newVel)
			end	
		
			local targetPos = human.TargetPoint
			local v = (targetPos - char.Head.Position).unit
		
			local lookAt = torso.CFrame.lookVector.unit
			local outFrontBuffer = 5
			local denom = math.abs(lookAt.x) + math.abs(lookAt.z)
		
			local xPos = (lookAt.x/denom) * outFrontBuffer
			local zPos = (lookAt.Z/denom) * outFrontBuffer

			local nPos = Vector3.new(ball.Position.x + xPos, rLeg.Position.y, ball.Position.z + zPos)
			if plr.Character then
				weld:Destroy()
			end			
			return	(absVel * 1.1),nPos,ball,false,forcedir
		end --Ballend
	end --WeldEnd	
end --FunctionEnd
			
			
			
function ball.Header(vector,char,head,plr,temptime,ball,forcedir) -- Header
	local torso = char:FindFirstChild("Torso")
	local head = char:FindFirstChild("Head")
	local human = char:FindFirstChild("Humanoid")
	--if checkSuspended(plr) then
		--human:Destroy()
		--head:Destroy()
		--return
	--end
	if ball then
--			local newTime = time() - temptime
--			if newTime > 3 then
--				if (math.floor(newTime/3)% 2 == 0) then
--					newTime = newTime%3	
--				else
--					newTime = 3 - (newTime%3)					
--				end
--			end
			local newTime = temptime
			if newTime > 4 then
				newTime = 4
			end
			local power = headXpower(newTime)
			local powery = headYpower(newTime)
			
			local newVel
			if math.abs(vector.Y * powery) < 20 * 1.5 then
				newVel = Vector3.new(vector.X * power, 20 * 1.5,vector.Z * power)
			elseif math.abs(vector.Y * powery) < 37.5 * 1.5 then
				newVel = Vector3.new(vector.X * power,math.abs(vector.Y * powery),vector.Z * power)
			elseif 	vector.Y * powery > 75 * 1.5 then							
				newVel = Vector3.new(vector.X * power,75 * 1.5,vector.Z * power)
			else 
				newVel = Vector3.new(vector.X * power,40 * 1.5,vector.Z * power)
			end			
			local targetPos = human.TargetPoint
			local v = (targetPos - char.Head.Position).unit
		
			local lookAt = torso.CFrame.lookVector.unit
			local outFrontBuffer = 5
			local denom = math.abs(lookAt.x) + math.abs(lookAt.z)
		
			local xPos = (lookAt.x/denom) * outFrontBuffer
			local zPos = (lookAt.Z/denom) * outFrontBuffer

--		ball.Position = Vector3.new(ball.Position.x + xPos, head.Position.y, ball.Position.z + zPos)
		local nPos = Vector3.new(ball.Position.x, head.Position.y + 1, ball.Position.z)
		if plr.Character then
			local weld = torso:FindFirstChild("BallWeld")
			if weld then
				weld:Destroy()
			end
		end		
		return	(newVel * 0.8),nPos,ball,false,forcedir
				
	end --Ballend
end --FunctionEnd


function ball.RClick(vector,char,rLeg,plr,temptime,forcedir) -- Right Click
	local human = char:FindFirstChild("Humanoid")
	local torso = char:FindFirstChild("Torso")
	local head = char:FindFirstChild("Head")	
	--if checkSuspended(plr) then
		--human:Destroy()
		--head:Destroy()
		--return
	--end
	local weld = torso:FindFirstChild("BallWeld")
	if weld then
		ball = weld.Part1
		if ball then
			local newTime = time() - temptime
			if newTime > 3 then
				if (math.floor(newTime/3)% 2 == 0) then
					newTime = newTime%3	
				else
					newTime = 3 - (newTime%3)					
				end
			end
			local power = nerfedXPower(newTime)
			local powery = Ypower(newTime)

			local newVel
--			if math.abs(vector.Y * powery) < 40 * 1.5 then
--				newVel = Vector3.new(vector.X * power, 40 * 1.5,vector.Z * power)
--			elseif math.abs(vector.Y * powery) < 75 * 1.5 then
--				newVel = Vector3.new(vector.X * power,math.abs(vector.Y * powery),vector.Z * power)
--			elseif 	vector.Y * powery > 75 * 1.5 then							
--				newVel = Vector3.new(vector.X * power,75 * 1.5,vector.Z * power)
--			else 
--				newVel = Vector3.new(vector.X * power,40 * 1.5,vector.Z * power)
--			end
			if math.abs(vector.Y * powery) < 40 * 1.5 then
				newVel = Vector3.new(vector.X * power, 40 * 1.5,vector.Z * power)
			elseif math.abs(vector.Y * powery) < 75 * 1.5 then
				newVel = Vector3.new(vector.X * power,math.abs(vector.Y * powery),vector.Z * power)
			elseif 	vector.Y * powery > 75 * 1.5 then							
				newVel = Vector3.new(vector.X * power,75 * 1.5,vector.Z * power)
			else 
				newVel = Vector3.new(vector.X * power,40 * 1.5,vector.Z * power)
			end			
			local targetPos = human.TargetPoint
			local v = (targetPos - char.Head.Position).unit
		
			local lookAt = torso.CFrame.lookVector.unit
			local outFrontBuffer = 5
			local denom = math.abs(lookAt.x) + math.abs(lookAt.z)
		
			local xPos = (lookAt.x/denom) * outFrontBuffer
			local zPos = (lookAt.Z/denom) * outFrontBuffer
	

			local nPos = Vector3.new(ball.Position.x + xPos, rLeg.Position.y, ball.Position.z + zPos)
			if plr.Character then
				weld:Destroy()
			end			
			return	(newVel*1.07),nPos,ball,false,forcedir
		end --Ballend
	end --WeldEnd
end --FunctionEnd



function ball.DRClick(vector,char,rLeg,plr,power,forcedir) -- Driven
	local human = char:FindFirstChild("Humanoid")
	local torso = char:FindFirstChild("Torso")	
	--if checkSuspended(plr) then
		--human:Destroy()
		--head:Destroy()
		--return
	--end
	local weld = torso:FindFirstChild("BallWeld")
	if weld then
		ball = weld.Part1
		if ball then
			
			local addition = (power/3) * 8
			local powerheightmulti = power * (0.2)/3 + 0.9
			
			local multiplier = 40 --range 40-49
			local newVel
			--local newVel = (char.Torso.CFrame * CFrame.Angles(math.pi/16, 0, 0)).lookVector * power * multiplier
			
			if vector.y < -0.82 or vector.y > 0.82 then
				newVel = Vector3.new(vector.x, 0.03, vector.z) * 3 * (multiplier)
			else
				newVel = Vector3.new(vector.x, 0.24 * powerheightmulti, vector.z) * 2.95 * (multiplier + addition)
			end
			
			--local newVel = Vector3.new(vector.x, 0.20, vector.z) * power * multiplier
					
			local targetPos = human.TargetPoint
			local v = (targetPos - char.Head.Position).unit
		
			local lookAt = torso.CFrame.lookVector.unit
			local outFrontBuffer = 5
			local denom = math.abs(lookAt.x) + math.abs(lookAt.z)
		
			local xPos = (lookAt.x/denom) * outFrontBuffer
			local zPos = (lookAt.Z/denom) * outFrontBuffer
	

			local nPos = Vector3.new(ball.Position.x + xPos, rLeg.Position.y, ball.Position.z + zPos)
			if plr.Character then
				weld:Destroy()
			end			
			return	newVel,nPos,ball,true,forcedir
		end --Ballend
	end --WeldEnd
end --FunctionEnd


function Xpower(t)
	power = (50/3) * t + 100
	return power
end

function nerfedXPower(t)
	power = (25/3) * t + 100
	return power
end

function headXpower(t)
	if t >= 0.7 * 4 then
		power = (25/3) * t + 100	
	else
		power = (25/6) * t + 100		
	end

	return power	
end

function Ypower(t)
	power = 1.1 * t + 500
	return power
end

function headYpower(t)
	if t >= 0.7 * 4 then
		power = 1.1 * t + 500
	else
		power = 0.55 * t + 250	
	end
	return power	
end

return ball
