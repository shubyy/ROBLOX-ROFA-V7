--repeat wait() until game.Players.LocalPlayer
local player = game.Players.LocalPlayer
local contextAction = game:GetService("ContextActionService")
contextAction:BindAction('name',print,true,'123232')
contextAction:SetPosition('name',UDim2.new(2,2,2,2))

if not player:FindFirstChild("Mobile") then
	if player.PlayerGui:FindFirstChild("ContextActionGui") then
		script.Parent.MobileDetect.RemoteEvent:FireServer()		
		player.PlayerGui.Mobile.Frame.Visible = true
--		local mb = Instance.new("BoolValue")
--		mb.Name = "Mobile"
--		mb.Parent = player
--		mb.Value = true
	end
end

local player = game.Players.LocalPlayer