local tool = script.Parent
local foam = tool:WaitForChild('RemoteEvent')
local down = false
local uis = game:GetService('UserInputService')
local con1
local con2

uis.InputBegan:Connect(function(key, gpe)
	if gpe then return end
	if key.KeyCode == Enum.KeyCode.T then
		foam:FireServer(nil, 'clear')
	end
end)

tool.Equipped:Connect(function(mouse)
	con1 = mouse.Button1Down:Connect(function()
		down = true
		while down do
			foam:FireServer(mouse.Hit)
			wait(0.05)
		end
	end)
	con2 = mouse.Button1Up:Connect(function()
		down = false
	end)
end)

tool.Unequipped:Connect(function()
	con1:Disconnect()
	con2:Disconnect()
	down = false
end)