
local skillevent = script.Parent:WaitForChild("SkillEvent")
local debris = game:GetService("Debris")
local ball = nil
local moving = false
local jumping = false

skillevent.OnServerEvent:Connect(function(...)
	local tuple = {...}
	local player = tuple[1]
	local req = tuple[2]
	
	local character = player.Character
	
	if req == "Skill" then
		local direction = tuple[3]
		local power = tuple[4]
		if character and ball and not moving then
			if ball:FindFirstChild("SkillController").Value ~= player then
				return
			end
			local distanceBetweenBall = (ball.Position - character.Torso.Position).Magnitude
			if distanceBetweenBall < 22 then
				moving = true
				ball.Velocity = ball.Velocity * 0.1
				local bf = Instance.new("BodyForce")
				bf.Parent = ball
				bf.Force = direction * 8 * power
				
				wait(.1)
				bf:Destroy()
				moving = false
			end
		end
	elseif req == "Jump" then
		if ball and ball.Parent == workspace and not jumping then
			if ball:FindFirstChild("SkillController").Value ~= player then
				return
			end
			local distanceBetweenBall = (ball.Position - character.Torso.Position).Magnitude
			if distanceBetweenBall < 15 then
				jumping = true
				print("jumping server")
				ball.Velocity = ball.Velocity * 0.25
				local bf = Instance.new("BodyForce")
				bf.Parent = ball
				bf.Force = Vector3.new(0, 1400, 0)
				
				wait(.2)
				bf:Destroy()
				jumping = false
			end
		end
	elseif req == "Start" then
		local torso = character:FindFirstChild("Torso")
		local ballweld = torso:FindFirstChild("BallWeld")
		if ballweld or ball then
			if not ball or ball.Parent ~= workspace then
				ball = ballweld.Part1
			end
			if ball and ball.Parent == workspace then
				ball:FindFirstChild("SkillController").Value = player
				ball:FindFirstChild("PlayerOnBall").Value = nil
				ball:SetNetworkOwner(nil)
				if ballweld then
					ballweld:Destroy()
				end
			end
		end
	elseif req == "End" then
		if ball then
			ball:FindFirstChild("SkillController").Value = nil
		end
	end
	
end)