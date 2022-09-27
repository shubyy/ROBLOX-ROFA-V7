
local curve = script.Parent:FindFirstChild("Curve")

if not curve then script:Destroy() end

while true do
	if curve.Force.Magnitude < 1 then
		curve:Destroy()
		script:Destroy()
	else
		curve.Force = curve.Force * 0.9
	end
	wait(0.08)
end



