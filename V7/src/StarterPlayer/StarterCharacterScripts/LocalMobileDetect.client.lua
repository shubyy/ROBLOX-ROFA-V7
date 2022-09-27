--repeat wait() until game.Players.LocalPlayer
local player = game.Players.LocalPlayer
local contextAction = game:GetService("ContextActionService")
contextAction:BindAction('name',print,true,'123232')
contextAction:SetPosition('name',UDim2.new(2,2,2,2))

if not player:FindFirstChild("Mobile") then
	if player.PlayerGui:FindFirstChild("ContextActionGui") then
		wait(.4)
		script.Parent.MobileDetect.RemoteEvent:FireServer()
		wait(.2)		
		if player.PlayerGui:FindFirstChild("Mobile") then
			player.PlayerGui.Mobile.Frame.Visible = true
		end
--		local mb = Instance.new("BoolValue")
--		mb.Name = "Mobile"
--		mb.Parent = player
--		mb.Value = true
	end
end