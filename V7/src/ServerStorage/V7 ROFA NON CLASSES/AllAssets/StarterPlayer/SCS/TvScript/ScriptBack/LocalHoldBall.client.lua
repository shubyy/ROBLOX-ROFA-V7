--Handles the possession gui
local char = script.Parent
local plr = game.Players:GetPlayerFromCharacter(char)

function Equip()
	if plr.PlayerGui:FindFirstChild("Possession") then
		plr.PlayerGui.Possession.ImageLabel.Visible = true
	end
end

function unEquip()
	if plr.PlayerGui:FindFirstChild("Possession") then
		plr.PlayerGui.Possession.ImageLabel.Visible = false
	end
end











script.Parent:WaitForChild("Torso").DescendantAdded:connect(function(des)
	if des.Name == "BallWeld" then
		Equip()
	end 
end)

script.Parent:WaitForChild("Torso").DescendantRemoving:connect(function(des)
	if des.Name == "BallWeld" then
		unEquip()
	end
end)