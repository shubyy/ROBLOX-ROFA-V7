local Tool = script.Parent;

enabled = true




function onActivated()
	if not enabled  then
		return
	end

	enabled = false
	Tool.Handle.DrinkSound:Play()

	wait()
	
	local h = Tool.Parent:FindFirstChild("Humanoid")
	if (h ~= nil) then
		if (h.MaxHealth > h.Health + 0) then
			h.Health = h.Health + 0
		else	
			h.Health = h.MaxHealth
		end
	end

	enabled = true

end

function onEquipped()
	Tool.Handle.OpenSound:play()
	wait(2)
	Tool.Handle.OpenSound:stop()
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
