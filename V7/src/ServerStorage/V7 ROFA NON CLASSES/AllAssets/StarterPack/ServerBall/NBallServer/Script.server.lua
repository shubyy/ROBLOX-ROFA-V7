
wait(0.7)

local grav = script.parent:FindFirstChild("BodyForce")
local hit = false

script.Parent.Touched:Connect(function(hit)
	if hit.Name == "Field" and not hit then
		hit = true
		script.Parent.Velocity = script.Parent.Velocity * 0.75
		script:Destroy()
	end
end)

if grav then
	while grav.Force.Magnitude > 65 do
		grav.Force = grav.Force * 0.85
		wait(.1)
	end
	
end

script:Destroy()


