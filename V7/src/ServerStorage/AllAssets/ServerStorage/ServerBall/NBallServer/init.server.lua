--Will use FIFA charge.

local Tool = script.Parent
local debris = game:GetService("Debris")
local human = nil
local db = true
--local module = require(script:WaitForChild("MainModule"))
local module = require(884762080)

function shoot(plr,velarg,posarg,ball,driven,forcedir)
	if plr and velarg and posarg then
		local classfolder = game.ReplicatedStorage:WaitForChild("ClassInformation"):WaitForChild(tostring(plr:WaitForChild("CurrentClass").Value ))
		local powerval = classfolder:WaitForChild("Power").Value
		local powerscale = (powerval)*(1.1-0.9)/(20) + 0.9
		
		velarg = velarg * powerscale
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
		if forcedir and velarg.Magnitude > 95 then
			if velarg.Magnitude < 113 then
				forcedir = forcedir * 0.75
			end
			local curve = Instance.new("BodyForce")
			curve.Name = "Curve"
			curve.Parent = ball
			curve.Force = forcedir * 135
			
			local dec = script.Decreaser:Clone()
			dec.Parent = ball
			dec.Disabled = false
		end
		ball.PlayerOnBall.Value = nil
		kick:Play()
		wait(.2)
	end
end



script.BridgeEvent.OnServerEvent:connect(function(plr,arg,mouse,rLeg,temptime,char,forcedir)
	if plr then
		if arg == 'LClick' then
			shoot(plr,module.LClick(mouse,char,rLeg,plr,temptime,forcedir))
		elseif arg == 'RClick' then
			shoot(plr,module.RClick(mouse,char,rLeg,plr,temptime,forcedir))
		elseif arg == 'DrivenShot' then
			shoot(plr,module.DRClick(mouse,char,rLeg,plr,temptime,forcedir))
		elseif arg == 'MClick' then
			shoot(plr,module.MClick(mouse,char,rLeg,plr,temptime,forcedir))
		elseif arg == 'Header' then
			if char.Header.Value == true then return end --Debounce check
			char.Header.Value = true
			wait(0.2)
			local part1 = Instance.new("Part")
			part1.Size = Vector3.new(1.5,3.3,3.3)
			part1.Shape = Enum.PartType.Cylinder
			part1.Anchored = false
			part1.Transparency = 1
			part1.CanCollide = false
			part1.Parent = workspace
			part1.Name = "hitspace"
			part1.CFrame = char.Head.CFrame * CFrame.Angles(0,0,math.pi/2) + Vector3.new(0,0.5,0)
			local obj = Instance.new("ObjectValue")
			obj.Parent = part1
			obj.Name = "HeadPlayer"
			obj.Value = plr
			local bfr = CFrame.new(char.Head.Position)
			local weld = Instance.new("ManualWeld")
			weld.Part0 = char.Head
			weld.Part1 = part1
			weld.C0 = char.Head.CFrame:Inverse() * bfr
			weld.C1 = part1.CFrame:Inverse() * bfr
			weld.Parent = part1
			
			c = char.Header.HeaderEvent.Event:Connect(function(ball)
				shoot(plr,module.Header(mouse,char,rLeg,plr,temptime,ball))
				char.Header.Value = false
				c:Disconnect()			
			end)
			
			wait(0.7)
			char.Header.Value = false
			part1:Destroy()
			c:Disconnect()
		end
	end
end)
