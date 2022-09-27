--Will use FIFA charge.

local Tool = script.Parent
local debris = game:GetService("Debris")
local human = nil
local db = true
local maxDistance = 10 --Default reach reduction
local module = require(2550971891)


function shoot(plr,velarg,posarg,ball,driven)
	if plr and velarg and posarg then
		ball:SetNetworkOwner(nil)
		local kick = ball:WaitForChild("kick2")
		ball.LastShot.Value = plr.Name
		ball.Position = posarg or ball.Position
		ball.RotVelocity = Vector3.new(0,0,0)
		ball.Velocity = velarg
		local old_bf = ball:FindFirstChild("BodyForce")
		if old_bf then 
			old_bf:Destroy()
		end
		local grav = Instance.new("BodyForce")
		grav.Parent = ball
		if driven == true then
			grav.Force = Vector3.new(0, (ball:GetMass() * 196.2) * 0.75, 0)
			local dip = script.Script:Clone()
			dip.Parent = ball
			dip.Disabled = false
		else
			grav.Force = Vector3.new(0, 65, 0)
		end
		ball.PlayerOnBall.Value = nil
		kick:Play()
		wait(.2)
	end
end



script.BridgeEvent.OnServerEvent:connect(function(plr,arg,mouse,rLeg,temptime,char)
	if plr then
		if arg == 'LClick' then
			shoot(plr,module.LClick(mouse,char,rLeg,plr,temptime))
		elseif arg == 'RClick' then
			shoot(plr,module.RClick(mouse,char,rLeg,plr,temptime))
		elseif arg == 'DrivenShot' then
			shoot(plr,module.DRClick(mouse,char,rLeg,plr,temptime))
		elseif arg == 'MClick' then
			shoot(plr,module.MClick(mouse,char,rLeg,plr,temptime))
		elseif arg == 'Header' then
			if char.Header.Value == true then return end --Debounce check
			char.Header.Value = true
			wait(0.5)
			local part1 = Instance.new("Part")
			part1.Size = Vector3.new(10,10,10)
			part1.Shape = Enum.PartType.Ball
			part1.Anchored = true
			part1.Transparency = 1
			part1.CanCollide = false
			part1.Parent = workspace
			part1.Name = "hitspace"
			part1.CFrame = char.Head.CFrame + Vector3.new(0,1,0)
			local obj = Instance.new("ObjectValue")
			obj.Parent = part1
			obj.Name = "HeadPlayer"
			obj.Value = plr
			
			c = char.Header.HeaderEvent.Event:Connect(function(ball)
				shoot(plr,module.Header(mouse,char,rLeg,plr,temptime,ball))
				char.Header.Value = false
				c:Disconnect()			
			end)
			
			wait(1)
			char.Header.Value = false
			part1:Destroy()
			c:Disconnect()
		end
	end
end)
