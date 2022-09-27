local player = game.Players.LocalPlayer
local enabled = true

script.Parent.Activated:connect(function()
	if enabled then
		script.Parent.RemoteEvent:FireServer('Spawn')
		enabled = false
		wait(1)
		enabled = true
	else
		return
	end
end)

local uis = game:GetService("UserInputService")

function passOn(I,O)
	print(I.KeyCode.Value)
	if I.KeyCode.Value == 116 then
		script.Parent.RemoteEvent:FireServer('DestroyGlobal')
	elseif I.KeyCode.Value == 107 then
		script.Parent.RemoteEvent:FireServer('DestroyLocal')
	end
end

script.Parent.Equipped:connect(function()
	conn = uis.InputBegan:connect(passOn)	
end)

script.Parent.Unequipped:connect(function()
	conn:Disconnect()
end)

script.Parent.RemoteEvent:FireServer()